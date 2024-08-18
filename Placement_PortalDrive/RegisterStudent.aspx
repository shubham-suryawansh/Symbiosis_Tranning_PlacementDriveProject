<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterStudent.aspx.cs" Inherits="Placement_PortalDrive.RegisterStudent" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Registration</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Page Background */
        body {
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            font-family: Arial, sans-serif;
            color: #333;
        }
        /* Form Container */
        .form-container {
            max-width: 550px;
            padding: 15px; /* Reduced padding */
            margin: 50px auto;
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .form-group {
            margin-bottom: 5px; /* Reduced margin between fields */
        }
        .form-control, .form-control:focus {
            border-radius: 0.25rem;
            box-shadow: none;
        }
        .form-group label {
            font-weight: bold;
            margin-bottom: 5px; /* Reduced margin below labels */
        }
        .btn-custom {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 0.25rem;
            padding: 10px 20px;
            font-size: 1rem;
            margin-top: 10px; /* Added margin for button spacing */
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .text-danger {
            font-size: 0.875em;
            margin-top: 5px; /* Adjust margin for error messages */
        }
        .text-success {
            color: #28a745;
        }
        .form-container h2 {
            color: #007bff;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-container">
                <h2 class="text-center">Student Registration Form</h2>

                <div class="form-group">
                    <label for="txtGR">GR Number</label>
                    <asp:TextBox ID="txtGR" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="txtGR_TextChanged" Placeholder="Enter GR Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvGR" runat="server" ControlToValidate="txtGR" ErrorMessage="GR Number is required" CssClass="text-danger" />
                    <asp:Label ID="lblGRNotFound" runat="server" CssClass="text-danger" Visible="False" Text="GR Number not found"></asp:Label>
                    <asp:Label ID="Label1" runat="server" CssClass="text-danger" Visible="False" Text="This GR number is already registered."></asp:Label>
                </div>

                <div class="form-group">
                    <label for="lblName">Name</label>
                    <asp:Label ID="lblName" runat="server" CssClass="form-control" Text=""></asp:Label>
                </div>

                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="text-danger" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email format" CssClass="text-danger" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
                </div>

                <div class="form-group">
                    <label for="txtMobile">Mobile Number</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" Placeholder="Enter your mobile number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="Mobile Number is required" CssClass="text-danger" />
                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="Invalid Mobile Number format" CssClass="text-danger" ValidationExpression="^\d{10}$" />
                </div>

                <div class="form-group">
                    <label for="ddlGender">Gender</label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Gender" Value="">Select Gender</asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male">Male</asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female">Female</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="ddlGender" InitialValue="" ErrorMessage="Please select a Gender" CssClass="text-danger" />
                </div>

                <div class="form-group">
                    <label for="ddlBranch">Select Branch</label>
                    <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Branch" Value="">Select Branch</asp:ListItem>
                        <asp:ListItem Text="Computer Science" Value="Computer Science">Computer Science</asp:ListItem>
                        <asp:ListItem Text="Mechanical" Value="Mechanical">Mechanical</asp:ListItem>
                        <asp:ListItem Text="Civil" Value="Civil">Civil</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvBranch" runat="server" ControlToValidate="ddlBranch" InitialValue="" ErrorMessage="Please select a Branch" CssClass="text-danger" />
                </div>

                <div class="form-group">
                    <label for="ddlYear">Select Passing Year</label>
                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Year" Value="">Select Year</asp:ListItem>
                        <asp:ListItem Text="First Year" Value="First Year">First Year</asp:ListItem>
                        <asp:ListItem Text="Second Year" Value="Second Year">Second Year</asp:ListItem>
                        <asp:ListItem Text="Third Year" Value="Third Year">Third Year</asp:ListItem>
                        <asp:ListItem Text="Final Year" Value="Final Year">Final Year</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="ddlYear" InitialValue="" ErrorMessage="Please select a Year" CssClass="text-danger" />
                </div>

                <div class="form-group">
                    <label for="txtPassword">Password</label>
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter your password"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" CssClass="text-danger" />

    <asp:RegularExpressionValidator ID="revPassword" runat="server" 
        ControlToValidate="txtPassword" 
        ErrorMessage="Password must be at least 8 characters long, with at least one uppercase letter, one lowercase letter, and one digit." 
        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
        CssClass="text-success" />
                </div>

                <div class="form-group text-center">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-custom" OnClick="btnRegister_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
