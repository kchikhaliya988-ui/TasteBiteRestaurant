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
    public partial class Checkout : System.Web.UI.Page
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
            string user = getUser();
            getcon();
            da = new SqlDataAdapter("SELECT COUNT(1) FROM Cart_tbl WHERE UserEmail = @UserEmail", con);
            da.SelectCommand.Parameters.AddWithValue("@UserEmail", user);
            int count = Convert.ToInt32(da.SelectCommand.ExecuteScalar());
            con.Close();

            if (count == 0)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillSummary();

                if (Session["user"] != null && string.IsNullOrEmpty(txtFullName.Text))
                {
                    txtFullName.Text = Session["user"].ToString();
                }
                if (Session["email"] != null && string.IsNullOrEmpty(txtEmail.Text))
                {
                    txtEmail.Text = Session["email"].ToString();
                }
            }
        }

        void fillSummary()
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

            rptSummaryItems.DataSource = ds;
            rptSummaryItems.DataBind();

            decimal subTotal = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                subTotal += Convert.ToDecimal(row["TotalPrice"]);
            }

            litSubTotal.Text = subTotal.ToString("0.00");

            decimal deliveryFee = subTotal >= 300 ? 0 : 40;
            litDeliveryFee.Text = deliveryFee == 0 ? "FREE" : "₹40";

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

                pnlDiscountRow.Visible = true;
                litCouponCode.Text = coupon;
                litDiscountAmount.Text = discount.ToString("0.00");
            }
            else
            {
                pnlDiscountRow.Visible = false;
            }

            decimal grandTotal = Math.Max(0, subTotal + deliveryFee + tax - discount);
            litGrandTotal.Text = grandTotal.ToString("0.00");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string user = getUser();
            getcon();

            // Fetch cart items
            string qry = @"SELECT 
                c.FoodId, 
                c.Quantity, 
                c.Price AS UnitPrice, 
                c.Total AS TotalPrice, 
                f.Name AS FoodName, 
                f.Category, 
                f.ImageUrl 
            FROM Cart_tbl c 
            INNER JOIN Foods f ON c.FoodId = f.FoodId 
            WHERE c.UserEmail = @UserEmail";

            da = new SqlDataAdapter(qry, con);
            da.SelectCommand.Parameters.AddWithValue("@UserEmail", user);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                con.Close();
                Response.Redirect("Cart.aspx");
                return;
            }

            decimal subTotal = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                subTotal += Convert.ToDecimal(row["TotalPrice"]);
            }

            decimal deliveryFee = subTotal >= 300 ? 0 : 40;
            decimal tax = Math.Round(subTotal * 0.05m, 2);

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
            }

            decimal grandTotal = Math.Max(0, subTotal + deliveryFee + tax - discount);
            string orderId = "TB-" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(1000, 9999);
            string paymentMethod = rdoCashOnDelivery.Checked ? "Cash on Delivery" : "Demo Online Payment";

            // Insert into Orders table
            string insertOrderSql = "INSERT INTO Orders (OrderId, OrderDate, CustomerName, MobileNumber, Email, DeliveryAddress, City, PostalCode, SpecialInstructions, PaymentMethod, SubTotal, DeliveryFee, Tax, DiscountAmount, GrandTotal, Status, EstimatedDeliveryMinutes) VALUES (@OrderId, GETDATE(), @CustomerName, @MobileNumber, @Email, @DeliveryAddress, @City, @PostalCode, @SpecialInstructions, @PaymentMethod, @SubTotal, @DeliveryFee, @Tax, @DiscountAmount, @GrandTotal, 'Order Placed & Confirmed', 30)";
            cmd = new SqlCommand(insertOrderSql, con);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@CustomerName", txtFullName.Text.Trim());
            cmd.Parameters.AddWithValue("@MobileNumber", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@DeliveryAddress", txtAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
            cmd.Parameters.AddWithValue("@PostalCode", txtPostalCode.Text.Trim());
            cmd.Parameters.AddWithValue("@SpecialInstructions", txtNotes.Text.Trim());
            cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
            cmd.Parameters.AddWithValue("@SubTotal", subTotal);
            cmd.Parameters.AddWithValue("@DeliveryFee", deliveryFee);
            cmd.Parameters.AddWithValue("@Tax", tax);
            cmd.Parameters.AddWithValue("@DiscountAmount", discount);
            cmd.Parameters.AddWithValue("@GrandTotal", grandTotal);
            cmd.ExecuteNonQuery();

            // Insert into OrderItems table
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                int fid = Convert.ToInt32(row["FoodId"]);
                string fnm = row["FoodName"].ToString();
                string cat = row["Category"].ToString();
                decimal uprice = Convert.ToDecimal(row["UnitPrice"]);
                int qty = Convert.ToInt32(row["Quantity"]);
                decimal tprice = Convert.ToDecimal(row["TotalPrice"]);
                string img = row["ImageUrl"].ToString();

                string itemSql = "INSERT INTO OrderItems (OrderId, FoodId, FoodName, Category, UnitPrice, Quantity, TotalPrice, ImageUrl) VALUES (@OrderId, @FoodId, @FoodName, @Category, @UnitPrice, @Quantity, @TotalPrice, @ImageUrl)";
                SqlCommand cmdItem = new SqlCommand(itemSql, con);
                cmdItem.Parameters.AddWithValue("@OrderId", orderId);
                cmdItem.Parameters.AddWithValue("@FoodId", fid);
                cmdItem.Parameters.AddWithValue("@FoodName", fnm);
                cmdItem.Parameters.AddWithValue("@Category", cat);
                cmdItem.Parameters.AddWithValue("@UnitPrice", uprice);
                cmdItem.Parameters.AddWithValue("@Quantity", qty);
                cmdItem.Parameters.AddWithValue("@TotalPrice", tprice);
                cmdItem.Parameters.AddWithValue("@ImageUrl", img);
                cmdItem.ExecuteNonQuery();
            }

            // Clear Cart
            cmd = new SqlCommand("DELETE FROM Cart_tbl WHERE UserEmail=@UserEmail", con);
            cmd.Parameters.AddWithValue("@UserEmail", user);
            cmd.ExecuteNonQuery();

            con.Close();

            Session["AppliedCoupon"] = null;

            SiteMaster master = Master as SiteMaster;
            if (master != null)
            {
                master.UpdateCartBadge();
            }

            Response.Redirect("OrderConfirmation.aspx?orderId=" + orderId);
        }
    }
}
