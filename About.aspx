<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TasteBiteRestaurant.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/about.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ABOUT US HERO BANNER -->
    <section class="py-5 bg-white border-bottom border-cream">
        <div class="container text-center">
            <span class="text-danger fw-bold text-uppercase small">Passion Behind Every Dish</span>
            <h1 class="display-5 fw-bold mt-1 mb-3">Our Culinary Story &amp; Heritage</h1>
            <p class="text-muted mx-auto" style="max-width: 650px;">
                Founded with a passion for bringing families and friends together around extraordinary tables, TasteBite is a tribute to authentic recipes, genuine hospitality, and artisan craftsmanship.
            </p>
        </div>
    </section>

    <!-- STORY & PHILOSOPHY -->
    <section class="py-5 bg-cream">
        <div class="container">
            <div class="row align-items-center g-5 mb-5">
                <div class="col-lg-6">
                    <div class="position-relative">
                        <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=800&q=80" 
                             alt="TasteBite Kitchen Ambience" 
                             class="rounded-4 shadow-lg w-100 object-fit-cover" 
                             style="height: 420px;" />
                        <div class="position-absolute bottom-0 end-0 bg-dark text-white p-3 rounded-4 m-3 shadow">
                            <div class="fw-bold fs-4 text-warning">15+ Years</div>
                            <div class="small text-muted">Of Culinary Excellence</div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <span class="text-danger fw-bold text-uppercase small">How It Began</span>
                    <h2 class="display-6 fw-bold mb-3">From a Small Wood-Fired Oven to a City Favorite</h2>
                    <p class="text-muted leading-relaxed">
                        TasteBite started in 2011 with a simple dream: to serve wholesome, uncompromised meals made with real ingredients and sincere love. Over the years, our menu has expanded to embrace the world's most beloved comfort dishes—from crispy Neapolitan pizzas and gourmet beef burgers to rich, slow-simmered royal Indian curries.
                    </p>
                    <p class="text-muted leading-relaxed">
                        We believe good food requires patience. Our sourdough pizza bases ferment for 48 hours, our biryanis are sealed with traditional dough for authentic dum steaming, and our burger patties are hand-pressed daily from select Angus cuts.
                    </p>

                    <div class="d-flex gap-4 pt-3">
                        <div>
                            <h3 class="fw-bold text-danger mb-0">50K+</h3>
                            <small class="text-muted">Meals Served</small>
                        </div>
                        <div class="border-start ps-4">
                            <h3 class="fw-bold text-danger mb-0">100%</h3>
                            <small class="text-muted">Fresh Ingredients</small>
                        </div>
                        <div class="border-start ps-4">
                            <h3 class="fw-bold text-danger mb-0">4.9 ★</h3>
                            <small class="text-muted">Average Rating</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- CORE VALUES -->
            <div class="row g-4 mt-4">
                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-4 border border-light-subtle h-100 shadow-sm text-center">
                        <div class="feature-icon-wrapper mx-auto">
                            <i class="bi bi-tree"></i>
                        </div>
                        <h4 class="fw-bold">Farm-to-Fork Sourcing</h4>
                        <p class="text-muted small mb-0">
                            We partner with certified local organic producers, guaranteeing fresh vegetables, pure dairy, and chemical-free meats.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-4 border border-light-subtle h-100 shadow-sm text-center">
                        <div class="feature-icon-wrapper mx-auto">
                            <i class="bi bi-heart"></i>
                        </div>
                        <h4 class="fw-bold">Traditional Mastery</h4>
                        <p class="text-muted small mb-0">
                            No microwave shortcuts or processed pastes. All sauces, dressings, doughs, and broths are simmered from scratch every morning.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-4 border border-light-subtle h-100 shadow-sm text-center">
                        <div class="feature-icon-wrapper mx-auto">
                            <i class="bi bi-recycle"></i>
                        </div>
                        <h4 class="fw-bold">Eco-Friendly Delivery</h4>
                        <p class="text-muted small mb-0">
                            Our takeout boxes and cutlery are 100% biodegradable, keeping your meals piping hot while preserving our environment.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MASTER CHEFS TEAM -->
    <section class="py-5 bg-white">
        <div class="container">
            <div class="text-center mb-5">
                <span class="text-danger fw-bold text-uppercase small">The Culinary Artists</span>
                <h2 class="display-6 fw-bold">Meet Our Gujarati Master Maharajs</h2>
                <p class="text-muted mx-auto" style="max-width: 550px;">
                    Master chefs and maharajs steeped in generations of traditional Gujarati, Kathiyawadi, and Surti culinary artistry.
                </p>
            </div>

            <div class="row g-4 justify-content-center">
                <div class="col-md-4 col-sm-6">
                    <div class="card border-0 rounded-4 overflow-hidden shadow-sm h-100 text-center bg-cream">
                        <img src="images/chef_hasmukh_patel.jpg" 
                             alt="Maharaj Hasmukh Patel" 
                             class="w-100 object-fit-cover" 
                             style="height: 320px;" />
                        <div class="p-4">
                            <h4 class="fw-bold mb-1">Maharaj Hasmukh Patel</h4>
                            <div class="text-danger small fw-semibold mb-2">Head Maharaj &amp; Kathiyawadi Specialist</div>
                            <p class="text-muted small mb-0">
                                Master of authentic Kathiyawadi cuisine, charcoal-smoked Ringan no Olo, and clay-tava Bajra Rotlas with over 22 years of Saurashtra heritage cooking.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6">
                    <div class="card border-0 rounded-4 overflow-hidden shadow-sm h-100 text-center bg-cream">
                        <img src="images/chef_bhavesh_dave.jpg" 
                             alt="Maharaj Bhavesh Dave" 
                             class="w-100 object-fit-cover" 
                             style="height: 320px;" />
                        <div class="p-4">
                            <h4 class="fw-bold mb-1">Maharaj Bhavesh Dave</h4>
                            <div class="text-danger small fw-semibold mb-2">Master Chef - Surti Undhiyu &amp; Farsan</div>
                            <p class="text-muted small mb-0">
                                Specialist in authentic slow-cooked Surti Undhiyu, melt-in-mouth nylon khaman, spiced khandvi rolls, and seasonal Gujarati farsan.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6">
                    <div class="card border-0 rounded-4 overflow-hidden shadow-sm h-100 text-center bg-cream">
                        <img src="images/chef_ketan_trivedi.jpg" 
                             alt="Maharaj Ketan Trivedi" 
                             class="w-100 object-fit-cover" 
                             style="height: 320px;" />
                        <div class="p-4">
                            <h4 class="fw-bold mb-1">Maharaj Ketan Trivedi</h4>
                            <div class="text-danger small fw-semibold mb-2">Head Maharaj - Royal Gujarati Thali &amp; Mithai</div>
                            <p class="text-muted small mb-0">
                                Custodian of traditional Royal Gujarati Thalis, authentic sweet-tangy khatti meethi dal, and festive sweets like Kesar Shrikhand and Mohanthal.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="Menu.aspx" class="btn btn-primary btn-lg">
                    <i class="bi bi-cart3 me-1"></i> Taste Their Creations Today
                </a>
            </div>
        </div>
    </section>
</asp:Content>
