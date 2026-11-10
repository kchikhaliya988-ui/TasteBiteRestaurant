<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="TasteBiteRestaurant.Admin" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TasteBite Restaurant - Admin Management Panel</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <!-- Admin Custom CSS -->
    <link href="wwwroot/css/admin.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        
        <!-- Sidebar Navigation -->
        <aside class="admin-sidebar" id="sidebar">
            <div class="sidebar-brand">
                <div class="brand-icon-box">
                    <i class="bi bi-fire"></i>
                </div>
                <div>
                    <div class="brand-text">TasteBite</div>
                    <div class="brand-badge">ADMIN CONTROL</div>
                </div>
            </div>

            <div class="sidebar-menu">
                <div class="sidebar-heading">Core Management</div>
                <button type="button" class="sidebar-link active" onclick="switchTab('orders-tab')">
                    <i class="bi bi-bag-check-fill text-warning"></i>
                    <span>Orders Management</span>
                </button>
                <button type="button" class="sidebar-link" onclick="switchTab('menu-tab')">
                    <i class="bi bi-egg-fried text-info"></i>
                    <span>Food Menu (CRUD)</span>
                </button>
                <button type="button" class="sidebar-link" onclick="switchTab('users-tab')">
                    <i class="bi bi-people-fill text-success"></i>
                    <span>Registered Customers</span>
                </button>

                <div class="sidebar-heading">Navigation</div>
                <a href="Default.aspx" class="sidebar-link" target="_blank">
                    <i class="bi bi-shop text-primary"></i>
                    <span>Customer Storefront</span>
                </a>
                <a href="Menu.aspx" class="sidebar-link" target="_blank">
                    <i class="bi bi-journal-text text-secondary"></i>
                    <span>Live Public Menu</span>
                </a>

                <div class="sidebar-heading">Account</div>
                <a href="Logout.aspx" class="sidebar-link text-danger">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Sign Out</span>
                </a>
            </div>

            <div class="sidebar-footer">
                <div class="d-flex align-items-center gap-2">
                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center text-white fw-bold" style="width: 36px; height: 36px;">
                        A
                    </div>
                    <div class="overflow-hidden">
                        <div class="fw-bold text-white small text-truncate">TasteBite Admin</div>
                        <div class="text-white-50" style="font-size: 0.72rem;"><asp:Literal ID="litAdminUserEmail" runat="server"></asp:Literal></div>
                    </div>
                </div>
            </div>
        </aside>

        <!-- Main Content Area -->
        <div class="admin-main-wrap">
            
            <!-- Topbar -->
            <header class="admin-topbar">
                <div class="d-flex align-items-center gap-3">
                    <button class="btn btn-sm btn-light d-lg-none" type="button" onclick="document.getElementById('sidebar').classList.toggle('show')">
                        <i class="bi bi-list fs-5"></i>
                    </button>
                    <div>
                        <h4 class="mb-0 fw-bold">Admin Management Console</h4>
                        <div class="text-muted small">
                            <span class="text-success"><i class="bi bi-circle-fill" style="font-size: 0.55rem;"></i> System Live</span> &bull; TasteBite Restaurant Operations
                        </div>
                    </div>
                </div>

                <div class="d-flex align-items-center gap-2">
                    <a href="Default.aspx" class="btn btn-sm btn-outline-dark rounded-pill px-3 py-1">
                        <i class="bi bi-box-arrow-up-right me-1"></i> View Website
                    </a>
                    <asp:LinkButton ID="btnRefreshData" runat="server" CssClass="btn btn-sm btn-light border rounded-pill px-3 py-1 d-inline-flex align-items-center gap-1 shadow-sm" OnClick="btnRefreshData_Click" OnClientClick="var icon = this.querySelector('i'); if(icon) icon.classList.add('spin-icon');">
                        <i class="bi bi-arrow-clockwise text-primary"></i> <span>Refresh</span>
                    </asp:LinkButton>
                    <a href="Logout.aspx" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-1">
                        <i class="bi bi-box-arrow-right me-1"></i> Logout
                    </a>
                </div>
            </header>

            <!-- Main Body Canvas -->
            <main class="admin-content">
                
                <!-- Feedback Alert Panel -->
                <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="mb-4">
                    <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm d-flex align-items-center gap-2" role="alert">
                        <i class="bi bi-check-circle-fill fs-5 text-success"></i>
                        <div class="flex-grow-1">
                            <asp:Literal ID="litAlertMessage" runat="server"></asp:Literal>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </asp:Panel>

                <!-- KPI Metric Stat Cards -->
                <div class="row g-3 mb-4">
                    <!-- Total Revenue -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small fw-bold text-uppercase">Total Sales Revenue</div>
                                    <h3 class="fw-bold mt-1 mb-0 text-dark">₹<asp:Literal ID="litTotalRevenue" runat="server">0.00</asp:Literal></h3>
                                    <div class="text-success small mt-1"><i class="bi bi-arrow-up-right"></i> All Time Gross</div>
                                </div>
                                <div class="stat-icon bg-success bg-opacity-10 text-success">
                                    <i class="bi bi-cash-stack"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Total Orders -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small fw-bold text-uppercase">Total Orders</div>
                                    <h3 class="fw-bold mt-1 mb-0 text-dark"><asp:Literal ID="litTotalOrders" runat="server">0</asp:Literal></h3>
                                    <div class="text-primary small mt-1"><i class="bi bi-receipt"></i> Customer Receipts</div>
                                </div>
                                <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                                    <i class="bi bi-bag-check-fill"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Active In-Kitchen Orders -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small fw-bold text-uppercase">In-Kitchen / Active</div>
                                    <h3 class="fw-bold mt-1 mb-0 text-danger"><asp:Literal ID="litActiveOrders" runat="server">0</asp:Literal></h3>
                                    <div class="text-danger small mt-1"><i class="bi bi-fire"></i> Requires Attention</div>
                                </div>
                                <div class="stat-icon bg-danger bg-opacity-10 text-danger">
                                    <i class="bi bi-hourglass-split"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Menu Items & Users -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small fw-bold text-uppercase">Menu Dishes / Users</div>
                                    <h3 class="fw-bold mt-1 mb-0 text-dark">
                                        <asp:Literal ID="litMenuDishesCount" runat="server">0</asp:Literal> <span class="fs-6 fw-normal text-muted">Dishes</span>
                                    </h3>
                                    <div class="text-info small mt-1">
                                        <i class="bi bi-people-fill"></i> <asp:Literal ID="litUsersCount" runat="server">0</asp:Literal> Registered Users
                                    </div>
                                </div>
                                <div class="stat-icon bg-warning bg-opacity-15 text-warning">
                                    <i class="bi bi-journal-bookmark-fill"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation Tabs Bar -->
                <div class="card border-0 shadow-sm rounded-4 p-2 mb-4 bg-white">
                    <ul class="nav custom-admin-tabs gap-2" id="adminTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="orders-tab" data-bs-toggle="pill" data-bs-target="#orders-pane" type="button" role="tab" aria-controls="orders-pane" aria-selected="true">
                                <i class="bi bi-bag-check me-1"></i> Orders Management (<asp:Literal ID="litOrdersTabCount" runat="server"></asp:Literal>)
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="menu-tab" data-bs-toggle="pill" data-bs-target="#menu-pane" type="button" role="tab" aria-controls="menu-pane" aria-selected="false">
                                <i class="bi bi-egg-fried me-1"></i> Food Menu (CRUD) (<asp:Literal ID="litMenuTabCount" runat="server"></asp:Literal>)
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="users-tab" data-bs-toggle="pill" data-bs-target="#users-pane" type="button" role="tab" aria-controls="users-pane" aria-selected="false">
                                <i class="bi bi-people me-1"></i> Customer Accounts (<asp:Literal ID="litUsersTabCount" runat="server"></asp:Literal>)
                            </button>
                        </li>
                    </ul>
                </div>

                <!-- TAB PANES -->
                <div class="tab-content" id="adminTabsContent">
              
                    <div class="tab-pane fade show active" id="orders-pane" role="tabpanel" aria-labelledby="orders-tab" tabindex="0">
                        
                        <!-- Search & Status Filter -->
                        <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
                            <div class="row g-2 align-items-center">
                                <div class="col-md-5">
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                                        <asp:TextBox ID="txtOrderSearch" runat="server" CssClass="form-control bg-light border-start-0" placeholder="Search by Order ID, Customer Name, or Phone..."></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <asp:DropDownList ID="ddlOrderStatusFilter" runat="server" CssClass="form-select bg-light">
                                        <asp:ListItem Text="All Order Statuses" Value="All" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Order Placed & Confirmed" Value="Order Placed & Confirmed"></asp:ListItem>
                                        <asp:ListItem Text="Preparing in Kitchen" Value="Preparing in Kitchen"></asp:ListItem>
                                        <asp:ListItem Text="Out for Delivery" Value="Out for Delivery"></asp:ListItem>
                                        <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                                        <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 d-flex gap-2">
                                    <asp:Button ID="btnFilterOrders" runat="server" CssClass="btn btn-dark flex-grow-1 rounded-3" Text="Apply Filter" OnClick="btnFilterOrders_Click" />
                                    <asp:Button ID="btnResetOrderFilter" runat="server" CssClass="btn btn-outline-secondary rounded-3" Text="Reset" OnClick="btnResetOrderFilter_Click" />
                                </div>
                            </div>
                        </div>

                        <!-- Orders GridView (College Student ASP.NET Method) -->
                        <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
                            <div class="table-responsive">
                                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" OnRowCommand="gvOrders_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Order ID & Date">
                                            <ItemTemplate>
                                                <div class="d-flex align-items-center gap-2 mb-1">
                                                    <span class="badge bg-dark fw-bold px-2 py-1"><%# Eval("OrderId") %></span>
                                                    <span class='<%# GetStatusBadgeCss(Eval("Status").ToString()) %>'><%# Eval("Status") %></span>
                                                </div>
                                                <div class="text-muted small">
                                                    <i class="bi bi-calendar3 me-1"></i> <%# String.Format("{0:MMM dd, yyyy - hh:mm tt}", Eval("OrderDate")) %>
                                                </div>
                                                <div class="text-muted small">
                                                    <i class="bi bi-credit-card me-1"></i> <%# Eval("PaymentMethod") %>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Customer Details">
                                            <ItemTemplate>
                                                <div class="fw-bold text-dark"><%# Eval("CustomerName") %></div>
                                                <div class="text-muted small"><i class="bi bi-telephone text-primary me-1"></i> <%# Eval("MobileNumber") %></div>
                                                <div class="text-muted small text-truncate" style="max-width: 250px;" title='<%# Eval("DeliveryAddress") %>'>
                                                    <i class="bi bi-geo-alt text-danger me-1"></i> <%# Eval("DeliveryAddress") %>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Grand Total">
                                            <ItemTemplate>
                                                <span class="fw-bold text-danger fs-5">₹<%# String.Format("{0:0}", Eval("GrandTotal")) %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Update Status">
                                            <ItemTemplate>
                                                <div class="input-group input-group-sm mb-1" style="max-width: 240px;">
                                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm">
                                                        <asp:ListItem Text="Order Placed & Confirmed" Value="Order Placed & Confirmed"></asp:ListItem>
                                                        <asp:ListItem Text="Preparing in Kitchen" Value="Preparing in Kitchen"></asp:ListItem>
                                                        <asp:ListItem Text="Out for Delivery" Value="Out for Delivery"></asp:ListItem>
                                                        <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                                                        <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Button ID="btnUpdateStatus" runat="server" CssClass="btn btn-sm btn-dark" Text="Update" CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderId") %>' />
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end" HeaderStyle-CssClass="text-end">
                                            <ItemTemplate>
                                                <a href='<%# "OrderConfirmation.aspx?orderId=" + Eval("OrderId") %>' target="_blank" class="btn btn-sm btn-outline-secondary rounded-pill px-3 me-1">
                                                    <i class="bi bi-receipt me-1"></i> Receipt
                                                </a>
                                                <asp:LinkButton ID="btnDeleteOrder" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-2" CommandName="DeleteOrder" CommandArgument='<%# Eval("OrderId") %>' OnClientClick="return confirm('Are you sure you want to remove this order record?');" ToolTip="Delete Order">
                                                    <i class="bi bi-trash"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                        <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="card border-0 rounded-4 shadow-sm text-center py-5 bg-white">
                            <i class="bi bi-inbox fs-1 text-muted mb-2"></i>
                            <h5 class="fw-bold text-dark">No Orders Found</h5>
                            <p class="text-muted mb-0">No customer orders match your selected filter criteria.</p>
                        </asp:Panel>
                    </div>

                    <!-- ========================================== -->
                    <!-- TAB 2: MENU MANAGEMENT (CRUD)              -->
                    <!-- ========================================== -->
                    <div class="tab-pane fade" id="menu-pane" role="tabpanel" aria-labelledby="menu-tab" tabindex="0">
                        
                        <!-- Add/Edit Food Form Panel -->
                        <asp:Panel ID="pnlFoodForm" runat="server" Visible="false" CssClass="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white border-top border-4 border-danger">
                            <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                                <h5 class="fw-bold mb-0 text-dark">
                                    <i class="bi bi-pencil-square text-danger me-2"></i><asp:Literal ID="litFoodFormTitle" runat="server">Add New Food Item</asp:Literal>
                                </h5>
                                <asp:Button ID="btnCloseFoodForm" runat="server" CssClass="btn-close" OnClick="btnCloseFoodForm_Click" />
                            </div>
                            <asp:HiddenField ID="hfEditFoodId" runat="server" Value="0" />

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Dish Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtDishName" runat="server" CssClass="form-control" placeholder="e.g. Kathiyawadi Sev Tameta"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold small">Category <span class="text-danger">*</span></label>
                                    <asp:DropDownList ID="ddlDishCategory" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Gujarati Food" Value="Gujarati Food" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Gujarati Thali" Value="Gujarati Thali"></asp:ListItem>
                                        <asp:ListItem Text="Kathiyawadi Shaak" Value="Kathiyawadi Shaak"></asp:ListItem>
                                        <asp:ListItem Text="Gujarati Shaak & Dal" Value="Gujarati Shaak & Dal"></asp:ListItem>
                                        <asp:ListItem Text="Farsan & Snacks" Value="Farsan & Snacks"></asp:ListItem>
                                        <asp:ListItem Text="Rotla & Breads" Value="Rotla & Breads"></asp:ListItem>
                                        <asp:ListItem Text="Mithai & Sweets" Value="Mithai & Sweets"></asp:ListItem>
                                        <asp:ListItem Text="Chhash & Drinks" Value="Chhash & Drinks"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold small">Prep Time (Mins)</label>
                                    <asp:TextBox ID="txtDishPrepTime" runat="server" CssClass="form-control" placeholder="e.g. 15" TextMode="Number"></asp:TextBox>
                                </div>

                                <div class="col-md-3">
                                    <label class="form-label fw-semibold small">Selling Price (₹) <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtDishPrice" runat="server" CssClass="form-control" placeholder="e.g. 140"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold small">Original Price (₹) (Optional)</label>
                                    <asp:TextBox ID="txtDishOriginalPrice" runat="server" CssClass="form-control" placeholder="e.g. 160"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Image URL</label>
                                    <asp:TextBox ID="txtDishImageUrl" runat="server" CssClass="form-control" placeholder="https://images.unsplash.com/..."></asp:TextBox>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold small">Ingredients (Comma-separated)</label>
                                    <asp:TextBox ID="txtDishIngredients" runat="server" CssClass="form-control" placeholder="San Marzano Tomatoes, Buffalo Mozzarella, Basil, Olive Oil"></asp:TextBox>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold small">Description</label>
                                    <asp:TextBox ID="txtDishDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Describe flavors, aromas, and preparation style..."></asp:TextBox>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold small d-block">Dietary & Menu Badges</label>
                                    <div class="d-flex flex-wrap gap-4">
                                        <div class="form-check">
                                            <asp:CheckBox ID="chkDishPopular" runat="server" CssClass="form-check-input" />
                                            <label class="form-check-label" for="<%= chkDishPopular.ClientID %>">🔥 Popular</label>
                                        </div>
                                        <div class="form-check">
                                            <asp:CheckBox ID="chkDishChefSpecial" runat="server" CssClass="form-check-input" />
                                            <label class="form-check-label" for="<%= chkDishChefSpecial.ClientID %>">⭐ Chef's Special</label>
                                        </div>
                                        <div class="form-check">
                                            <asp:CheckBox ID="chkDishVegetarian" runat="server" CssClass="form-check-input" />
                                            <label class="form-check-label" for="<%= chkDishVegetarian.ClientID %>">🌱 Vegetarian</label>
                                        </div>
                                        <div class="form-check">
                                            <asp:CheckBox ID="chkDishSpicy" runat="server" CssClass="form-check-input" />
                                            <label class="form-check-label" for="<%= chkDishSpicy.ClientID %>">🌶️ Spicy</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12 d-flex gap-2 justify-content-end mt-3 pt-2 border-top">
                                    <asp:Button ID="btnCancelFoodForm" runat="server" CssClass="btn btn-outline-secondary rounded-pill px-4" Text="Cancel" OnClick="btnCloseFoodForm_Click" />
                                    <asp:Button ID="btnSaveFoodItem" runat="server" CssClass="btn btn-danger rounded-pill px-4" Text="Save Food Item" OnClick="btnSaveFoodItem_Click" />
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- Menu Search & Filter -->
                        <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
                            <div class="row g-2 align-items-center">
                                <div class="col-md-5">
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                                        <asp:TextBox ID="txtMenuSearch" runat="server" CssClass="form-control bg-light border-start-0" placeholder="Search dishes by name or ingredient..."></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlMenuCategoryFilter" runat="server" CssClass="form-select bg-light">
                                        <asp:ListItem Text="All Categories" Value="All" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Gujarati Food" Value="Gujarati Food"></asp:ListItem>
                                        <asp:ListItem Text="Gujarati Thali" Value="Gujarati Thali"></asp:ListItem>
                                        <asp:ListItem Text="Kathiyawadi Shaak" Value="Kathiyawadi Shaak"></asp:ListItem>
                                        <asp:ListItem Text="Gujarati Shaak & Dal" Value="Gujarati Shaak & Dal"></asp:ListItem>
                                        <asp:ListItem Text="Farsan & Snacks" Value="Farsan & Snacks"></asp:ListItem>
                                        <asp:ListItem Text="Rotla & Breads" Value="Rotla & Breads"></asp:ListItem>
                                        <asp:ListItem Text="Mithai & Sweets" Value="Mithai & Sweets"></asp:ListItem>
                                        <asp:ListItem Text="Chhash & Drinks" Value="Chhash & Drinks"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2">
                                    <asp:Button ID="btnFilterMenu" runat="server" CssClass="btn btn-outline-dark w-100 rounded-3" Text="Filter" OnClick="btnFilterMenu_Click" />
                                </div>
                                <div class="col-md-2">
                                    <asp:Button ID="btnAddNewFood" runat="server" CssClass="btn btn-danger w-100 rounded-3 fw-semibold" Text="+ Add New Dish" OnClick="btnAddNewFood_Click" />
                                </div>
                            </div>
                        </div>

                        <!-- Menu GridView (College Student ASP.NET Method) -->
                        <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
                            <div class="table-responsive">
                                <asp:GridView ID="gvFoodItems" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" OnRowCommand="gvFoodItems_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Item">
                                             <ItemTemplate>
                                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="food-thumb" onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=150&q=80';" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Dish Details">
                                            <ItemTemplate>
                                                <div class="fw-bold text-dark"><%# Eval("Name") %></div>
                                                <small class="text-muted d-inline-block text-truncate" style="max-width: 280px;"><%# Eval("Description") %></small>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Category">
                                            <ItemTemplate>
                                                <span class="badge bg-light text-dark border"><%# Eval("Category") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Price">
                                            <ItemTemplate>
                                                <div class="fw-bold text-danger">₹<%# String.Format("{0:0}", Eval("Price")) %></div>
                                                <%# Eval("OriginalPrice") != null ? "<small class='text-muted text-decoration-line-through'>₹" + String.Format("{0:0}", Eval("OriginalPrice")) + "</small>" : "" %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Dietary Badges">
                                            <ItemTemplate>
                                                <%# (bool)Eval("IsVegetarian") ? "<span class='badge bg-success bg-opacity-10 text-success me-1'>🌱 Veg</span>" : "<span class='badge bg-danger bg-opacity-10 text-danger me-1'>🥩 Non-Veg</span>" %>
                                                <%# (bool)Eval("IsSpicy") ? "<span class='badge bg-danger bg-opacity-10 text-danger me-1'>🌶️ Spicy</span>" : "" %>
                                                <%# (bool)Eval("IsPopular") ? "<span class='badge bg-warning bg-opacity-25 text-dark me-1'>🔥 Popular</span>" : "" %>
                                                <%# (bool)Eval("IsChefSpecial") ? "<span class='badge bg-primary bg-opacity-10 text-primary me-1'>⭐ Chef</span>" : "" %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Rating">
                                            <ItemTemplate>
                                                <span class="text-warning small"><i class="bi bi-star-fill"></i> <%# Eval("Rating") %></span>
                                                <div class="text-muted small" style="font-size: 0.75rem;"><%# Eval("PreparationTimeMinutes") %> mins</div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end" HeaderStyle-CssClass="text-end">
                                            <ItemTemplate>
                                                <asp:Button ID="btnEditFood" runat="server" CssClass="btn btn-sm btn-outline-primary rounded-pill px-2 me-1" Text="Edit" CommandName="EditFood" CommandArgument='<%# Eval("Id") %>' />
                                                <asp:Button ID="btnDeleteFood" runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill px-2" Text="Delete" CommandName="DeleteFood" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Are you sure you want to delete this dish?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                    </div>

                    <!-- TAB 3: REGISTERED CUSTOMERS (GridView) -->
                    <div class="tab-pane fade" id="users-pane" role="tabpanel" aria-labelledby="users-tab" tabindex="0">
                        <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
                            <div class="p-3 border-bottom d-flex align-items-center justify-content-between">
                                <h6 class="fw-bold mb-0 text-dark"><i class="bi bi-people-fill text-primary me-2"></i>TasteBite Customer Accounts</h6>
                                <span class="badge bg-light text-dark border">Database Users Table</span>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None">
                                    <Columns>
                                        <asp:TemplateField HeaderText="ID">
                                            <ItemTemplate>
                                                <span class="fw-bold text-muted">#<%# Eval("Id") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Customer Name">
                                            <ItemTemplate>
                                                <div class="fw-bold text-dark"><%# Eval("FullName") %></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Email Address">
                                            <ItemTemplate>
                                                <a href='mailto:<%# Eval("Email") %>' class="text-decoration-none"><%# Eval("Email") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Phone Number">
                                            <ItemTemplate>
                                                <span class="text-muted"><%# Eval("PhoneNumber") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Role">
                                            <ItemTemplate>
                                                <span class='<%# "Admin".Equals(Eval("Role") as string, StringComparison.OrdinalIgnoreCase) ? "badge bg-danger" : "badge bg-secondary" %>'>
                                                    <%# Eval("Role") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Registered Date">
                                            <ItemTemplate>
                                                <span class="text-muted small"><%# String.Format("{0:MMM dd, yyyy}", Eval("CreatedAt")) %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                </div>
            </main>
        </div>

    </form>

    <!-- Bootstrap 5 JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function switchTab(tabId) {
            var tabBtn = document.getElementById(tabId);
            if (tabBtn) {
                var tab = new bootstrap.Tab(tabBtn);
                tab.show();
            }
            // Update active state in sidebar links
            var links = document.querySelectorAll('.sidebar-link');
            links.forEach(function(l) { l.classList.remove('active'); });
            if (event && event.currentTarget) {
                event.currentTarget.classList.add('active');
            }
        }
    </script>
</body>
</html>
