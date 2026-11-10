using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web.Design;

namespace TasteBiteRestaurant
{
    public partial class BillReport : System.Web.UI.Page
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

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string orderId = Request.QueryString["orderId"];
            if (string.IsNullOrWhiteSpace(orderId))
            {
                orderId = Session["LastOrderId"] as string;
            }

            if (!string.IsNullOrWhiteSpace(orderId))
            {
                GenerateBillPdf(orderId.Trim());
            }
            else
            {
                Response.Write("<h3 style='color:red;'>No Order ID specified.</h3>");
            }
        }

        public void GenerateBillPdf(string orderId)
        {
            getcon();
            string query = "SELECT Orders.OrderId, Orders.OrderDate, Orders.CustomerName, Orders.MobileNumber, Orders.Email, Orders.DeliveryAddress, Orders.City, Orders.PostalCode, Orders.PaymentMethod, Orders.SubTotal, Orders.DeliveryFee, Orders.Tax, Orders.DiscountAmount, Orders.GrandTotal, Orders.Status, OrderItems.FoodName, OrderItems.Category, OrderItems.UnitPrice, OrderItems.Quantity, OrderItems.TotalPrice FROM Orders INNER JOIN OrderItems ON Orders.OrderId = OrderItems.OrderId WHERE Orders.OrderId = '" + orderId + "'";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            // Step 4: Create/Update the XML File dynamically
            string sXml = Server.MapPath("~/BillData.xml");
            ds.WriteXmlSchema(sXml);

            // Step 5: Add Crystal Report & Export to PDF
            string path = Server.MapPath("~/BillReport.rpt");
            if (System.IO.File.Exists(path))
            {
                try
                {
                    cr.Load(path);
                    cr.SetDataSource(ds.Tables[0]);
                    cr.Refresh();
                    CrystalReportViewer1.ReportSource = cr;
                    cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Bill_" + orderId);
                }
                catch (CrystalDecisions.CrystalReports.Engine.DataSourceException)
                {
                    Response.Write("<div style='font-family:sans-serif;padding:30px;text-align:center;'>");
                    Response.Write("<h2 style='color:#e63946;'>BillReport.rpt માં Tables/Fields Add કરવાના બાકી છે</h2>");
                    Response.Write("<p>Visual Studio માં <b>BillReport.rpt</b> ઓપન કરો અને <b>Field Explorer -> Database Expert</b> માં <b>BillData.xml</b> સિલેક્ટ કરીને ફિલ્ડ્સ મૂકો.</p>");
                    Response.Write("</div>");
                }
                catch (Exception ex)
                {
                    Response.Write("<div style='font-family:sans-serif;padding:30px;color:red;'><b>Error:</b> " + ex.Message + "</div>");
                }
            }
            else
            {
                Response.Write("<div style='font-family:sans-serif;padding:30px;text-align:center;'>");
                Response.Write("<h2 style='color:#e63946;'>BillReport.rpt File Not Found</h2>");
                Response.Write("<p>BillData.xml has been created successfully at <b>" + sXml + "</b>.</p>");
                Response.Write("<p>Please open Visual Studio and create <b>BillReport.rpt</b> using <b>BillData.xml</b>.</p>");
                Response.Write("</div>");
            }

            con.Close();
        }
    }
}
