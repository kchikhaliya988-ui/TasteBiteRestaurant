using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace TasteBiteRestaurant
{
    public partial class SiteMaster : MasterPage
    {
        SqlConnection con;
        SqlDataAdapter da;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            UpdateCartBadge();
        }

        public void UpdateCartBadge()
        {
            try
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
                da = new SqlDataAdapter("select sum(Quantity) from Cart_tbl where UserEmail = @UserEmail", con);
                da.SelectCommand.Parameters.AddWithValue("@UserEmail", user);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                if (dt.Rows.Count > 0 && dt.Rows[0][0] != DBNull.Value)
                {
                    int count = Convert.ToInt32(dt.Rows[0][0]);
                    lblCartCount.Text = count.ToString();
                    lblCartCount.Visible = count > 0;
                }
                else
                {
                    lblCartCount.Text = "0";
                    lblCartCount.Visible = false;
                }
            }
            catch
            {
                lblCartCount.Text = "0";
                lblCartCount.Visible = false;
            }
        }
    }
}
