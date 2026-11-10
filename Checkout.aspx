<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="TasteBiteRestaurant.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/checkout.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="py-4 bg-white border-bottom border-cream">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                    <li class="breadcrumb-item"><a href="Cart.aspx">Cart</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                </ol>
            </nav>
            <h1 class="display-6 fw-bold mt-2 mb-0">Delivery Details &amp; Payment</h1>
        </div>
    </section>

    <section class="py-5 bg-cream">
        <div class="container">
            <div class="row g-4">
                <!-- Customer Details & Payment (Left Column) -->
                <div class="col-lg-7">
                    <!-- Delivery Address Box -->
                    <div class="checkout-box mb-4">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="rounded-circle bg-danger text-white d-inline-flex align-items-center justify-content-center" style="width: 32px; height: 32px; font-weight: bold;">1</span>
                            <h4 class="mb-0 fw-bold">Customer &amp; Delivery Information</h4>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Full Name *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-person"></i></span>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="John Doe"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full name is required." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Mobile Number *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-telephone"></i></span>
                                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="+1 (555) 000-0000"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="Mobile number is required." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label small fw-bold text-muted">Email Address *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-envelope"></i></span>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="john.doe@example.com"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-12">
                                <label class="form-label small fw-bold text-muted">Delivery Address *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-geo-alt"></i></span>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Street address, Apartment, Suite, Floor..."></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Delivery address is required." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">City *</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City or Town"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6">
                                Pin
                                <label class="form-label small fw-bold text-muted">&nbsp;Code *</label>
                                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control" placeholder="Pin Code"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPostalCode" runat="server" ControlToValidate="txtPostalCode" ErrorMessage="Postal code is required." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-12">
                                <label class="form-label small fw-bold text-muted">Special Delivery Notes (Optional)</label>
                                <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="e.g. Ring doorbell twice, extra napkins..."></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method Box -->
                    <div class="checkout-box">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="rounded-circle bg-danger text-white d-inline-flex align-items-center justify-content-center" style="width: 32px; height: 32px; font-weight: bold;">2</span>
                            <h4 class="mb-0 fw-bold">Select Payment Method</h4>
                        </div>

                        <!-- Option 1: Cash on Delivery -->
                        <label class="payment-card-option selected" id="optCOD">
                            <asp:RadioButton ID="rdoCashOnDelivery" runat="server" GroupName="PaymentMethod" Checked="true" onclick="togglePayment(false)" />
                            <div class="feature-icon-wrapper mb-0" style="width: 44px; height: 44px; font-size: 1.25rem;">
                                <i class="bi bi-cash-coin"></i>
                            </div>
                            <div class="flex-grow-1">
                                <div class="fw-bold text-dark">Cash on Delivery (COD)</div>
                                <div class="small text-muted">Pay comfortably with cash or mobile UPI/card when your food arrives.</div>
                            </div>
                        </label>

                        <!-- Option 2: Demo Online Payment -->
                        <label class="payment-card-option" id="optDemoOnline">
                            <asp:RadioButton ID="rdoDemoOnlinePayment" runat="server" GroupName="PaymentMethod" onclick="togglePayment(true)" />
                            <div class="feature-icon-wrapper mb-0 bg-info-subtle text-info" style="width: 44px; height: 44px; font-size: 1.25rem;">
                                <i class="bi bi-credit-card-2-front"></i>
                            </div>
                            <div class="flex-grow-1">
                                <div class="fw-bold text-dark">Demo Online Payment</div>
                                <div class="small text-muted">Instant simulated test transaction (No real money or card required).</div>
                            </div>
                        </label>

                        <!-- Demo Card Subform -->
                        <div id="demoCardDetailsSection" class="p-3 bg-cream rounded-3 border border-cream mt-3" style="display: none;">
                            <div class="badge bg-warning text-dark mb-2 font-sans-bold">
                                <i class="bi bi-info-circle me-1"></i> Demo Sandbox Mode
                            </div>
                            <p class="small text-muted mb-3">You can enter test mock numbers below or proceed directly:</p>

                            <div class="row g-2">
                                <div class="col-md-7">
                                    <label class="form-label small text-muted">Cardholder Name</label>
                                    <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control form-control-sm" placeholder="John Doe"></asp:TextBox>
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label small text-muted">Card Number (Demo)</label>
                                    <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control form-control-sm" placeholder="4532 •••• •••• 8899"></asp:TextBox>
                                </div>
                                <div class="col-6">
                                    <label class="form-label small text-muted">Expiry (MM/YY)</label>
                                    <asp:TextBox ID="txtCardExpiry" runat="server" CssClass="form-control form-control-sm" placeholder="12/28"></asp:TextBox>
                                </div>
                                <div class="col-6">
                                    <label class="form-label small text-muted">CVV</label>
                                    <asp:TextBox ID="txtCardCvv" runat="server" CssClass="form-control form-control-sm" placeholder="•••"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Summary (Right Column) -->
                <div class="col-lg-5">
                    <div class="summary-card">
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom border-light-subtle">
                            <h4 class="fw-bold mb-0">Your Order</h4>
                            <a href="Cart.aspx" class="btn btn-outline-secondary btn-sm rounded-pill">Edit Cart</a>
                        </div>

                        <!-- List of items -->
                        <div class="mb-4" style="max-height: 280px; overflow-y: auto;">
                            <asp:Repeater ID="rptSummaryItems" runat="server">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center justify-content-between py-2 border-bottom border-light-subtle">
                                        <div class="d-flex align-items-center gap-2">
                                            <span class="badge bg-danger rounded-pill"><%# Eval("Quantity") %>&times;</span>
                                            <div>
                                                <div class="fw-bold small text-dark"><%# Eval("FoodName") %></div>
                                                <div class="text-muted" style="font-size: 0.8rem;">₹<%# String.Format("{0:0}", Eval("UnitPrice")) %> each</div>
                                            </div>
                                        </div>
                                        <div class="fw-bold small text-dark">
                                            ₹<%# String.Format("{0:0}", Eval("TotalPrice")) %>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <!-- Financial Breakdown -->
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>₹<asp:Literal ID="litSubTotal" runat="server"></asp:Literal></span>
                        </div>

                        <div class="summary-row">
                            <span>Delivery Fee</span>
                            <span><asp:Literal ID="litDeliveryFee" runat="server"></asp:Literal></span>
                        </div>

                        <div class="summary-row">
                            <span>Tax (5% GST)</span>
                            <span>₹<asp:Literal ID="litTax" runat="server"></asp:Literal></span>
                        </div>

                        <asp:Panel ID="pnlDiscountRow" runat="server" Visible="false" CssClass="summary-row text-success">
                            <span>Discount (<asp:Literal ID="litCouponCode" runat="server"></asp:Literal>)</span>
                            <span>-₹<asp:Literal ID="litDiscountAmount" runat="server"></asp:Literal></span>
                        </asp:Panel>

                        <div class="summary-row total-row">
                            <span>Grand Total</span>
                            <span class="text-danger fs-3">₹<asp:Literal ID="litGrandTotal" runat="server"></asp:Literal></span>
                        </div>

                        <!-- Place Order Button -->
                        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order Now" CssClass="btn btn-primary btn-lg w-100 mt-4 d-flex align-items-center justify-content-center gap-2 py-3 shadow" OnClick="btnPlaceOrder_Click" />

                        <div class="text-center mt-3 text-muted small">
                            <i class="bi bi-lock-fill text-success me-1"></i> SSL Encrypted &amp; Secure Order Transmission
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        function togglePayment(isOnline) {
            var section = document.getElementById('demoCardDetailsSection');
            var optCOD = document.getElementById('optCOD');
            var optDemo = document.getElementById('optDemoOnline');

            if (isOnline) {
                section.style.display = 'block';
                optDemo.classList.add('selected');
                optCOD.classList.remove('selected');
            } else {
                section.style.display = 'none';
                optCOD.classList.add('selected');
                optDemo.classList.remove('selected');
            }
        }
    </script>
</asp:Content>
