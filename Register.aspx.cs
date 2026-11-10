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
    public partial class Register : System.Web.UI.Page
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
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            pnlError.Visible = false;
            pnlSuccess.Visible = false;

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(password))
            {
                litErrorMessage.Text = "Please fill in all required fields.";
                pnlError.Visible = true;
                return;
            }

            if (password != confirmPassword)
            {
                litErrorMessage.Text = "Passwords do not match.";
                pnlError.Visible = true;
                return;
            }

            if (!chkTerms.Checked)
            {
                litErrorMessage.Text = "Please agree to the Terms of Service.";
                pnlError.Visible = true;
                return;
            }

            getcon();
            cmd = new SqlCommand("SELECT * FROM Users WHERE Email = @Email", con);
            cmd.Parameters.AddWithValue("@Email", email);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                con.Close();
                litErrorMessage.Text = "This email is already registered. Please sign in.";
                pnlError.Visible = true;
                Response.Write("<script>alert('Email already registered! Please sign in.');</script>");
                return;
            }

            string insertSql = "INSERT INTO Users (FullName, Email, PhoneNumber, Password, Role, CreatedDate) VALUES (@FullName, @Email, @PhoneNumber, @Password, 'Customer', GETDATE())";
            cmd = new SqlCommand(insertSql, con);
            cmd.Parameters.AddWithValue("@FullName", fullName);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@PhoneNumber", phone);
            cmd.Parameters.AddWithValue("@Password", password);
            cmd.ExecuteNonQuery();
            con.Close();

            Session["user"] = fullName;
            Session["username"] = fullName;
            Session["email"] = email;
            Session["role"] = "Customer";

            Response.Write("<script>alert('Account created successfully! Welcome to TasteBite.');window.location='Default.aspx';</script>");
        }
    }
}
