<%@ Page Title="Our Menu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="TasteBiteRestaurant.Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/menu.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Feedback Alert Panel -->
    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="container mt-3">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-check-circle-fill fs-5"></i>
            <div>
                <asp:Label ID="lblSuccessMessage" runat="server"></asp:Label>
            </div>
            <a href="Cart.aspx" class="btn btn-sm btn-success ms-auto rounded-pill px-3">View Cart</a>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </asp:Panel>

    <!-- MENU HEADER BANNER -->
    <section class="py-5 bg-white border-bottom border-cream">
        <div class="container text-center">
            <span class="text-danger fw-bold text-uppercase small letter-spacing">Explore Authentic Gujarati Dishes</span>
            <h1 class="display-5 fw-bold mt-1 mb-3">Our Gujarati &amp; Kathiyawadi Menu</h1>
            <p class="text-muted mx-auto mb-4" style="max-width: 650px;">
                Every dish is freshly prepared to order using pure groundnut oil, desi ghee, farm-fresh vegetables, and time-honored Saurashtra &amp; Surat recipes.
            </p>

            <!-- Search and Sort Filter Bar -->
            <div class="card border-0 shadow-sm rounded-4 p-3 mx-auto bg-cream" style="max-width: 850px;">
                <div class="row g-2 align-items-center">
                    <div class="col-md-9 col-12">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0 rounded-start-pill ps-3 text-muted">
                                <i class="bi bi-search"></i>
                            </span>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0 rounded-end-pill py-2" placeholder="Search dishes (e.g., Undhiyu, Sev Tameta, Thali, Dhokla...)"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100 rounded-pill py-2" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CATEGORY FILTER TABS -->
    <section class="py-4 bg-cream sticky-top" style="top: 72px; z-index: 1020; backdrop-filter: blur(8px); background-color: rgba(251, 247, 238, 0.95);">
        <div class="container">
            <div class="category-pills justify-content-lg-center">
                <a href="Menu.aspx?category=All" class="category-pill <%= (CurrentCategory == "All" || string.IsNullOrEmpty(CurrentCategory)) ? "active" : "" %>">
                    <i class="bi bi-grid-fill me-1"></i> All Gujarati Dishes (10)
                </a>
                <a href="Menu.aspx?category=Gujarati+Food" class="category-pill <%= CurrentCategory == "Gujarati Food" ? "active" : "" %>">
                    <i class="bi bi-star-fill text-warning me-1"></i><span>Gujarati Food Menu</span>
                </a>
                <a href="Menu.aspx?search=Thali" class="category-pill">
                    <i class="bi bi-disc me-1"></i><span>Gujarati Thali</span>
                </a>
                <a href="Menu.aspx?search=Dhokla" class="category-pill">
                    <i class="bi bi-fire me-1"></i><span>Dhokla &amp; Khandvi</span>
                </a>
                <a href="Menu.aspx?search=Fafda" class="category-pill">
                    <i class="bi bi-sun me-1"></i><span>Fafda Jalebi</span>
                </a>
                <a href="Menu.aspx?search=Undhiyu" class="category-pill">
                    <i class="bi bi-basket me-1"></i><span>Undhiyu Special</span>
                </a>
            </div>
        </div>
    </section>

    <!-- FOOD GRID SECTION -->
    <section class="py-5 bg-cream">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                <div>
                    <span class="fw-bold text-dark fs-5">
                        <asp:Label ID="lblCategoryTitle" runat="server" Text="All Dishes"></asp:Label>
                    </span>
                    <asp:Label ID="lblItemCountBadge" runat="server" CssClass="badge bg-secondary rounded-pill ms-2"></asp:Label>
                </div>
            </div>

            <!-- Empty Results State -->
            <asp:Panel ID="pnlNoResults" runat="server" Visible="false" CssClass="text-center py-5 bg-white rounded-4 shadow-sm p-5 border border-cream">
                <div class="mb-3 text-muted" style="font-size: 3.5rem;">
                    <i class="bi bi-emoji-frown"></i>
                </div>
                <h3>No Dishes Found</h3>
                <p class="text-muted mb-4">
                    We couldn't find any dish matching your search or filter. Try searching for something else or view all categories.
                </p>
                <a href="Menu.aspx" class="btn btn-primary">
                    <i class="bi bi-arrow-counterclockwise me-1"></i> Reset Menu Filter
                </a>
            </asp:Panel>

            <!-- Food Cards DataList -->
            <asp:DataList ID="DataList1" runat="server" RepeatLayout="Flow" OnItemCommand="DataList1_ItemCommand">
                <HeaderTemplate>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">
                </HeaderTemplate>
                <ItemTemplate>
                        <div class="col">
                            <div class="food-card">
                                <div class="food-img-container">
                                    <div class="card-badges">
                                        <%# ((bool)Eval("HasDiscount")) ? "<span class=\"badge-offer\"><i class=\"bi bi-tag-fill me-1\"></i> -" + Eval("DiscountPercentage") + "% OFF</span>" : "" %>
                                        <%# ((bool)Eval("IsChefSpecial")) ? "<span class=\"badge bg-warning text-dark font-sans-bold rounded-pill shadow-sm\"><i class=\"bi bi-star-fill text-danger me-1\"></i> Chef's Choice</span>" : "" %>
                                        <span class="badge-category"><%# Eval("Category") %></span>
                                    </div>

                                    <div class="card-dietary">
                                        <%# ((bool)Eval("IsVegetarian")) 
                                            ? "<span class=\"dietary-tag text-success\" title=\"Vegetarian\"><i class=\"bi bi-circle-fill\"></i></span>" 
                                            : "<span class=\"dietary-tag text-danger\" title=\"Non-Vegetarian\"><i class=\"bi bi-triangle-fill\"></i></span>" %>
                                        <%# ((bool)Eval("IsSpicy")) ? "<span class=\"dietary-tag text-danger\" title=\"Spicy\"><i class=\"bi bi-fire\"></i></span>" : "" %>
                                    </div>

                                    <a href='FoodDetails.aspx?id=<%# Eval("Id") %>' class="d-block h-100">
                                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="food-card-img" />
                                    </a>
                                </div>

                                <div class="food-card-body">
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <div class="text-warning small font-sans-bold">
                                            <i class="bi bi-star-fill"></i> <%# String.Format("{0:0.0}", Eval("Rating")) %>
                                            <span class="text-muted fw-normal">(<%# Eval("ReviewCount") %>)</span>
                                        </div>
                                        <div class="text-muted small">
                                            <i class="bi bi-clock me-1"></i><%# Eval("PreparationTimeMinutes") %> min
                                        </div>
                                    </div>

                                    <h3 class="food-card-title">
                                        <a href='FoodDetails.aspx?id=<%# Eval("Id") %>' class="text-dark text-decoration-none">
                                            <%# Eval("Name") %>
                                        </a>
                                    </h3>

                                    <p class="food-card-desc"><%# Eval("Description") %></p>

                                    <div class="food-card-footer pt-2">
                                        <div class="price-box">
                                            <span class="price-current">₹<%# String.Format("{0:0}", Eval("Price")) %></span>
                                            <%# ((bool)Eval("HasDiscount")) ? "<span class=\"price-original\">₹" + String.Format("{0:0}", Eval("OriginalPrice")) + "</span>" : "" %>
                                        </div>

                                        <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-primary btn-sm px-3 d-inline-flex align-items-center gap-1">
                                            <i class="bi bi-bag-plus fs-6"></i> Add
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:DataList>
        </div>
    </section>
</asp:Content>
