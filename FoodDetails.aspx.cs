using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace TasteBiteRestaurant
{
    public partial class FoodDetails : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        private int _foodId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out _foodId))
            {
                Response.Redirect("Menu.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillFoodDetails(_foodId);
            }
        }

        void fillFoodDetails(int id)
        {
            getcon();
            da = new SqlDataAdapter("select * from Foods where FoodId = @FoodId", con);
            da.SelectCommand.Parameters.AddWithValue("@FoodId", id);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                con.Close();
                Response.Redirect("Menu.aspx");
                return;
            }

            DataRow dr = ds.Tables[0].Rows[0];

            string name = dr["Name"].ToString();
            string category = dr["Category"].ToString();
            decimal price = Convert.ToDecimal(dr["Price"]);
            decimal originalPrice = dr["OriginalPrice"] != DBNull.Value ? Convert.ToDecimal(dr["OriginalPrice"]) : price;

            Page.Title = name;
            litBreadcrumbName.Text = name;
            hlCategory.Text = category;
            hlCategory.NavigateUrl = "Menu.aspx?category=" + Server.UrlEncode(category);

            imgFood.ImageUrl = dr["ImageUrl"].ToString();
            imgFood.AlternateText = name;

            if (originalPrice > price)
            {
                int disc = (int)Math.Round(((originalPrice - price) / originalPrice) * 100);
                lblDiscountBadge.Text = "<i class=\"bi bi-tag-fill me-1\"></i> -" + disc + "% OFF";
                lblDiscountBadge.Visible = true;
                lblOriginalPrice.Text = "₹" + originalPrice.ToString("0");
                lblOriginalPrice.Visible = true;
            }
            else
            {
                lblDiscountBadge.Visible = false;
                lblOriginalPrice.Visible = false;
            }

            lblChefSpecialBadge.Visible = Convert.ToBoolean(dr["IsChefSpecial"]);
            lblCategoryTag.Text = category;

            bool isVeg = Convert.ToBoolean(dr["IsVegetarian"]);
            if (isVeg)
            {
                lblDietaryTag.Text = "<i class=\"bi bi-circle-fill me-1\"></i> 100% Vegetarian";
                lblDietaryTag.CssClass = "badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-2";
            }
            else
            {
                lblDietaryTag.Text = "<i class=\"bi bi-triangle-fill me-1\"></i> Non-Vegetarian";
                lblDietaryTag.CssClass = "badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3 py-2";
            }

            lblSpicyTag.Visible = Convert.ToBoolean(dr["IsSpicy"]);

            litFoodName.Text = name;
            litRating.Text = Convert.ToDecimal(dr["Rating"]).ToString("0.0");
            litReviews.Text = dr["ReviewCount"].ToString();
            litPrepTime.Text = dr["PreparationTimeMinutes"].ToString();
            litPrice.Text = price.ToString("0.00");
            litDescription.Text = dr["Description"].ToString();

            string ingredients = dr["Ingredients"].ToString();
            if (!string.IsNullOrEmpty(ingredients))
            {
                string[] ingList = ingredients.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                List<string> cleanList = new List<string>();
                foreach (string item in ingList)
                {
                    cleanList.Add(item.Trim());
                }
                rptIngredients.DataSource = cleanList;
                rptIngredients.DataBind();
            }

            // Fetch Related items
            litRelatedCategory.Text = category;
            hlViewAllRelated.NavigateUrl = "Menu.aspx?category=" + Server.UrlEncode(category);

            SqlDataAdapter daRel = new SqlDataAdapter("select top 4 FoodId as Id, FoodId, Name, Price, Category, ImageUrl, Description from Foods where Category = @Category and FoodId != @FoodId", con);
            daRel.SelectCommand.Parameters.AddWithValue("@Category", category);
            daRel.SelectCommand.Parameters.AddWithValue("@FoodId", id);
            DataSet dsRel = new DataSet();
            daRel.Fill(dsRel);

            if (dsRel.Tables[0].Rows.Count > 0)
            {
                pnlRelated.Visible = true;
                rptRelatedFoods.DataSource = dsRel;
                rptRelatedFoods.DataBind();
            }
            else
            {
                pnlRelated.Visible = false;
            }

            con.Close();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int qty = 1;
            int.TryParse(txtQuantity.Text, out qty);
            if (qty < 1) qty = 1;

            addToCart(_foodId, qty);

            SiteMaster master = Master as SiteMaster;
            if (master != null)
            {
                master.UpdateCartBadge();
            }

            lblSuccessMessage.Text = "Item added to cart successfully!";
            pnlSuccess.Visible = true;
            Response.Write("<script>alert('Item added to Cart successfully!');</script>");
        }

        protected void rptRelatedFoods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int foodId = Convert.ToInt32(e.CommandArgument);
                addToCart(foodId, 1);

                SiteMaster master = Master as SiteMaster;
                if (master != null)
                {
                    master.UpdateCartBadge();
                }

                lblSuccessMessage.Text = "Item added to cart successfully!";
                pnlSuccess.Visible = true;
                Response.Write("<script>alert('Item added to Cart successfully!');</script>");
            }
        }

        void addToCart(int foodId, int qty)
        {
            string user = "Guest";
            if (Session["email"] != null)
            {
                user = Session["email"].ToString();
            }
            else if (Session["user"] != null)
            {
                user = Session["user"].ToString();
            }

            getcon();
            da = new SqlDataAdapter("select * from Cart_tbl where FoodId = @FoodId and UserEmail = @UserEmail", con);
            da.SelectCommand.Parameters.AddWithValue("@FoodId", foodId);
            da.SelectCommand.Parameters.AddWithValue("@UserEmail", user);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                int currentQty = Convert.ToInt32(ds.Tables[0].Rows[0]["Quantity"]);
                decimal price = Convert.ToDecimal(ds.Tables[0].Rows[0]["Price"]);
                int newQty = currentQty + qty;
                decimal newTotal = newQty * price;

                cmd = new SqlCommand("update Cart_tbl set Quantity = @Quantity, Total = @Total where FoodId = @FoodId and UserEmail = @UserEmail", con);
                cmd.Parameters.AddWithValue("@Quantity", newQty);
                cmd.Parameters.AddWithValue("@Total", newTotal);
                cmd.Parameters.AddWithValue("@FoodId", foodId);
                cmd.Parameters.AddWithValue("@UserEmail", user);
                cmd.ExecuteNonQuery();
            }
            else
            {
                SqlDataAdapter daFood = new SqlDataAdapter("select * from Foods where FoodId = @FoodId", con);
                daFood.SelectCommand.Parameters.AddWithValue("@FoodId", foodId);
                DataSet dsFood = new DataSet();
                daFood.Fill(dsFood);

                if (dsFood.Tables[0].Rows.Count > 0)
                {
                    decimal price = Convert.ToDecimal(dsFood.Tables[0].Rows[0]["Price"]);
                    decimal total = price * qty;
                    cmd = new SqlCommand("insert into Cart_tbl(FoodId, UserEmail, Quantity, Price, Total, AddedDate) values(@FoodId, @UserEmail, @Quantity, @Price, @Total, GETDATE())", con);
                    cmd.Parameters.AddWithValue("@FoodId", foodId);
                    cmd.Parameters.AddWithValue("@UserEmail", user);
                    cmd.Parameters.AddWithValue("@Quantity", qty);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@Total", total);
                    cmd.ExecuteNonQuery();
                }
            }
            con.Close();
        }
    }
}
