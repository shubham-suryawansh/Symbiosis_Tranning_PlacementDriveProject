<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyLogin.aspx.cs" Inherits="Placement_PortalDrive.CompanyLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

    <style>
        .header, .footer {
            background-color: olive;
            color: white;
            padding: 10px 0;
            text-align: center;
            margin-bottom: auto;
        }
        .form-container {
            max-width: 400px;
            margin: 10px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            background-color: #fff;
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        .form-group .error {
            color: red;
        }
        .form-group .success {
            color: green;
        }
    </style>
</head>
<body>
    <div class="header">
        <h3>Placement Drive Company Login</h3>
    </div>
    <br />
    <form id="form1" runat="server" class="form-container">
        <h2 class="text-center">Login</h2>
        <asp:Label ID="lblMessage" runat="server" CssClass="error d-block mb-3"></asp:Label>

        <div class="form-group">
            <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required"
                CssClass="error d-block mt-1"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Invalid email format"
                CssClass="error d-block mt-1"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password is required"
                CssClass="error d-block mt-1"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group text-center">
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
        </div>

        <div class="form-group text-center">
            <a href="ForgotPassword.aspx">Forgot Password?</a>
        </div>

        <div class="text-center">
            <a href="CompanyRegister.aspx">Don't Have an Account? Register</a>
        </div>
    </form>
    <br />

    <div class="footer">
        <p>&copy; 2024 Placement Drive. All rights reserved.</p>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
