<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardStudent.aspx.cs" Inherits="Placement_Drive.DashboardStudent" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile and Upcoming Drives</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

 <style>
     .header, .footer {
         background-color: olive;
         color: white;
         padding: 10px 0;
         text-align: center;
         margin-bottom: auto;
     }
   
        body {
            background-color: #f0f2f5;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 20px;
        }
        .profile-card, .card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .profile-card h2, .card-header h4 { 
            color: #333;
        }
        .form-control-plaintext {
            font-weight: bold;
            color: #555;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .btn-apply-green {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
        }
        .btn-apply-green:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .table {
            margin-top: 20px;
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
        .btn-logout {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <div class="header">
    <h3>Placement Drive Student DashBoard</h3>
</div>
    <form id="form2" runat="server">
        <div class="container">
            <!-- LogOut Button -->
            <a href="indexx.aspx" class="btn btn-danger btn-logout">LogOut</a>

            <div class="row">
                <div class="col-md-12">
                    <!-- Email Input and Check Button -->
                    <div class="profile-card mt-4">
                        <h2>Student Profile</h2>
                        <div class="form-group">
                            <label for="EmailInput">Enter Your Email</label>
                            <asp:TextBox ID="EmailInput" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox><br />
                            <asp:Button ID="CheckEmailButton" runat="server" CssClass="btn btn-primary mt-2" Text="Veiw Profile" OnClick="CheckEmailButton_Click" />
                            <asp:Label ID="MessageLabel" runat="server" CssClass="text-danger mt-2"></asp:Label>
                        </div>

                        <!-- Profile Details -->
                        <div class="profile-card mt-4" runat="server" ID="ProfileCard" Visible="false">
                            <div class="form-group">
                                <label for="FirstName">GR NO :</label>
                                <asp:Label ID="lblGRNO" runat="server" CssClass="form-control-plaintext"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="LastName">Full Name :</label>
                                <asp:Label ID="lblFullName" runat="server" CssClass="form-control-plaintext"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="Email">Email</label>
                                <asp:Label ID="lblEmail" runat="server" CssClass="form-control-plaintext"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="MobileNo">Mobile No</label>
                                <asp:Label ID="lblMobileNo" runat="server" CssClass="form-control-plaintext"></asp:Label>
                            </div>
 
                            <div class="form-group">
                                <label for="CourseName">Branch</label>
                                <asp:Label ID="lblBranch" runat="server" CssClass="form-control-plaintext"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Upcoming Drives Section -->
                    <div class="card mt-4">
                        <div class="card-header">
                            <h4 class="mb-0">Upcoming Drives</h4>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridViewUpcomingDrives" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-striped" OnRowCommand="GridViewUpcomingDrives_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                                    <asp:BoundField DataField="DriveDate" HeaderText="Drive Date" DataFormatString="{0:yyyy-MM-dd}" />
                                    <asp:BoundField DataField="Location" HeaderText="Location" />
                                    <asp:BoundField DataField="Position" HeaderText="Position" />
                                     <asp:BoundField DataField="Vacancy" HeaderText="Vacancy" />
                                     <asp:BoundField DataField="Branch" HeaderText="Branch" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:Button ID="btnApply" runat="server" CommandName="Apply" CommandArgument='<%# Eval("CompanyId") %>' Text="Apply" CssClass="btn btn-apply-green" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="footer">
    <p>&copy; 2024 Placement Drive. All rights reserved.</p>
</div>
</body>
</html>