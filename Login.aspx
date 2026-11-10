<%@ Page Title="Sign In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TasteBiteRestaurant.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="wwwroot/css/login.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-5 bg-cream">
        <div class="container auth-container">
            <!-- Breadcrumbs -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="Default.aspx"><i class="bi bi-house me-1"></i>Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Sign In</li>
                </ol>
            </nav>

            <div class="card auth-card border-0 p-4 p-md-5">
                <div class="mb-4 text-center">
                    <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill font-sans-bold mb-2">
                        <i class="bi bi-shield-lock-fill me-1"></i> Welcome Back
                    </span>
                    <h2 class="h3 fw-bold text-dark font-heading">Sign In to TasteBite</h2>
                    <p class="text-muted small">Enter your credentials below to manage your orders, favorites, and rewards.</p>
                </div>

                <!-- Success / Notice Alerts -->
                <asp:Panel ID="pnlNotice" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show border-0 shadow-sm rounded-4 p-3 mb-4" role="alert">
                    <div class="d-flex align-items-center gap-3">
                        <div class="fs-3 text-info">
                            <i class="bi bi-info-circle-fill"></i>
                        </div>
                        <div>
                            <asp:Literal ID="litNoticeMessage" runat="server"></asp:Literal>
                        </div>
                    </div>
                </asp:Panel>

                <!-- Error Alert Panel -->
                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show border-0 shadow-sm rounded-4 p-3 mb-4" role="alert">
                    <div class="d-flex align-items-center gap-3">
                        <div class="fs-3 text-danger">
                            <i class="bi bi-exclamation-octagon-fill"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1">Authentication Error</h6>
                            <asp:Literal ID="litErrorMessage" runat="server"></asp:Literal>
                        </div>
                    </div>
                </asp:Panel>

                <!-- Form Controls -->
                <div class="row g-3">
                    <!-- Email -->
                    <div class="col-12">
                        <label for="<%= txtEmail.ClientID %>" class="form-label fw-semibold small text-dark">
                            Email Address <span class="text-danger">*</span>
                        </label>
                        <div class="input-group input-group-custom">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-custom" placeholder="name@example.com" TextMode="Email"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center">
                            <label for="<%= txtPassword.ClientID %>" class="form-label fw-semibold small text-dark mb-0">
                                Password <span class="text-danger">*</span>
                            </label>
                            <a href="javascript:void(0)" class="small text-primary text-decoration-none" onclick="showForgotPasswordModal()">
                                Forgot Password?
                            </a>
                        </div>
                        <div class="input-group input-group-custom mt-1">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                            <button class="btn btn-outline-secondary toggle-password-btn" type="button" onclick="togglePasswordVisibility('<%= txtPassword.ClientID %>', this)">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Remember Me Checkbox -->
                    <div class="col-12">
                        <div class="form-check">
                            <asp:CheckBox ID="chkRememberMe" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label small text-muted" for="<%= chkRememberMe.ClientID %>">
                                Keep me signed in on this device
                            </label>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="col-12 mt-3">
                        <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-primary w-100 py-3 font-sans-bold"
                            OnClick="btnLogin_Click" />
                    </div>
                </div>

                <!-- Divider & Register Link -->
                <div class="mt-4 pt-3 border-top text-center">
                    <p class="text-muted small mb-0">
                        Don't have a TasteBite account yet? 
                        <a href="Register.aspx" class="fw-bold text-danger text-decoration-none">
                            Create an account <i class="bi bi-arrow-right-short"></i>
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Password toggle script -->
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

        function showForgotPasswordModal() {
            alert("Forgot password? Please contact the site administrator to reset your password, or register a new account.");
        }
    </script>
</asp:Content>
