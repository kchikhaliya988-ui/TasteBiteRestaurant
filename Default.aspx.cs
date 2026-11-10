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
    public partial class Default : System.Web.UI.Page
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

        void fillPopularDishes()
        {
            getcon();
            da = new SqlDataAdapter("select top 6 * from Foods where IsPopular=1 or IsChefSpecial=1 order by FoodId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            dlPopular.DataSource = ds;
            dlPopular.DataBind();
            con.Close();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillPopularDishes();
            }
        }

        protected void dlPopular_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "addtocart")
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
