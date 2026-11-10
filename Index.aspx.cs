using System;
using System.Web.UI;

namespace TasteBiteRestaurant
{
    public partial class Index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx", true);
        }
    }
}
