<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TasteBiteRestaurant.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/register.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-5 bg-cream">
        <div class="container auth-container">
            <!-- Breadcrumb Navigation -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="Default.aspx"><i class="bi bi-house me-1"></i>Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Register</li>
                </ol>
            </nav>

            <div class="card auth-card border-0 p-4 p-md-5">
                <div class="mb-4 text-center">
                    <span class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill font-sans-bold mb-2">
                        <i class="bi bi-person-plus-fill me-1"></i> New Guest Sign Up
                    </span>
                    <h2 class="h3 fw-bold text-dark font-heading">Create Your Account</h2>
                    <p class="text-muted small">Fill in your details below to enjoy freshly handcrafted meals with exclusive rewards.</p>
                </div>

                        <!-- Success Alert Panel -->
                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show border-0 shadow-sm rounded-4 p-3 mb-4" role="alert">
                            <div class="d-flex align-items-center gap-3">
                                <div class="fs-2 text-success">
                                    <i class="bi bi-check-circle-fill"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="fw-bold mb-1">Registration Successful!</h6>
                                    <asp:Literal ID="litSuccessMessage" runat="server"></asp:Literal>
                                </div>
                            </div>
                            <div class="mt-3 text-end">
                                <a href="Login.aspx" class="btn btn-sm btn-success rounded-pill px-3">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Proceed to Login
                                </a>
                            </div>
                        </asp:Panel>

                        <!-- Error Alert Panel -->
                        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show border-0 shadow-sm rounded-4 p-3 mb-4" role="alert">
                            <div class="d-flex align-items-center gap-3">
                                <div class="fs-3 text-danger">
                                    <i class="bi bi-exclamation-triangle-fill"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-1">Registration Failed</h6>
                                    <asp:Literal ID="litErrorMessage" runat="server"></asp:Literal>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- Registration Form Controls -->
                        <div class="row g-3">
                            <!-- Full Name -->
                            <div class="col-12">
                                <label for="<%= txtFullName.ClientID %>" class="form-label fw-semibold small text-dark">
                                    Full Name <span class="text-danger">*</span>
                                </label>
                                <div class="input-group input-group-custom">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control form-control-custom" placeholder="Enter your name" MaxLength="80"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Email Address -->
                            <div class="col-md-6">
                                <label for="<%= txtEmail.ClientID %>" class="form-label fw-semibold small text-dark">
                                    Email Address <span class="text-danger">*</span>
                                </label>
                                <div class="input-group input-group-custom">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-custom" placeholder="Enter your mail id" TextMode="Email" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Phone Number -->
                            <div class="col-md-6">
                                <label for="<%= txtPhone.ClientID %>" class="form-label fw-semibold small text-dark">
                                    Phone Number <span class="text-danger">*</span>
                                </label>
                                <div class="input-group input-group-custom">
                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control form-control-custom" placeholder="Enter phone number" MaxLength="20"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Password -->
                            <div class="col-md-6">
                                <label for="<%= txtPassword.ClientID %>" class="form-label fw-semibold small text-dark">
                                    Password <span class="text-danger">*</span>
                                </label>
                                <div class="input-group input-group-custom">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="Minimum 6 characters"></asp:TextBox>
                                    <button class="btn btn-outline-secondary toggle-password-btn" type="button" onclick="togglePasswordVisibility('<%= txtPassword.ClientID %>', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Confirm Password -->
                            <div class="col-md-6">
                                <label for="<%= txtConfirmPassword.ClientID %>" class="form-label fw-semibold small text-dark">
                                    Confirm Password <span class="text-danger">*</span>
                                </label>
                                <div class="input-group input-group-custom">
                                    <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="Repeat your password"></asp:TextBox>
                                    <button class="btn btn-outline-secondary toggle-password-btn" type="button" onclick="togglePasswordVisibility('<%= txtConfirmPassword.ClientID %>', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Terms & Conditions -->
                            <div class="col-12 mt-2">
                                <div class="form-check">
                                    <asp:CheckBox ID="chkTerms" runat="server" CssClass="form-check-input" />
                                    <label class="form-check-label small text-muted" for="<%= chkTerms.ClientID %>">
                                        I agree to the <a href="About.aspx" class="text-primary text-decoration-underline" target="_blank">Terms of Service</a> and <a href="Contact.aspx" class="text-primary text-decoration-underline" target="_blank">Privacy Policy</a> of TasteBite Restaurant.
                                    </label>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="col-12 mt-4">
                                <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary w-100 py-3 font-sans-bold"
                                    OnClick="btnRegister_Click" />
                            </div>
                        </div>

                        <!-- Divider & Login Link -->
                        <div class="mt-4 pt-3 border-top text-center">
                            <p class="text-muted small mb-0">
                                Already have an account? 
                                <a href="Login.aspx" class="fw-bold text-danger text-decoration-none">
                                    Sign in here <i class="bi bi-arrow-right-short"></i>
                                </a>
                            </p>
                        </div>
            </div>
        </div>
    </div>

    <!-- Client-side script for password toggling -->
    <script type="text/javascript">
        function togglePasswordVisibility(fieldId, btnElement) {
            var field = document.getElementById(fieldId);
            if (!field) return;
            var icon = btnElement.querySelector('i');
            if (field.type === "password") {
                field.type = "text";
                if (icon) {
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                }
            } else {
                field.type = "password";
                if (icon) {
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }
        }
    </script>
</asp:Content>
