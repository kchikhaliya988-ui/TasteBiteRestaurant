<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TasteBiteRestaurant.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/home.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Success Alert (When an item is added) -->
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

    <!-- HERO BANNER SECTION -->
    <section class="hero-section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-9 col-xl-8 text-center">
                    <div class="hero-pill mb-3 mx-auto">
                        <i class="bi bi-fire text-danger fs-6"></i>
                        <span>Shuddh Shakahari &amp; Kathiyawadi Swad</span>
                    </div>

                    <h1 class="hero-title">
                        Authentic Gujarati &amp; <br />
                        <span class="text-highlight">Kathiyawadi Cuisine</span>
                    </h1>

                    <p class="lead text-muted mb-4 mx-auto" style="max-width: 650px;">
                        Welcome to <strong>TasteBite Restaurant</strong>! Savor traditional Kathiyawadi village platters, Royal Gujarati Thalis, piping hot Bajra Rotla with pure desi makhan, Surti Undhiyu, and fresh Farsan crafted with authentic heritage recipes.
                    </p>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mb-5">
                        <a href="Menu.aspx" class="btn btn-primary btn-lg d-inline-flex align-items-center gap-2">
                            <i class="bi bi-bag-check fs-5"></i> Order Now
                        </a>
                        <a href="Menu.aspx" class="btn btn-outline-primary-custom btn-lg d-inline-flex align-items-center gap-2">
                            <i class="bi bi-book fs-5"></i> Explore Menu
                        </a>
                    </div>

                    <!-- Quick Highlights -->
                    <div class="row g-3 pt-3 border-top border-warning-subtle justify-content-center">
                        <div class="col-sm-4 col-6">
                            <div class="d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-shield-check text-success fs-3"></i>
                                <div class="text-start">
                                    <div class="fw-bold">100% Pure Veg</div>
                                    <small class="text-muted">Shuddh Shakahari</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-6">
                            <div class="d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-fire text-danger fs-3"></i>
                                <div class="text-start">
                                    <div class="fw-bold">Clay-Tava Cooking</div>
                                    <small class="text-muted">Pure Desi Ghee</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-12">
                            <div class="d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-star-fill text-warning fs-3"></i>
                                <div class="text-start">
                                    <div class="fw-bold">4.9 / 5.0</div>
                                    <small class="text-muted">Over 10k Diners</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CATEGORY SHORTCUT STRIP -->
    <section class="py-5 bg-white border-bottom border-cream">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
                <div>
                    <span class="text-danger fw-bold text-uppercase small letter-spacing">Explore Categories</span>
                    <h2 class="mb-0">What are you craving today?</h2>
                </div>
                <a href="Menu.aspx" class="btn btn-outline-primary-custom btn-sm">
                    View All Items <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>

            <div class="row row-cols-2 row-cols-md-4 row-cols-lg-8 g-3 text-center">
                <div class="col">
                    <a href="Menu.aspx?category=Gujarati+Food" class="text-decoration-none">
                        <div class="card h-100 border-2 border-danger rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2 bg-danger text-white" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-star-fill text-warning"></i>
                            </div>
                            <div class="fw-bold text-danger small">Gujarati Menu</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Thali" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-disc"></i>
                            </div>
                            <div class="fw-bold text-dark small">Gujarati Thali</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Undhiyu" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-basket"></i>
                            </div>
                            <div class="fw-bold text-dark small">Undhiyu</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Fafda" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-sun"></i>
                            </div>
                            <div class="fw-bold text-dark small">Fafda Jalebi</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Dhokla" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-grid-3x3-gap"></i>
                            </div>
                            <div class="fw-bold text-dark small">Dhokla &amp; Khandvi</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Thepla" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-circle"></i>
                            </div>
                            <div class="fw-bold text-dark small">Methi Thepla</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Sev+Tameta" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-fire"></i>
                            </div>
                            <div class="fw-bold text-dark small">Sev Tameta</div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="Menu.aspx?search=Dal+Dhokli" class="text-decoration-none">
                        <div class="card h-100 border-1 border-light-subtle rounded-4 p-3 shadow-sm hover-lift text-center transition-all bg-cream">
                            <div class="feature-icon-wrapper mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem;">
                                <i class="bi bi-egg-fried"></i>
                            </div>
                            <div class="fw-bold text-dark small">Dal Dhokli</div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- POPULAR & CHEF SPECIAL DISHES (DYNAMIC FROM DATABASE) -->
    <section class="py-5 bg-white border-bottom border-cream">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                <div>
                    <span class="text-danger fw-bold text-uppercase small letter-spacing">Taste The Best</span>
                    <h2 class="mb-0">Popular &amp; Chef's Special Dishes</h2>
                </div>
                <a href="Menu.aspx" class="btn btn-outline-primary-custom btn-sm">
                    View Full Menu <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>

            <asp:DataList ID="dlPopular" runat="server" RepeatLayout="Flow" OnItemCommand="dlPopular_ItemCommand">
                <HeaderTemplate>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100 border-0 rounded-4 shadow-sm overflow-hidden bg-white hover-lift transition-all">
                            <div class="position-relative" style="height: 220px; overflow: hidden;">
                                <a href='FoodDetails.aspx?id=<%# Eval("FoodId") %>'>
                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="w-100 h-100 object-fit-cover" />
                                </a>
                                <span class="badge bg-danger position-absolute top-0 end-0 m-3 rounded-pill px-3 py-2 shadow-sm">
                                    <%# Eval("Category") %>
                                </span>
                            </div>
                            <div class="card-body p-4 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="text-warning small fw-bold">
                                            <i class="bi bi-star-fill"></i> <%# String.Format("{0:0.0}", Eval("Rating")) %>
                                        </span>
                                        <span class="text-muted small">
                                            <i class="bi bi-clock me-1"></i><%# Eval("PreparationTimeMinutes") %> mins
                                        </span>
                                    </div>
                                    <h4 class="card-title fw-bold text-dark mb-2">
                                        <a href='FoodDetails.aspx?id=<%# Eval("FoodId") %>' class="text-dark text-decoration-none">
                                            <%# Eval("Name") %>
                                        </a>
                                    </h4>
                                    <p class="card-text text-muted small line-clamp-2 mb-3">
                                        <%# Eval("Description") %>
                                    </p>
                                </div>
                                <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                    <div>
                                        <span class="fs-4 fw-bold text-danger">₹<%# String.Format("{0:0}", Eval("Price")) %></span></div>
                                    <div class="d-flex gap-2">
                                        <a href='FoodDetails.aspx?id=<%# Eval("FoodId") %>' class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                                            Details
                                        </a>
                                        <asp:LinkButton ID="btnAddCart" runat="server" CommandName="addtocart" CommandArgument='<%# Eval("FoodId") %>' CssClass="btn btn-sm btn-danger rounded-pill px-3">
                                            <i class="bi bi-bag-plus me-1"></i> Add
                                        </asp:LinkButton>
                                    </div>
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

    <!-- WHY CHOOSE TASTEBITE -->
    <section class="py-5 bg-cream">
        <div class="container">
            <div class="text-center mb-5">
                <span class="text-danger fw-bold text-uppercase small">Our Commitment</span>
                <h2 class="display-6 fw-bold">Why Food Lovers Choose TasteBite</h2>
            </div>

            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <i class="bi bi-clock-history"></i>
                        </div>
                        <h4>30-Min Delivery</h4>
                        <p class="text-muted small mb-0">
                            Our lightning-quick delivery fleet ensures your food arrives piping hot and fresh at your door.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <i class="bi bi-flower1"></i>
                        </div>
                        <h4>100% Farm Fresh</h4>
                        <p class="text-muted small mb-0">
                            We source crisp vegetables, dairy, and premium cuts from certified local organic family farms.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <i class="bi bi-award"></i>
                        </div>
                        <h4>Master Chefs</h4>
                        <p class="text-muted small mb-0">
                            Crafted under the visionary direction of seasoned executive chefs with 15+ years of kitchen mastery.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <i class="bi bi-heart-pulse"></i>
                        </div>
                        <h4>Hygienic &amp; Clean</h4>
                        <p class="text-muted small mb-0">
                            Adhering to strict international food safety standards and 100% tamper-evident packaging.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- TESTIMONIALS -->
    <section class="py-5 bg-white">
        <div class="container">
            <div class="text-center mb-5">
                <span class="text-danger fw-bold text-uppercase small">Real Reviews</span>
                <h2 class="display-6 fw-bold">What Our Foodies Say</h2>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="p-4 rounded-4 border border-light-subtle bg-cream h-100 shadow-sm">
                        <div class="text-warning mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                        </div>
                        <p class="fst-italic text-dark mb-4">
                            "The Gujarati Thali was wonderful! The dal dhokli, shaak, rotli, and kadhi were fresh, flavorful, and tasted just like a homemade Gujarati meal."
                        </p>
                        <div class="d-flex align-items-center gap-3">
                            <img src="images\krishna.png" 
                                 alt="Krishna Chikhaliya" 
                                 class="rounded-circle object-fit-cover" 
                                 style="width: 48px; height: 48px;" />
                            <div>
                                <div class="fw-bold">Krishna Chikhaliya</div>
                                <small class="text-muted">Verified Foodie</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 rounded-4 border border-light-subtle bg-cream h-100 shadow-sm">
                        <div class="text-warning mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                        </div>
                        <p class="fst-italic text-dark mb-4">
                            "The Undhiyu and soft methi thepla were delicious, with just the right blend of spices. Everything arrived hot and fresh. I will definitely order again!"
                        </p>
                        <div class="d-flex align-items-center gap-3">
                            <img src="images\harshil.png" 
                                 alt="Harshil Chotaliya" 
                                 class="rounded-circle object-fit-cover" 
                                 style="width: 48px; height: 48px;" />
                            <div>
                                <div class="fw-bold">Harshil Chotaliya</div>
                                <small class="text-muted">Food Blogger</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 rounded-4 border border-light-subtle bg-cream h-100 shadow-sm">
                        <div class="text-warning mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                        </div>
                        <p class="fst-italic text-dark mb-4">
                            "The fafda and jalebi were the perfect combination—crispy, fresh, and full of flavor. The handvo was also excellent. A lovely taste of Gujarati food!"
                        </p>
                        <div class="d-flex align-items-center gap-3">
                            <img src="images\milan.png" 
                                 alt="Milan Kanzariya" 
                                 class="rounded-circle object-fit-cover" 
                                 style="width: 48px; height: 48px;" />
                            <div>
                                <div class="fw-bold">Milan Kanzariya</div>
                                <small class="text-muted">Regular Guest</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CALL TO ACTION STRIP -->
    <section class="py-5" style="background: linear-gradient(135deg, var(--dark) 0%, #262220 100%);">
        <div class="container text-center text-white py-4">
            <h2 class="display-6 fw-bold text-white mb-3">Hungry? Treat Yourself to Pure Deliciousness!</h2>
            <p class="text-light-50 mb-4 mx-auto" style="max-width: 600px;">
                Order right now and get free delivery on all orders over ₹300. Fresh, fast, and packed with authentic culinary passion.
            </p>
            <a href="Menu.aspx" class="btn btn-primary btn-lg px-5">
                <i class="bi bi-cart3 me-2"></i> Order Online Now
            </a>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
