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
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string orderId = Request.QueryString["orderId"];
            if (string.IsNullOrWhiteSpace(orderId))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillOrderDetails(orderId.Trim());
            }
        }

        void fillOrderDetails(string orderId)
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM Orders WHERE OrderId = @OrderId", con);
            da.SelectCommand.Parameters.AddWithValue("@OrderId", orderId);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                con.Close();
                Response.Redirect("Default.aspx");
                return;
            }

            DataRow dr = ds.Tables[0].Rows[0];

            string customerName = dr["CustomerName"].ToString();
            litCustomerName.Text = customerName;
            litOrderId.Text = dr["OrderId"].ToString();

            DateTime orderDate = Convert.ToDateTime(dr["OrderDate"]);
            litOrderTime.Text = orderDate.ToString("hh:mm tt");

            litCustNameAddress.Text = customerName;
            litDeliveryAddress.Text = dr["DeliveryAddress"].ToString();
            litCityPostal.Text = dr["City"].ToString() + ", " + dr["PostalCode"].ToString();
            litMobile.Text = dr["MobileNumber"].ToString();
            litEmail.Text = dr["Email"].ToString();

            litPaymentMethod.Text = dr["PaymentMethod"].ToString();
            litStatus.Text = dr["Status"].ToString();

            string notes = dr["SpecialInstructions"].ToString();
            if (!string.IsNullOrWhiteSpace(notes))
            {
                pnlNotes.Visible = true;
                litNotes.Text = notes;
            }
            else
            {
                pnlNotes.Visible = false;
            }

            litSubTotal.Text = Convert.ToDecimal(dr["SubTotal"]).ToString("0.00");
            decimal deliveryFee = Convert.ToDecimal(dr["DeliveryFee"]);
            litDeliveryFee.Text = deliveryFee == 0 ? "FREE" : "₹" + deliveryFee.ToString("0");
            litTax.Text = Convert.ToDecimal(dr["Tax"]).ToString("0.00");

            decimal discount = Convert.ToDecimal(dr["DiscountAmount"]);
            if (discount > 0)
            {
                pnlDiscountRow.Visible = true;
                litDiscount.Text = discount.ToString("0.00");
            }
            else
            {
                pnlDiscountRow.Visible = false;
            }

            litGrandTotal.Text = Convert.ToDecimal(dr["GrandTotal"]).ToString("0.00");

            // Fetch order items
            SqlDataAdapter daItems = new SqlDataAdapter("SELECT * FROM OrderItems WHERE OrderId = @OrderId", con);
            daItems.SelectCommand.Parameters.AddWithValue("@OrderId", orderId);
            DataSet dsItems = new DataSet();
            daItems.Fill(dsItems);

            rptReceiptItems.DataSource = dsItems;
            rptReceiptItems.DataBind();

            con.Close();
        }
    }
}
