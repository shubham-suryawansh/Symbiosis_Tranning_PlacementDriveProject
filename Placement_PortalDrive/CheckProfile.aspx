<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckProfile.aspx.cs" Inherits="Placement_PortalDrive.CollegeDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .profile-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-12">
                    <!-- Email Input and Check Button -->
                    <div class="profile-card mt-4">
                        <h2>Student Profile</h2>
                        <div class="form-group">
                            <label for="EmailInput">Enter Your Email</label>
                            <asp:TextBox ID="EmailInput" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:Button ID="CheckEmailButton" runat="server" CssClass="btn btn-primary mt-2" Text="Check Email" OnClick="CheckEmailButton_Click" />
                            <asp:Label ID="MessageLabel" runat="server" CssClass="mt-2"></asp:Label>
                        </div>

                        <!-- Profile Details -->
                        <div class="profile-card mt-4" runat="server" ID="ProfileCard" Visible="false">
                            <div class="form-group">
                                <label for="FirstName">First Name</label>
                                <asp:Label ID="lblFirstName" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="LastName">Last Name</label>
                                <asp:Label ID="lblLastName" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="Email">Email</label>
                                <asp:Label ID="lblEmail" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="MobileNo">Mobile No</label>
                                <asp:Label ID="lblMobileNo" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="Gender">Gender</label>
                                <asp:Label ID="lblGender" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="CourseName">Course Name</label>
                                <asp:Label ID="lblCourseName" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="Year">Year</label>
                                <asp:Label ID="lblYear" runat="server" CssClass="form-control"></asp:Label>
                            </div>
                            <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary" Text="Edit" OnClick="btnEdit_Click" Enabled="false" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>