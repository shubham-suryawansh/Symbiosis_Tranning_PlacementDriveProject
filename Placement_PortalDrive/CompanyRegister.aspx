<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyRegister.aspx.cs" Inherits="Placement_PortalDrive.CompanyRegister" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Company Registration</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .container {
            margin-top: 50px;
        }
        .form-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center">Company Registration</h2>
            <div class="form-group">
                <label for="txtCompanyName">Company Name</label>
                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="Enter Company Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName"
                    ErrorMessage="Company Name is required" CssClass="text-danger" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label for="txtHRName">HR Name</label>
                <asp:TextBox ID="txtHRName" runat="server" CssClass="form-control" placeholder="Enter HR Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvHRName" runat="server" ControlToValidate="txtHRName"
                    ErrorMessage="HR Name is required" CssClass="text-danger" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label for="txtCompanyAddress">Company Address</label>
                <asp:TextBox ID="txtCompanyAddress" runat="server" CssClass="form-control" placeholder="Enter Company Address"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCompanyAddress" runat="server" ControlToValidate="txtCompanyAddress"
                    ErrorMessage="Company Address is required" CssClass="text-danger" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label for="txtEmailID">Email ID</label>
                <asp:TextBox ID="txtEmailID" runat="server" CssClass="form-control" placeholder="Enter Email ID"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmailID" runat="server" ControlToValidate="txtEmailID"
                    ErrorMessage="Email ID is required" CssClass="text-danger" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmailID" runat="server" ControlToValidate="txtEmailID"
                    ErrorMessage="Invalid Email Format" CssClass="text-danger" Display="Dynamic"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$" />
            </div>
            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required" CssClass="text-danger" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary btn-block" OnClick="btnRegister_Click" />
            </div>
            <div class="form-group text-center">
                <a href="ForgotPassword.aspx" class="text-primary">Forgot Password?</a>
            </div>
            <div class="form-group text-center">
                <p>You Already Register? <a href="CompanyLogin.aspx" class="text-primary">Login Here</a></p>
            </div>
        </div>
    </form>
</body>
</html>
