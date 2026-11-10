# 🍲 TasteBite Restaurant - ASP.NET Web Forms Dynamic Website

A dynamic Restaurant & Food Ordering Web Application built with **ASP.NET Web Forms (.NET Framework 4.7.2), C# (ADO.NET), and SQL Server Database (`TasteBiteDB.mdf`)** for **Visual Studio 2022**.

---

## 🌟 Project Highlights & Features

- **100% Dynamic Database Driven (ADO.NET)**:
  - Uses standard college ADO.NET architecture: `SqlConnection`, `SqlCommand`, `SqlDataAdapter`, `DataSet`, and `DataTable`.
  - Database connection managed via `Web.config` connection string (`dbcon` / `mycon`) pointing to `App_Data\TasteBiteDB.mdf`.
  - Direct SQL queries (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) executed cleanly in code-behind files.

- **Complete Page Workflow**:
  - `Site.Master` & `Site.Master.cs`: Master page with responsive navigation bar, user session indicator, dynamic database cart counter badge, and footer.
  - `Default.aspx` & `Default.aspx.cs`: Home page with banner, quick categories, and dynamic popular dishes loaded from database with Add to Cart buttons.
  - `Menu.aspx` & `Menu.aspx.cs`: Live food catalog populated directly from `Foods` table, search filter, and category filter.
  - `FoodDetails.aspx` & `FoodDetails.aspx.cs`: Detailed dish view with live database details, ingredients list, quantity selector, and related items.
  - `Cart.aspx` & `Cart.aspx.cs`: Dynamic shopping cart connected to `Cart_tbl` table in SQL Server. Supports item quantity increment/decrement, item deletion, clearing cart, and coupon application.
  - `Checkout.aspx` & `Checkout.aspx.cs`: Checkout and customer delivery form with server-side validation. Inserts order records into `Orders` table and item details into `OrderItems` table.
  - `OrderConfirmation.aspx` & `OrderConfirmation.aspx.cs`: Dynamic order receipt tracking page fetching live order and item data by `orderId`.
  - `Login.aspx` & `Login.aspx.cs`: Customer and Admin sign-in verifying credentials against `Users` table in SQL database.
  - `Register.aspx` & `Register.aspx.cs`: Customer registration inserting new records into `Users` table.
  - `Logout.aspx` & `Logout.aspx.cs`: Session clearance and clean redirect.
  - `Contact.aspx` & `Contact.aspx.cs`: Contact form inserting customer feedback into `ContactMessages` table.
  - `Admin.aspx` & `Admin.aspx.cs`: Admin management panel with KPI dashboard stats, order status updater, food items CRUD (Add, Edit, Delete), and registered customer directory.

---

## 🗄️ Database Tables (`App_Data\TasteBiteDB.mdf`)

1. **`Users`**: `UserId`, `FullName`, `Email`, `PhoneNumber`, `Password`, `Role`, `CreatedDate`
2. **`Foods`**: `FoodId`, `Name`, `Description`, `Category`, `Price`, `OriginalPrice`, `ImageUrl`, `PreparationTimeMinutes`, `IsPopular`, `IsChefSpecial`, `IsVegetarian`, `IsSpicy`, `Rating`, `ReviewCount`, `Ingredients`
3. **`Cart_tbl`**: `CartId`, `FoodId`, `UserEmail`, `Quantity`, `Price`, `Total`, `AddedDate`
4. **`Orders`**: `OrderId`, `OrderDate`, `CustomerName`, `MobileNumber`, `Email`, `DeliveryAddress`, `City`, `PostalCode`, `SpecialInstructions`, `PaymentMethod`, `SubTotal`, `DeliveryFee`, `Tax`, `DiscountAmount`, `GrandTotal`, `Status`, `EstimatedDeliveryMinutes`
5. **`OrderItems`**: `OrderItemId`, `OrderId`, `FoodId`, `FoodName`, `Category`, `UnitPrice`, `Quantity`, `TotalPrice`, `ImageUrl`
6. **`ContactMessages`**: `Id`, `Name`, `Email`, `Phone`, `Subject`, `Message`, `SubmittedDate`

---

## 🔑 Local Test Accounts

Test account credentials are intentionally not published. Create or configure local test accounts before running the application, and never reuse credentials from a public repository in production.

---

## 🚀 How to Run in Visual Studio 2022

1. Open **Visual Studio 2022**.
2. Click **Open a project or solution**.
3. Select `TasteBiteRestaurant.sln`.
4. Right-click on `Default.aspx` in Solution Explorer and click **Set As Start Page**.
5. Press **F5** or click **IIS Express** to run the project.
