<%@ Page Title="Order Confirmed" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="TasteBiteRestaurant.OrderConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/order-confirmation.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="py-5 bg-cream">
        <div class="container">
            <div class="confirmation-card mx-auto" style="max-width: 820px;">
                <!-- Success Icon -->
                <div class="order-success-icon">
                    <i class="bi bi-check2"></i>
                </div>

                <h1 class="display-6 fw-bold text-dark mb-2">Order Confirmed!</h1>
                <p class="text-muted fs-5 mb-4">
                    Thank you, <strong><asp:Literal ID="litCustomerName" runat="server"></asp:Literal></strong>! We've received your order and the kitchen is already heating up the ovens.
                </p>

                <div class="mb-4">
                    <span class="text-muted small d-block mb-1">Your Temporary Order Number</span>
                    <span class="order-badge-pill"><asp:Literal ID="litOrderId" runat="server"></asp:Literal></span>
                </div>

                <!-- Delivery Tracker Timeline -->
                <div class="timeline-steps">
                    <div class="timeline-step completed">
                        <div class="timeline-icon">
                            <i class="bi bi-receipt"></i>
                        </div>
                        <div class="fw-bold small">Order Placed</div>
                        <div class="text-muted" style="font-size: 0.75rem;"><asp:Literal ID="litOrderTime" runat="server"></asp:Literal></div>
                    </div>

                    <div class="timeline-step active">
                        <div class="timeline-icon">
                            <i class="bi bi-fire"></i>
                        </div>
                        <div class="fw-bold small">In The Kitchen</div>
                        <div class="text-muted" style="font-size: 0.75rem;">Freshly Preparing</div>
                    </div>

                    <div class="timeline-step">
                        <div class="timeline-icon">
                            <i class="bi bi-bicycle"></i>
                        </div>
                        <div class="fw-bold small">Out For Delivery</div>
                        <div class="text-muted" style="font-size: 0.75rem;">Est. ~35 min</div>
                    </div>

                    <div class="timeline-step">
                        <div class="timeline-icon">
                            <i class="bi bi-house-door"></i>
                        </div>
                        <div class="fw-bold small">Delivered</div>
                        <div class="text-muted" style="font-size: 0.75rem;">Bon Appétit!</div>
                    </div>
                </div>

                <!-- Delivery & Payment Information Cards -->
                <div class="row g-3 text-start mb-4">
                    <div class="col-md-6">
                        <div class="p-3 rounded-4 bg-cream border border-cream h-100">
                            <h6 class="fw-bold text-dark mb-2"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Delivery Address</h6>
                            <div class="fw-semibold"><asp:Literal ID="litCustNameAddress" runat="server"></asp:Literal></div>
                            <div class="text-muted small"><asp:Literal ID="litDeliveryAddress" runat="server"></asp:Literal></div>
                            <div class="text-muted small"><asp:Literal ID="litCityPostal" runat="server"></asp:Literal></div>
                            <div class="text-muted small mt-2">
                                <i class="bi bi-telephone text-primary me-1"></i> <asp:Literal ID="litMobile" runat="server"></asp:Literal>
                            </div>
                            <div class="text-muted small">
                                <i class="bi bi-envelope text-primary me-1"></i> <asp:Literal ID="litEmail" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="p-3 rounded-4 bg-cream border border-cream h-100">
                            <h6 class="fw-bold text-dark mb-2"><i class="bi bi-credit-card-2-front-fill text-warning me-1"></i> Payment &amp; Notes</h6>
                            <div class="text-muted small mb-1">
                                Payment Method: <span class="badge bg-dark text-white"><asp:Literal ID="litPaymentMethod" runat="server"></asp:Literal></span>
                            </div>
                            <div class="text-muted small mb-2">
                                Status: <span class="badge bg-success"><asp:Literal ID="litStatus" runat="server"></asp:Literal></span>
                            </div>
                            <asp:Panel ID="pnlNotes" runat="server" Visible="false" CssClass="p-2 rounded bg-white small text-muted border">
                                <strong>Notes:</strong> <asp:Literal ID="litNotes" runat="server"></asp:Literal>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <!-- Itemized Receipt Table -->
                <div class="text-start mb-4">
                    <h5 class="fw-bold mb-3">Order Receipt Details</h5>
                    <div class="table-responsive rounded-3 border">
                        <table class="table align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Item</th>
                                    <th class="text-center">Qty</th>
                                    <th class="text-end">Unit Price</th>
                                    <th class="text-end">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptReceiptItems" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <div class="fw-semibold text-dark"><%# Eval("FoodName") %></div>
                                                <small class="text-muted"><%# Eval("Category") %></small>
                                            </td>
                                            <td class="text-center fw-bold"><%# Eval("Quantity") %></td>
                                            <td class="text-end">₹<%# String.Format("{0:0}", Eval("UnitPrice")) %></td>
                                            <td class="text-end fw-bold">₹<%# String.Format("{0:0}", Eval("TotalPrice")) %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                            <tfoot class="border-top">
                                <tr>
                                    <td colspan="3" class="text-end text-muted">Subtotal:</td>
                                    <td class="text-end fw-semibold">₹<asp:Literal ID="litSubTotal" runat="server"></asp:Literal></td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="text-end text-muted">Delivery Fee:</td>
                                    <td class="text-end fw-semibold"><asp:Literal ID="litDeliveryFee" runat="server"></asp:Literal></td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="text-end text-muted">GST (5%):</td>
                                    <td class="text-end fw-semibold">₹<asp:Literal ID="litTax" runat="server"></asp:Literal></td>
                                </tr>
                                <asp:Panel ID="pnlDiscountRow" runat="server" Visible="false">
                                    <tr>
                                        <td colspan="3" class="text-end text-success">Discount:</td>
                                        <td class="text-end text-success fw-bold">-₹<asp:Literal ID="litDiscount" runat="server"></asp:Literal></td>
                                    </tr>
                                </asp:Panel>
                                <tr class="table-warning">
                                    <td colspan="3" class="text-end fw-bold fs-5 text-dark">Grand Total:</td>
                                    <td class="text-end fw-bold fs-5 text-danger">₹<asp:Literal ID="litGrandTotal" runat="server"></asp:Literal></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex flex-wrap justify-content-center gap-3 pt-3">
                    <a href="Default.aspx" class="btn btn-primary px-4 py-2">
                        <i class="bi bi-house-door me-1"></i> Back to Home
                    </a>
                    <a href="Menu.aspx" class="btn btn-outline-primary-custom px-4 py-2">
                        <i class="bi bi-basket me-1"></i> Order More Food
                    </a>
                    <button type="button" onclick="window.print();" class="btn btn-outline-secondary px-4 py-2 rounded-pill">
                        <i class="bi bi-printer me-1"></i> Print Receipt
                    </button>
                    <a href='BillReport.aspx?orderId=<%= Request.QueryString["orderId"] %>' target="_blank" class="btn btn-danger px-4 py-2 rounded-pill shadow-sm">
                        <i class="bi bi-file-earmark-pdf me-1"></i> Download Bill (PDF)
                    </a>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
