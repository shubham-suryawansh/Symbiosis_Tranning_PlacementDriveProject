<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Apply.aspx.cs" Inherits="Placement_PortalDrive.Apply" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Information Form</title>
    <!-- Bootstrap CSS -->
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
 </style>
</head>
<body>
    <div class="header">
    <h3>Placement Drive Student Application Form</h3>
</div>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header">
                            <h2 class="text-center">Student Application Form</h2>
                        </div>
                        <div class="card-body">

                            <!-- Company Name Display -->
                            <div class="form-group">
                                <label>Company Name:</label>
                                <asp:Label ID="lblCompanyName" runat="server" CssClass="form-control"></asp:Label>
                            </div>

                            <!-- Name Field -->
                            <div class="form-group">
                                <label for="txtName">Name:</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                    ErrorMessage="Name is required" CssClass="text-danger" Display="Dynamic" />
                            </div>

                            <!-- Contact Number Field -->
                            <div class="form-group">
                                <label for="txtContact">Contact No:</label>
                                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" placeholder="Enter 10 Digit No"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact"
                                    ErrorMessage="Contact No is required" CssClass="text-danger" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revContact" runat="server" ControlToValidate="txtContact"
                                    ErrorMessage="Invalid contact number format" CssClass="text-danger" Display="Dynamic"
                                    ValidationExpression="^\d{10}$" />
                            </div>

                            <!-- Branch Radio Button List -->
                            <div class="form-group">
                                <label>Branch:</label><br />
                                <asp:RadioButtonList ID="rblBranch" runat="server" CssClass="form-check form-check-inline">
                                    <asp:ListItem Value="CSE" CssClass="form-check-input">MCA</asp:ListItem>
                                    <asp:ListItem Value="ECE" CssClass="form-check-input">Computer</asp:ListItem>
                                    <asp:ListItem Value="ME" CssClass="form-check-input">AIDS</asp:ListItem>
                                    <asp:ListItem Value="CE" CssClass="form-check-input">IT</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="rfvBranch" runat="server" ControlToValidate="rblBranch"
                                    InitialValue="" ErrorMessage="Branch is required" CssClass="text-danger" Display="Dynamic" />
                            </div>

                            <!-- Marks TextBoxes -->
                            <div class="form-group">
                                <label for="txt10thMarks">10th %:</label>
                                <asp:TextBox ID="txt10thMarks" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv10thMarks" runat="server" ControlToValidate="txt10thMarks"
                                    ErrorMessage="10th Marks are required" CssClass="text-danger" Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="txt12thMarks">12th %:</label>
                                <asp:TextBox ID="txt12thMarks" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv12thMarks" runat="server" ControlToValidate="txt12thMarks"
                                    ErrorMessage="12th Marks are required" CssClass="text-danger" Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="txtGraduateMarks">Graduate %:</label>
                                <asp:TextBox ID="txtGraduateMarks" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvGraduateMarks" runat="server" ControlToValidate="txtGraduateMarks"
                                    ErrorMessage="Graduate Marks are required" CssClass="text-danger" Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="txtMCAMarks">Last Semester Marks:</label>
                                <asp:TextBox ID="txtMCAMarks" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMCAMarks" runat="server" ControlToValidate="txtMCAMarks"
                                    ErrorMessage="MCA Marks are required" CssClass="text-danger" Display="Dynamic" />
                            </div>

                            <!-- Submit Button -->
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     <div class="footer">
     <p>&copy; 2024 Placement Drive. All rights reserved.</p>
 </div>
</body>
</html>
