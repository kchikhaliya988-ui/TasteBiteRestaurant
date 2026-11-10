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
    public partial class Menu : System.Web.UI.Page
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

        public string CurrentCategory { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            CurrentCategory = Request.QueryString["category"];
            if (string.IsNullOrWhiteSpace(CurrentCategory))
            {
                CurrentCategory = "All";
            }

            if (!IsPostBack)
            {
                string searchParam = Request.QueryString["search"];
                if (!string.IsNullOrWhiteSpace(searchParam))
                {
                    txtSearch.Text = searchParam.Trim();
                    lblCategoryTitle.Text = "Search: " + searchParam.Trim();
                }
                else
                {
                    lblCategoryTitle.Text = CurrentCategory == "All" ? "All Dishes" : CurrentCategory;
                }
                bindMenu();
            }
        }

        void bindMenu()
        {
            getcon();
            string qry = @"SELECT 
                FoodId AS Id,
                FoodId,
                Name,
                Description,
                Category,
                Price,
                ISNULL(OriginalPrice, Price) AS OriginalPrice,
                ImageUrl,
                PreparationTimeMinutes,
                IsPopular,
                IsChefSpecial,
                IsVegetarian,
                IsSpicy,
                Rating,
                ReviewCount,
                Ingredients,
                CASE WHEN OriginalPrice > Price THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS HasDiscount,
                CASE WHEN OriginalPrice > Price THEN CAST(ROUND(((OriginalPrice - Price) / OriginalPrice) * 100, 0) AS INT) ELSE 0 END AS DiscountPercentage
            FROM Foods WHERE 1=1";

            if (!string.IsNullOrEmpty(CurrentCategory) && CurrentCategory != "All")
            {
                qry += " AND Category = @Category";
            }

            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                qry += " AND (Name LIKE @Search OR Description LIKE @Search OR Category LIKE @Search OR Ingredients LIKE @Search)";
            }

            qry += " ORDER BY FoodId DESC";

            da = new SqlDataAdapter(qry, con);
            if (!string.IsNullOrEmpty(CurrentCategory) && CurrentCategory != "All")
            {
                da.SelectCommand.Parameters.AddWithValue("@Category", CurrentCategory.Trim());
            }
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                string search = txtSearch.Text.Trim();
                da.SelectCommand.Parameters.AddWithValue("@Search", "%" + search + "%");
            }
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlNoResults.Visible = false;
                DataList1.Visible = true;
                DataList1.DataSource = ds;
                DataList1.DataBind();
                lblItemCountBadge.Text = ds.Tables[0].Rows.Count + " items";
            }
            else
            {
                pnlNoResults.Visible = true;
                DataList1.Visible = false;
                lblItemCountBadge.Text = "0 items";
            }
            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentCategory = "All";
            lblCategoryTitle.Text = string.IsNullOrEmpty(txtSearch.Text.Trim()) ? "All Dishes" : "Search: " + txtSearch.Text.Trim();
            bindMenu();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
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
