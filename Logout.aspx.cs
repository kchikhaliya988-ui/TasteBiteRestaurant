using System;
using System.Web;
using System.Web.UI;

namespace TasteBiteRestaurant
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear current user sessions
            Session.Clear();
            Session.Abandon();

            // Clear cookie
            if (Request.Cookies["TasteBite_UserEmail"] != null)
            {
                HttpCookie authCookie = new HttpCookie("TasteBite_UserEmail")
                {
                    Expires = DateTime.UtcNow.AddDays(-1)
                };
                Response.Cookies.Add(authCookie);
            }

            // Redirect to Login page with notice
            Response.Redirect("Login.aspx?logout=true");
        }
    }
}
