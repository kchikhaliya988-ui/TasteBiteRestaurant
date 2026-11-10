<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="TasteBiteRestaurant.CartPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/cart.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="py-5 bg-white border-bottom border-cream">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                <div>
                    <span class="text-danger fw-bold text-uppercase small">Delicious Choices</span>
                    <h1 class="display-6 fw-bold mb-0">Your Shopping Cart</h1>
                </div>
                <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" CssClass="btn btn-outline-danger btn-sm rounded-pill" OnClick="btnClearCart_Click" OnClientClick="return confirm('Are you sure you want to clear your cart?');" />
            </div>
        </div>
    </section>

    <section class="py-5 bg-cream">
        <div class="container">
            <!-- Alert Messages -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="mb-4">
                <div class="alert alert-info alert-dismissible fade show rounded-4 shadow-sm" role="alert">
                    <asp:Literal ID="litAlertMessage" runat="server"></asp:Literal>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </asp:Panel>

            <!-- EMPTY CART STATE -->
            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                <div class="card border-0 rounded-4 shadow-sm text-center p-5 bg-white mx-auto my-4" style="max-width: 600px;">
                    <div class="mb-3 text-warning" style="font-size: 4.5rem;">
                        <i class="bi bi-cart-x"></i>
                    </div>
                    <h2 class="fw-bold mb-2">Your Cart is Currently Empty</h2>
                    <p class="text-muted mb-4">
                        Looks like you haven't added any appetizing dishes yet! Explore our chef-curated pizzas, sizzling burgers, fragrant biryanis, and decadent desserts.
                    </p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="Menu.aspx" class="btn btn-primary btn-lg px-4">
                            <i class="bi bi-journal-richtext me-2"></i> Browse Delicious Menu
                        </a>
                    </div>
                </div>
            </asp:Panel>

            <!-- FILLED CART VIEW -->
            <asp:Panel ID="pnlFilledCart" runat="server">
                <div class="row g-4">
                    <!-- Cart Items List -->
                    <div class="col-lg-8">
                        <div class="cart-card">
                            <div class="table-responsive">
                                <table class="table cart-table align-middle mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="min-width: 250px;">Dish</th>
                                            <th scope="col" class="text-center">Price</th>
                                            <th scope="col" class="text-center" style="min-width: 150px;">Quantity</th>
                                            <th scope="col" class="text-end">Total</th>
                                            <th scope="col" class="text-center"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("FoodName") %>' class="cart-thumb" />
                                                            <div>
                                                                <a href='FoodDetails.aspx?id=<%# Eval("FoodId") %>' class="fw-bold text-dark text-decoration-none">
                                                                    <%# Eval("FoodName") %>
                                                                </a>
                                                                <div class="small text-muted"><%# Eval("Category") %></div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center fw-semibold">
                                                        ₹<%# String.Format("{0:0}", Eval("UnitPrice")) %>
                                                    </td>
                                                    <td class="text-center">
                                                        <div class="quantity-selector">
                                                            <asp:LinkButton ID="btnDecrease" runat="server" CommandName="Decrease" CommandArgument='<%# Eval("FoodId") %>' CssClass="qty-btn" Text="-"></asp:LinkButton>
                                                            <span class="qty-input d-inline-block text-center pt-1"><%# Eval("Quantity") %></span>
                                                            <asp:LinkButton ID="btnIncrease" runat="server" CommandName="Increase" CommandArgument='<%# Eval("FoodId") %>' CssClass="qty-btn" Text="+"></asp:LinkButton>
                                                        </div>
                                                    </td>
                                                    <td class="text-end fw-bold text-primary-hover fs-6">
                                                        ₹<%# String.Format("{0:0}", Eval("TotalPrice")) %>
                                                    </td>
                                                    <td class="text-center">
                                                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveItem" CommandArgument='<%# Eval("FoodId") %>' CssClass="text-danger p-0 border-0 bg-transparent" ToolTip="Remove Item">
                                                            <i class="bi bi-x-circle-fill fs-5"></i>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-4 flex-wrap gap-2">
                            <a href="Menu.aspx" class="btn btn-outline-secondary rounded-pill">
                                <i class="bi bi-arrow-left me-1"></i> Add More Food
                            </a>
                            <div class="small text-muted">
                                <i class="bi bi-shield-lock-fill text-success me-1"></i> 100% Safe &amp; Contactless Delivery
                            </div>
                        </div>
                    </div>

                    <!-- Summary Sidebar -->
                    <div class="col-lg-4">
                        <div class="summary-card">
                            <h4 class="fw-bold mb-4">Order Summary</h4>

                            <!-- Coupon Code Form -->
                            <div class="mb-4 pb-3 border-bottom border-light-subtle">
                                <label class="form-label small fw-bold text-muted">Have a Coupon Code?</label>

                                <asp:Panel ID="pnlCouponApplied" runat="server" Visible="false" CssClass="p-2 bg-success-subtle rounded-3 d-flex align-items-center justify-content-between text-success">
                                    <div>
                                        <i class="bi bi-tag-fill me-1"></i>
                                        <strong><asp:Literal ID="litAppliedCoupon" runat="server"></asp:Literal></strong> Applied!
                                    </div>
                                    <asp:LinkButton ID="btnRemoveCoupon" runat="server" CssClass="text-danger small text-decoration-none" OnClick="btnRemoveCoupon_Click" ToolTip="Remove Coupon">
                                        <i class="bi bi-x fs-5"></i>
                                    </asp:LinkButton>
                                </asp:Panel>

                                <asp:Panel ID="pnlCouponInput" runat="server" CssClass="d-flex gap-2">
                                    <asp:TextBox ID="txtCoupon" runat="server" CssClass="form-control rounded-pill text-uppercase" placeholder="e.g. TASTE20"></asp:TextBox>
                                    <asp:Button ID="btnApplyCoupon" runat="server" Text="Apply" CssClass="btn btn-dark rounded-pill px-3" OnClick="btnApplyCoupon_Click" />
                                </asp:Panel>

                                <div class="mt-2 small text-muted">
                                    Try: <span class="badge bg-light text-dark border">TASTE20</span> (20% off) or <span class="badge bg-light text-dark border">WELCOME50</span> (₹50 off)
                                </div>
                            </div>

                            <!-- Financial Breakdown -->
                            <div class="summary-row">
                                <span>Subtotal (<asp:Literal ID="litItemCount" runat="server"></asp:Literal> items)</span>
                                <span class="fw-semibold text-dark">₹<asp:Literal ID="litSubTotal" runat="server"></asp:Literal></span>
                            </div>

                            <div class="summary-row">
                                <span>Delivery Fee <asp:Literal ID="litFreeDeliveryBadge" runat="server"></asp:Literal></span>
                                <span class="fw-semibold text-dark"><asp:Literal ID="litDeliveryFee" runat="server"></asp:Literal></span>
                            </div>

                            <asp:Panel ID="pnlFreeShippingPrompt" runat="server" Visible="false" CssClass="alert alert-warning py-1 px-2 small mb-3 rounded-3">
                                <i class="bi bi-info-circle me-1"></i> Add <strong>₹<asp:Literal ID="litRemainingForFree" runat="server"></asp:Literal></strong> more for <strong>FREE Delivery</strong>!
                            </asp:Panel>

                            <div class="summary-row">
                                <span>Tax (5% GST)</span>
                                <span class="fw-semibold text-dark">₹<asp:Literal ID="litTax" runat="server"></asp:Literal></span>
                            </div>

                            <asp:Panel ID="pnlDiscountRow" runat="server" Visible="false" CssClass="summary-row text-success">
                                <span>Discount (<asp:Literal ID="litDiscountCodeName" runat="server"></asp:Literal>)</span>
                                <span class="fw-bold">-₹<asp:Literal ID="litDiscountAmount" runat="server"></asp:Literal></span>
                            </asp:Panel>

                            <div class="summary-row total-row">
                                <span>Total Amount</span>
                                <span class="text-danger">₹<asp:Literal ID="litGrandTotal" runat="server"></asp:Literal></span>
                            </div>

                            <a href="Checkout.aspx" class="btn btn-primary btn-lg w-100 mt-4 d-flex align-items-center justify-content-center gap-2">
                                <span>Proceed to Checkout</span>
                                <i class="bi bi-arrow-right"></i>
                            </a>

                            <div class="text-center mt-3">
                                <small class="text-muted">
                                    <i class="bi bi-clock-history me-1"></i> Estimated Delivery: 30 - 40 Mins
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </section>
</asp:Content>
