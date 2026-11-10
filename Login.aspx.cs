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
    public partial class Login : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                if (Request.QueryString["logout"] == "true")
                {
                    litNoticeMessage.Text = "<strong>Logged Out:</strong> You have been successfully signed out.";
                    pnlNotice.Visible = true;
                }
                else if (Request.QueryString["registered"] == "true")
                {
                    litNoticeMessage.Text = "<strong>Account Ready!</strong> Registration was successful. Please enter your email and password to sign in.";
                    pnlNotice.Visible = true;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            pnlError.Visible = false;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                litErrorMessage.Text = "Please enter both email and password.";
                pnlError.Visible = true;
                return;
            }

            getcon();
            cmd = new SqlCommand("SELECT * FROM Users WHERE Email = @Email AND Password = @Password", con);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                Session["user"] = dr["FullName"].ToString();
                Session["username"] = dr["FullName"].ToString();
                Session["email"] = dr["Email"].ToString();
                Session["role"] = dr["Role"].ToString();

                con.Close();

                if (dr["Role"].ToString().Equals("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("Admin.aspx");
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                con.Close();
                litErrorMessage.Text = "Invalid email or password. Please try again.";
                pnlError.Visible = true;
                Response.Write("<script>alert('Invalid Email or Password');</script>");
            }
        }
    }
}
