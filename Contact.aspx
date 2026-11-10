<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TasteBiteRestaurant.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/contact.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- HEADER -->
    <section class="py-5 bg-white border-bottom border-cream">
        <div class="container text-center">
            <span class="text-danger fw-bold text-uppercase small">Get in Touch</span>
            <h1 class="display-5 fw-bold mt-1 mb-3">We’d Love to Hear From You</h1>
            <p class="text-muted mx-auto" style="max-width: 600px;">
                Have questions about dietary requirements, special event catering, or feedback on an order? Our guest care team is always here to assist.
            </p>
        </div>
    </section>

    <section class="py-5 bg-cream">
        <div class="container">
            <!-- CONTACT INFO CARDS -->
            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-4 border border-light-subtle shadow-sm h-100 text-center">
                        <div class="feature-icon-wrapper mx-auto">
                            <i class="bi bi-geo-alt"></i>
                        </div>
                        <h5 class="fw-bold">Our Location</h5>
                        <p class="text-muted small mb-0">
                            742 Gourmet Avenue, Downtown Bistro District<br />
                            Foodville, NY 10001
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-4 border border-light-subtle shadow-sm h-100 text-center">
                        <div class="feature-icon-wrapper mx-auto">
                            <i class="bi bi-telephone"></i>
                        </div>
                        <h5 class="fw-bold">Call Us Directly</h5>
                        <p class="text-muted small mb-0">
                            Orders: +1 (555) 234-FOOD (3663)<br />
                            Catering &amp; Events: +1 (555) 234-8899
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-4 border border-light-subtle shadow-sm h-100 text-center">
                        <div class="feature-icon-wrapper mx-auto">
                            <i class="bi bi-envelope"></i>
                        </div>
                        <h5 class="fw-bold">Email Inquiries</h5>
                        <p class="text-muted small mb-0">
                            Guest Care: support@tastebitedemo.com<br />
                            Kitchen: chef@tastebitedemo.com
                        </p>
                    </div>
                </div>
            </div>

            <!-- FORM AND LOCATION CARD -->
            <div class="row g-5">
                <!-- Contact Form -->
                <div class="col-lg-7">
                    <div class="bg-white p-4 p-md-5 rounded-4 border border-light-subtle shadow-sm">
                        <h3 class="fw-bold mb-2">Send Us a Message</h3>
                        <p class="text-muted small mb-4">Fill out the form below and we will respond within 24 hours.</p>

                        <asp:Panel ID="pnlSuccessMessage" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show rounded-3 p-3 mb-4" role="alert">
                            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                            <asp:Literal ID="litSuccessText" runat="server"></asp:Literal>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </asp:Panel>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Your Name *</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Full Name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Please enter your name." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Your Email *</label>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="name@example.com"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please enter your email." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Phone Number (Optional)</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+1 (555) 000-0000"></asp:TextBox>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Subject *</label>
                                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="" Text="-- Select Subject --"></asp:ListItem>
                                    <asp:ListItem Value="Food Quality / Feedback" Text="Food Quality / Feedback"></asp:ListItem>
                                    <asp:ListItem Value="Online Order Inquiry" Text="Online Order Inquiry"></asp:ListItem>
                                    <asp:ListItem Value="Catering & Bulk Booking" Text="Catering & Bulk Booking"></asp:ListItem>
                                    <asp:ListItem Value="Dietary & Allergen Questions" Text="Dietary & Allergen Questions"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="ddlSubject" InitialValue="" ErrorMessage="Please select a subject." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-12">
                                <label class="form-label small fw-bold text-muted">Your Message *</label>
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" placeholder="Write your comments or questions here..."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" ErrorMessage="Please write your message." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-12 pt-2">
                                <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary btn-lg w-100" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Operating Hours & Delivery Coverage Card -->
                <div class="col-lg-5">
                    <div class="bg-white p-4 p-md-5 rounded-4 border border-light-subtle shadow-sm h-100">
                        <h4 class="fw-bold mb-3">Kitchen Opening Hours</h4>
                        <ul class="list-unstyled mb-4">
                            <li class="d-flex justify-content-between py-2 border-bottom">
                                <span class="fw-semibold text-dark">Monday – Thursday</span>
                                <span class="text-muted">10:00 AM – 10:30 PM</span>
                            </li>
                            <li class="d-flex justify-content-between py-2 border-bottom">
                                <span class="fw-semibold text-dark">Friday – Saturday</span>
                                <span class="text-muted">10:00 AM – 11:30 PM</span>
                            </li>
                            <li class="d-flex justify-content-between py-2 border-bottom">
                                <span class="fw-semibold text-dark">Sunday</span>
                                <span class="text-muted">10:00 AM – 11:00 PM</span>
                            </li>
                        </ul>

                        <h5 class="fw-bold mb-2">Delivery Coverage</h5>
                        <p class="text-muted small mb-0">
                            We deliver to all residential and commercial addresses within a 15-mile radius. Average doorstep delivery time is 30-40 minutes.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
