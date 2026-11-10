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
    public partial class Admin : System.Web.UI.Page
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
            if (Session["role"] == null || !string.Equals(Session["role"].ToString(), "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                litAdminUserEmail.Text = Session["email"] != null ? Session["email"].ToString() : "admin@gmail.com";
                bindStats();
                bindOrders();
                bindMenu();
                bindUsers();
            }
        }

        void bindStats()
        {
            getcon();

            // Total revenue
            cmd = new SqlCommand("SELECT ISNULL(SUM(GrandTotal), 0) FROM Orders", con);
            decimal totalRevenue = Convert.ToDecimal(cmd.ExecuteScalar());
            litTotalRevenue.Text = totalRevenue.ToString("0.00");

            // Total orders
            cmd = new SqlCommand("SELECT COUNT(1) FROM Orders", con);
            int totalOrders = Convert.ToInt32(cmd.ExecuteScalar());
            litTotalOrders.Text = totalOrders.ToString();
            litOrdersTabCount.Text = totalOrders.ToString();

            // Active orders
            cmd = new SqlCommand("SELECT COUNT(1) FROM Orders WHERE Status != 'Delivered' AND Status != 'Cancelled'", con);
            int activeOrders = Convert.ToInt32(cmd.ExecuteScalar());
            litActiveOrders.Text = activeOrders.ToString();

            // Total food items
            cmd = new SqlCommand("SELECT COUNT(1) FROM Foods", con);
            int menuCount = Convert.ToInt32(cmd.ExecuteScalar());
            litMenuDishesCount.Text = menuCount.ToString();
            litMenuTabCount.Text = menuCount.ToString();

            // Total users
            cmd = new SqlCommand("SELECT COUNT(1) FROM Users", con);
            int userCount = Convert.ToInt32(cmd.ExecuteScalar());
            litUsersCount.Text = userCount.ToString();
            litUsersTabCount.Text = userCount.ToString();

            con.Close();
        }

        void bindOrders()
        {
            getcon();
            string qry = "SELECT * FROM Orders WHERE 1=1";

            string status = ddlOrderStatusFilter.SelectedValue;
            if (!string.IsNullOrEmpty(status) && status != "All")
            {
                qry += " AND Status = @Status";
            }

            string search = txtOrderSearch.Text.Trim();
            if (!string.IsNullOrEmpty(search))
            {
                qry += " AND (OrderId LIKE @OrderSearch OR CustomerName LIKE @OrderSearch OR MobileNumber LIKE @OrderSearch OR Email LIKE @OrderSearch)";
            }

            qry += " ORDER BY OrderDate DESC";

            da = new SqlDataAdapter(qry, con);
            if (!string.IsNullOrEmpty(status) && status != "All")
            {
                da.SelectCommand.Parameters.AddWithValue("@Status", status.Trim());
            }
            if (!string.IsNullOrEmpty(search))
            {
                da.SelectCommand.Parameters.AddWithValue("@OrderSearch", "%" + search.Replace("'", "''") + "%");
            }
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvOrders.Visible = true;
                pnlNoOrders.Visible = false;
                gvOrders.DataSource = ds;
                gvOrders.DataBind();
            }
            else
            {
                gvOrders.Visible = false;
                pnlNoOrders.Visible = true;
            }
        }

        void bindMenu()
        {
            getcon();
            string qry = @"SELECT 
                FoodId AS Id, 
                FoodId, 
                Name, 
                Description, 
                Category, 
                Price, 
                OriginalPrice, 
                ImageUrl, 
                PreparationTimeMinutes, 
                IsPopular, 
                IsChefSpecial, 
                IsVegetarian, 
                IsSpicy, 
                Rating, 
                ReviewCount, 
                Ingredients 
            FROM Foods WHERE 1=1";

            string cat = ddlMenuCategoryFilter.SelectedValue;
            if (!string.IsNullOrEmpty(cat) && cat != "All")
            {
                qry += " AND Category = @Category";
            }

            string search = txtMenuSearch.Text.Trim();
            if (!string.IsNullOrEmpty(search))
            {
                qry += " AND (Name LIKE @MenuSearch OR Ingredients LIKE @MenuSearch)";
            }

            qry += " ORDER BY FoodId DESC";

            da = new SqlDataAdapter(qry, con);
            if (!string.IsNullOrEmpty(cat) && cat != "All")
            {
                da.SelectCommand.Parameters.AddWithValue("@Category", cat.Trim());
            }
            if (!string.IsNullOrEmpty(search))
            {
                da.SelectCommand.Parameters.AddWithValue("@MenuSearch", "%" + search.Replace("'", "''") + "%");
            }
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvFoodItems.DataSource = ds;
            gvFoodItems.DataBind();
        }

        void bindUsers()
        {
            getcon();
            da = new SqlDataAdapter("SELECT UserId AS Id, FullName, Email, PhoneNumber, Role, CreatedDate AS CreatedAt FROM Users ORDER BY UserId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvUsers.DataSource = ds;
            gvUsers.DataBind();
        }

        protected void btnFilterOrders_Click(object sender, EventArgs e)
        {
            bindOrders();
        }

        protected void btnResetOrderFilter_Click(object sender, EventArgs e)
        {
            txtOrderSearch.Text = "";
            ddlOrderStatusFilter.SelectedValue = "All";
            bindOrders();
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                string orderId = e.CommandArgument.ToString();
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                DropDownList ddl = (DropDownList)row.FindControl("ddlStatus");
                if (ddl != null)
                {
                    getcon();
                    cmd = new SqlCommand("UPDATE Orders SET Status = @Status WHERE OrderId = @OrderId", con);
                    cmd.Parameters.AddWithValue("@Status", ddl.SelectedValue);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    bindOrders();
                    bindStats();
                    Response.Write("<script>alert('Order status updated successfully');</script>");
                }
            }
            else if (e.CommandName == "DeleteOrder")
            {
                string orderId = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("DELETE FROM Orders WHERE OrderId = @OrderId", con);
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                cmd.ExecuteNonQuery();
                con.Close();

                bindOrders();
                bindStats();
                Response.Write("<script>alert('Order deleted successfully');</script>");
            }
        }

        protected void btnAddNewFood_Click(object sender, EventArgs e)
        {
            hfEditFoodId.Value = "0";
            litFoodFormTitle.Text = "Add New Food Item";
            txtDishName.Text = "";
            txtDishPrice.Text = "";
            txtDishOriginalPrice.Text = "";
            txtDishImageUrl.Text = "";
            txtDishDescription.Text = "";
            txtDishIngredients.Text = "";
            txtDishPrepTime.Text = "15";
            chkDishPopular.Checked = false;
            chkDishChefSpecial.Checked = false;
            chkDishVegetarian.Checked = true;
            chkDishSpicy.Checked = false;
            ddlDishCategory.SelectedIndex = 0;
            pnlFoodForm.Visible = true;
        }

        protected void btnCloseFoodForm_Click(object sender, EventArgs e)
        {
            pnlFoodForm.Visible = false;
        }

        protected void btnSaveFoodItem_Click(object sender, EventArgs e)
        {
            string name = txtDishName.Text.Trim();
            string category = ddlDishCategory.SelectedValue;
            decimal price = 0;
            decimal.TryParse(txtDishPrice.Text.Trim(), out price);

            decimal origPrice = price;
            if (!string.IsNullOrEmpty(txtDishOriginalPrice.Text.Trim()))
            {
                decimal.TryParse(txtDishOriginalPrice.Text.Trim(), out origPrice);
            }

            string imgUrl = txtDishImageUrl.Text.Trim();
            if (string.IsNullOrEmpty(imgUrl))
            {
                imgUrl = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80";
            }

            int prepTime = 15;
            int.TryParse(txtDishPrepTime.Text.Trim(), out prepTime);

            string desc = txtDishDescription.Text.Trim();
            string ingredients = txtDishIngredients.Text.Trim();

            int isPopular = chkDishPopular.Checked ? 1 : 0;
            int isChef = chkDishChefSpecial.Checked ? 1 : 0;
            int isVeg = chkDishVegetarian.Checked ? 1 : 0;
            int isSpicy = chkDishSpicy.Checked ? 1 : 0;

            getcon();
            if (hfEditFoodId.Value == "0")
            {
                string sql = "INSERT INTO Foods (Name, Description, Category, Price, OriginalPrice, ImageUrl, PreparationTimeMinutes, IsPopular, IsChefSpecial, IsVegetarian, IsSpicy, Rating, ReviewCount, Ingredients) VALUES (@Name, @Description, @Category, @Price, @OriginalPrice, @ImageUrl, @PrepTime, @IsPopular, @IsChefSpecial, @IsVegetarian, @IsSpicy, 4.8, 1, @Ingredients)";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Description", desc);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@OriginalPrice", origPrice);
                cmd.Parameters.AddWithValue("@ImageUrl", imgUrl);
                cmd.Parameters.AddWithValue("@PrepTime", prepTime);
                cmd.Parameters.AddWithValue("@IsPopular", isPopular);
                cmd.Parameters.AddWithValue("@IsChefSpecial", isChef);
                cmd.Parameters.AddWithValue("@IsVegetarian", isVeg);
                cmd.Parameters.AddWithValue("@IsSpicy", isSpicy);
                cmd.Parameters.AddWithValue("@Ingredients", ingredients);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('New food dish added successfully!');</script>");
            }
            else
            {
                int fid = Convert.ToInt32(hfEditFoodId.Value);
                string sql = "UPDATE Foods SET Name=@Name, Description=@Description, Category=@Category, Price=@Price, OriginalPrice=@OriginalPrice, ImageUrl=@ImageUrl, PreparationTimeMinutes=@PrepTime, IsPopular=@IsPopular, IsChefSpecial=@IsChefSpecial, IsVegetarian=@IsVegetarian, IsSpicy=@IsSpicy, Ingredients=@Ingredients WHERE FoodId=@FoodId";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Description", desc);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@OriginalPrice", origPrice);
                cmd.Parameters.AddWithValue("@ImageUrl", imgUrl);
                cmd.Parameters.AddWithValue("@PrepTime", prepTime);
                cmd.Parameters.AddWithValue("@IsPopular", isPopular);
                cmd.Parameters.AddWithValue("@IsChefSpecial", isChef);
                cmd.Parameters.AddWithValue("@IsVegetarian", isVeg);
                cmd.Parameters.AddWithValue("@IsSpicy", isSpicy);
                cmd.Parameters.AddWithValue("@Ingredients", ingredients);
                cmd.Parameters.AddWithValue("@FoodId", fid);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Food dish updated successfully!');</script>");
            }
            con.Close();

            pnlFoodForm.Visible = false;
            bindMenu();
            bindStats();
        }

        protected void gvFoodItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditFood")
            {
                int fid = Convert.ToInt32(e.CommandArgument);
                getcon();
                da = new SqlDataAdapter("SELECT * FROM Foods WHERE FoodId = @FoodId", con);
                da.SelectCommand.Parameters.AddWithValue("@FoodId", fid);
                ds = new DataSet();
                da.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].Rows[0];
                    hfEditFoodId.Value = fid.ToString();
                    litFoodFormTitle.Text = "Edit Food Item #" + fid;
                    txtDishName.Text = dr["Name"].ToString();
                    txtDishPrice.Text = dr["Price"].ToString();
                    txtDishOriginalPrice.Text = dr["OriginalPrice"] != DBNull.Value ? dr["OriginalPrice"].ToString() : "";
                    txtDishImageUrl.Text = dr["ImageUrl"].ToString();
                    txtDishDescription.Text = dr["Description"].ToString();
                    txtDishIngredients.Text = dr["Ingredients"].ToString();
                    txtDishPrepTime.Text = dr["PreparationTimeMinutes"].ToString();

                    if (ddlDishCategory.Items.FindByValue(dr["Category"].ToString()) != null)
                    {
                        ddlDishCategory.SelectedValue = dr["Category"].ToString();
                    }

                    chkDishPopular.Checked = Convert.ToBoolean(dr["IsPopular"]);
                    chkDishChefSpecial.Checked = Convert.ToBoolean(dr["IsChefSpecial"]);
                    chkDishVegetarian.Checked = Convert.ToBoolean(dr["IsVegetarian"]);
                    chkDishSpicy.Checked = Convert.ToBoolean(dr["IsSpicy"]);

                    pnlFoodForm.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteFood")
            {
                int fid = Convert.ToInt32(e.CommandArgument);
                getcon();
                cmd = new SqlCommand("DELETE FROM Foods WHERE FoodId = @FoodId", con);
                cmd.Parameters.AddWithValue("@FoodId", fid);
                cmd.ExecuteNonQuery();
                con.Close();

                bindMenu();
                bindStats();
                Response.Write("<script>alert('Dish deleted successfully');</script>");
            }
        }

        protected void btnFilterMenu_Click(object sender, EventArgs e)
        {
            bindMenu();
        }

        protected void btnRefreshData_Click(object sender, EventArgs e)
        {
            bindStats();
            bindOrders();
            bindMenu();
            bindUsers();
            Response.Write("<script>alert('Data refreshed successfully');</script>");
        }

        public string GetStatusBadgeCss(string status)
        {
            switch (status)
            {
                case "Order Placed & Confirmed":
                    return "badge bg-info text-dark";
                case "Preparing in Kitchen":
                    return "badge bg-warning text-dark";
                case "Out for Delivery":
                    return "badge bg-primary text-white";
                case "Delivered":
                    return "badge bg-success text-white";
                case "Cancelled":
                    return "badge bg-danger text-white";
                default:
                    return "badge bg-secondary text-white";
            }
        }
    }
}
