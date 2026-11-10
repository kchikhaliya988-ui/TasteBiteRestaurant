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
    public partial class CartPage : System.Web.UI.Page
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

        string getUser()
        {
            if (Session["email"] != null)
            {
                return Session["email"].ToString();
            }
            if (Session["user"] != null)
            {
                return Session["user"].ToString();
            }
            return "Guest";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillCartGrid();
            }
        }

        void fillCartGrid()
        {
            string user = getUser();
            getcon();
            string qry = @"SELECT 
                c.CartId, 
                c.FoodId, 
                c.Quantity, 
                c.Price AS UnitPrice, 
                c.Total AS TotalPrice, 
                f.Name AS FoodName, 
                f.ImageUrl, 
                f.Category 
            FROM Cart_tbl c 
            INNER JOIN Foods f ON c.FoodId = f.FoodId 
            WHERE c.UserEmail = @UserEmail ORDER BY c.CartId DESC";

            da = new SqlDataAdapter(qry, con);
            da.SelectCommand.Parameters.AddWithValue("@UserEmail", user);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count == 0)
            {
                pnlEmptyCart.Visible = true;
                pnlFilledCart.Visible = false;
                btnClearCart.Visible = false;
            }
            else
            {
                pnlEmptyCart.Visible = false;
                pnlFilledCart.Visible = true;
                btnClearCart.Visible = true;

                rptCartItems.DataSource = ds;
                rptCartItems.DataBind();

                decimal subTotal = 0;
                int totalCount = 0;
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    subTotal += Convert.ToDecimal(row["TotalPrice"]);
                    totalCount += Convert.ToInt32(row["Quantity"]);
                }

                litItemCount.Text = totalCount.ToString();
                litSubTotal.Text = subTotal.ToString("0.00");

                decimal deliveryFee = 0;
                if (subTotal >= 300)
                {
                    deliveryFee = 0;
                    litFreeDeliveryBadge.Text = "<span class=\"badge bg-success-subtle text-success small ms-1\">FREE</span>";
                    litDeliveryFee.Text = "₹0";
                    pnlFreeShippingPrompt.Visible = false;
                }
                else
                {
                    deliveryFee = 40;
                    litFreeDeliveryBadge.Text = "";
                    litDeliveryFee.Text = "₹40";
                    litRemainingForFree.Text = (300.00m - subTotal).ToString("0");
                    pnlFreeShippingPrompt.Visible = true;
                }

                decimal tax = Math.Round(subTotal * 0.05m, 2);
                litTax.Text = tax.ToString("0.00");

                decimal discount = 0;
                if (Session["AppliedCoupon"] != null)
                {
                    string coupon = Session["AppliedCoupon"].ToString();
                    if (coupon == "TASTE20")
                    {
                        discount = Math.Round(subTotal * 0.20m, 2);
                    }
                    else if (coupon == "WELCOME50")
                    {
                        discount = Math.Min(50m, subTotal);
                    }

                    pnlCouponApplied.Visible = true;
                    pnlCouponInput.Visible = false;
                    litAppliedCoupon.Text = coupon;
                    litDiscountCodeName.Text = coupon;
                    litDiscountAmount.Text = discount.ToString("0.00");
                    pnlDiscountRow.Visible = true;
                }
                else
                {
                    pnlCouponApplied.Visible = false;
                    pnlCouponInput.Visible = true;
                    pnlDiscountRow.Visible = false;
                }

                decimal grandTotal = Math.Max(0, subTotal + deliveryFee + tax - discount);
                litGrandTotal.Text = grandTotal.ToString("0.00");
            }

            SiteMaster master = Master as SiteMaster;
            if (master != null)
            {
                master.UpdateCartBadge();
            }
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int foodId = Convert.ToInt32(e.CommandArgument);
            string user = getUser();

            if (e.CommandName == "Increase")
            {
                getcon();
                cmd = new SqlCommand("UPDATE Cart_tbl SET Quantity = Quantity + 1, Total = (Quantity + 1) * Price WHERE FoodId=@FoodId AND UserEmail=@UserEmail", con);
                cmd.Parameters.AddWithValue("@FoodId", foodId);
                cmd.Parameters.AddWithValue("@UserEmail", user);
                cmd.ExecuteNonQuery();
                con.Close();
                fillCartGrid();
            }
            else if (e.CommandName == "Decrease")
            {
                getcon();
                da = new SqlDataAdapter("SELECT Quantity FROM Cart_tbl WHERE FoodId=@FoodId AND UserEmail=@UserEmail", con);
                da.SelectCommand.Parameters.AddWithValue("@FoodId", foodId);
                da.SelectCommand.Parameters.AddWithValue("@UserEmail", user);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    int qty = Convert.ToInt32(ds.Tables[0].Rows[0]["Quantity"]);
                    if (qty > 1)
                    {
                        cmd = new SqlCommand("UPDATE Cart_tbl SET Quantity = Quantity - 1, Total = (Quantity - 1) * Price WHERE FoodId=@FoodId AND UserEmail=@UserEmail", con);
                        cmd.Parameters.AddWithValue("@FoodId", foodId);
                        cmd.Parameters.AddWithValue("@UserEmail", user);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        cmd = new SqlCommand("DELETE FROM Cart_tbl WHERE FoodId=@FoodId AND UserEmail=@UserEmail", con);
                        cmd.Parameters.AddWithValue("@FoodId", foodId);
                        cmd.Parameters.AddWithValue("@UserEmail", user);
                        cmd.ExecuteNonQuery();
                    }
                }
                con.Close();
                fillCartGrid();
            }
            else if (e.CommandName == "RemoveItem")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM Cart_tbl WHERE FoodId=@FoodId AND UserEmail=@UserEmail", con);
                cmd.Parameters.AddWithValue("@FoodId", foodId);
                cmd.Parameters.AddWithValue("@UserEmail", user);
                cmd.ExecuteNonQuery();
                con.Close();
                fillCartGrid();
                Response.Write("<script>alert('Item removed from Cart');</script>");
            }
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            string user = getUser();
            getcon();
            cmd = new SqlCommand("DELETE FROM Cart_tbl WHERE UserEmail=@UserEmail", con);
            cmd.Parameters.AddWithValue("@UserEmail", user);
            cmd.ExecuteNonQuery();
            con.Close();
            fillCartGrid();
            Response.Write("<script>alert('Cart cleared successfully');</script>");
        }

        protected void btnApplyCoupon_Click(object sender, EventArgs e)
        {
            string code = txtCoupon.Text.Trim().ToUpper();
            if (code == "TASTE20" || code == "WELCOME50")
            {
                Session["AppliedCoupon"] = code;
                fillCartGrid();
                Response.Write("<script>alert('Coupon applied successfully!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Invalid coupon code');</script>");
            }
        }

        protected void btnRemoveCoupon_Click(object sender, EventArgs e)
        {
            Session["AppliedCoupon"] = null;
            fillCartGrid();
        }
    }
}
