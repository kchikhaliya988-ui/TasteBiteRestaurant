<%@ Page Title="Food Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FoodDetails.aspx.cs" Inherits="TasteBiteRestaurant.FoodDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/food-details.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumbs -->
    <section class="py-3 bg-white border-bottom border-cream">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                    <li class="breadcrumb-item"><a href="Menu.aspx">Menu</a></li>
                    <li class="breadcrumb-item"><asp:HyperLink ID="hlCategory" runat="server"></asp:HyperLink></li>
                    <li class="breadcrumb-item active" aria-current="page"><asp:Literal ID="litBreadcrumbName" runat="server"></asp:Literal></li>
                </ol>
            </nav>
        </div>
    </section>

    <!-- Main Food Details -->
    <section class="py-5 bg-cream">
        <div class="container">
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="mb-4">
                <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm d-flex align-items-center gap-2" role="alert">
                    <i class="bi bi-check-circle-fill fs-5"></i>
                    <div>
                        <asp:Label ID="lblSuccessMessage" runat="server"></asp:Label>
                    </div>
                    <a href="Cart.aspx" class="btn btn-sm btn-success ms-auto rounded-pill px-3">View Cart</a>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </asp:Panel>

            <div class="details-hero">
                <div class="row g-5 align-items-center">
                    <!-- Large Image Showcase -->
                    <div class="col-lg-6">
                        <div class="details-img-container position-relative">
                            <asp:Image ID="imgFood" runat="server" CssClass="details-img" />

                            <div class="card-badges position-absolute top-0 start-0 m-3">
                                <asp:Label ID="lblDiscountBadge" runat="server" CssClass="badge-offer fs-6" Visible="false"></asp:Label>
                                <asp:Label ID="lblChefSpecialBadge" runat="server" CssClass="badge bg-warning text-dark font-sans-bold rounded-pill p-2 px-3 shadow-sm" Visible="false">
                                    <i class="bi bi-award-fill text-danger me-1"></i> Chef's Signature
                                </asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Food Info & Ordering Controls -->
                    <div class="col-lg-6">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <asp:Label ID="lblCategoryTag" runat="server" CssClass="badge bg-dark text-white rounded-pill px-3 py-2"></asp:Label>
                            <asp:Label ID="lblDietaryTag" runat="server" CssClass="badge rounded-pill px-3 py-2"></asp:Label>
                            <asp:Label ID="lblSpicyTag" runat="server" CssClass="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3 py-2" Visible="false">
                                <i class="bi bi-fire me-1"></i> Spicy Dish
                            </asp:Label>
                        </div>

                        <h1 class="display-6 fw-bold mb-3"><asp:Literal ID="litFoodName" runat="server"></asp:Literal></h1>

                        <div class="d-flex align-items-center gap-4 mb-4 text-muted small">
                            <div class="text-warning font-sans-bold fs-6">
                                <i class="bi bi-star-fill"></i> <asp:Literal ID="litRating" runat="server"></asp:Literal>
                                <span class="text-muted fw-normal">(<asp:Literal ID="litReviews" runat="server"></asp:Literal> reviews)</span>
                            </div>
                            <div>
                                <i class="bi bi-stopwatch text-danger me-1"></i> <asp:Literal ID="litPrepTime" runat="server"></asp:Literal> mins prep
                            </div>
                            <div>
                                <i class="bi bi-truck text-primary me-1"></i> Free delivery over ₹300
                            </div>
                        </div>

                        <!-- Price Box -->
                        <div class="p-3 rounded-4 bg-cream border border-cream mb-4 d-inline-flex align-items-baseline gap-3">
                            <span class="fs-1 fw-bold text-danger">₹<asp:Literal ID="litPrice" runat="server"></asp:Literal></span>
                            <asp:Label ID="lblOriginalPrice" runat="server" CssClass="fs-4 text-muted text-decoration-line-through" Visible="false"></asp:Label>
                        </div>

                        <p class="text-muted fs-6 mb-4 leading-relaxed">
                            <asp:Literal ID="litDescription" runat="server"></asp:Literal>
                        </p>

                        <!-- Ingredients Chips -->
                        <div class="mb-4">
                            <h6 class="fw-bold text-dark text-uppercase small mb-2">Key Ingredients</h6>
                            <div class="d-flex flex-wrap gap-2">
                                <asp:Repeater ID="rptIngredients" runat="server">
                                    <ItemTemplate>
                                        <span class="ingredient-badge">
                                            <i class="bi bi-check2 text-danger"></i> <%# Container.DataItem %>
                                        </span>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>

                        <!-- Quantity Selector and Add to Cart Button -->
                        <div class="pt-3 border-top border-light-subtle">
                            <div class="row g-3 align-items-center">
                                <div class="col-sm-5 col-6">
                                    <label class="form-label small text-muted fw-bold mb-1">Quantity</label>
                                    <div class="quantity-selector">
                                        <button type="button" class="qty-btn" onclick="decreaseQty()">-</button>
                                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" TextMode="Number" min="1" max="20" CssClass="qty-input"></asp:TextBox>
                                        <button type="button" class="qty-btn" onclick="increaseQty()">+</button>
                                    </div>
                                </div>

                                <div class="col-sm-7 col-6">
                                    <label class="form-label d-none d-sm-block small text-transparent mb-1">&nbsp;</label>
                                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary btn-lg w-100 d-flex align-items-center justify-content-center gap-2" OnClick="btnAddToCart_Click" />
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 border-top border-light-subtle d-flex gap-3">
                            <a href="Menu.aspx" class="btn btn-outline-secondary rounded-pill btn-sm">
                                <i class="bi bi-arrow-left me-1"></i> Back to Menu
                            </a>
                            <a href="Cart.aspx" class="btn btn-outline-primary-custom rounded-pill btn-sm">
                                <i class="bi bi-cart3 me-1"></i> View Cart
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- RELATED DISHES SECTION -->
    <asp:Panel ID="pnlRelated" runat="server" CssClass="py-5 bg-white">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <span class="text-danger fw-bold text-uppercase small">Pair It With</span>
                    <h2 class="mb-0">More From <asp:Literal ID="litRelatedCategory" runat="server"></asp:Literal></h2>
                </div>
                <asp:HyperLink ID="hlViewAllRelated" runat="server" CssClass="btn btn-outline-primary-custom btn-sm">View Category</asp:HyperLink>
            </div>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                <asp:Repeater ID="rptRelatedFoods" runat="server" OnItemCommand="rptRelatedFoods_ItemCommand">
                    <ItemTemplate>
                        <div class="col">
                            <div class="food-card">
                                <div class="food-img-container">
                                    <div class="card-badges">
                                        <span class="badge-category"><%# Eval("Category") %></span>
                                    </div>
                                    <a href='FoodDetails.aspx?id=<%# Eval("Id") %>' class="d-block h-100">
                                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="food-card-img" />
                                    </a>
                                </div>
                                <div class="food-card-body">
                                    <h3 class="food-card-title">
                                        <a href='FoodDetails.aspx?id=<%# Eval("Id") %>' class="text-dark text-decoration-none">
                                            <%# Eval("Name") %>
                                        </a>
                                    </h3>
                                    <p class="food-card-desc"><%# Eval("Description") %></p>
                                    <div class="food-card-footer pt-2">
                                        <span class="price-current">₹<%# String.Format("{0:0}", Eval("Price")) %></span>
                                        <asp:LinkButton ID="btnQuickAdd" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-primary btn-sm px-3">
                                            <i class="bi bi-bag-plus"></i> Add
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function decreaseQty() {
            var txt = document.getElementById('<%= txtQuantity.ClientID %>');
            var val = parseInt(txt.value) || 1;
            if (val > 1) {
                txt.value = val - 1;
            }
        }
        function increaseQty() {
            var txt = document.getElementById('<%= txtQuantity.ClientID %>');
            var val = parseInt(txt.value) || 1;
            if (val < 20) {
                txt.value = val + 1;
            }
        }
    </script>
</asp:Content>
