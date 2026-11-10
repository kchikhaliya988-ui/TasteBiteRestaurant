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
    public partial class Contact : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string subject = ddlSubject.SelectedValue;
            string message = txtMessage.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(message))
            {
                Response.Write("<script>alert('Please fill all required fields');</script>");
                return;
            }

            getcon();
            cmd = new SqlCommand("INSERT INTO ContactMessages (Name, Email, Phone, Subject, Message, SubmittedDate) VALUES ('" + name.Replace("'", "''") + "', '" + email.Replace("'", "''") + "', '" + phone.Replace("'", "''") + "', '" + subject.Replace("'", "''") + "', '" + message.Replace("'", "''") + "', GETDATE())", con);
            cmd.ExecuteNonQuery();
            con.Close();

            litSuccessText.Text = "Thank you, <strong>" + Server.HtmlEncode(name) + "</strong>! Your message has been sent successfully. We will contact you soon.";
            pnlSuccessMessage.Visible = true;

            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlSubject.SelectedIndex = 0;
            txtMessage.Text = "";

            Response.Write("<script>alert('Message sent successfully!');</script>");
        }
    }
}
