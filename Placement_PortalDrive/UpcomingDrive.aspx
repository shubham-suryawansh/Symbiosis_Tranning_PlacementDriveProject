<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpcomingDrive.aspx.cs" Inherits="Placement_PortalDrive.UpcomingDrive" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upcoming Drives</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 20px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table-custom {
            margin-top: 20px;
            width: 100%;
        }
        .form-control {
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-custom {
            background-color: #007bff;
            color: #ffffff;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
        }
        .table-custom th, .table-custom td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h3>Upcoming Drives</h3>
            </div>

            <asp:GridView ID="gvUpcomingDrives" runat="server" CssClass="table table-striped table-bordered table-custom" AllowPaging="True" PageSize="10">
                <Columns>
                    <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                    <asp:BoundField DataField="DriveDate" HeaderText="Drive Date" DataFormatString="{0:dd-MM-yyyy}" />
                    <asp:BoundField DataField="Location" HeaderText="Job Location" />
                    <asp:BoundField DataField="Position" HeaderText="Job Position" />
                    <asp:BoundField DataField="Vacancy" HeaderText="Vacancy" />
                    <asp:BoundField DataField="Branch" HeaderText="Branch" />
                </Columns>
            </asp:GridView>

            <!-- Form to add a new drive -->
            <div class="form-container">
                <h3>Add New Drive</h3>
                <div class="form-group">
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" Placeholder="Company Name" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtJobLocation" runat="server" CssClass="form-control" Placeholder="Job Location" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtJobPosition" runat="server" CssClass="form-control" Placeholder="Job Position" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtVacancy" runat="server" CssClass="form-control" Placeholder="Vacancy" />
                </div>
                <div class="form-group">
                    <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select" Value="" />
                        <asp:ListItem Value="MCA">MCA</asp:ListItem>
                        <asp:ListItem Value="COMPUTER">COMPUTER</asp:ListItem>
                        <asp:ListItem Value="IT">IT</asp:ListItem>
                        <asp:ListItem Value="MBA">MBA</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtDriveDate" runat="server" CssClass="form-control" Placeholder="Drive Date (DD-MM-YYYY)" />
                    <span id="dateError" style="color: red; display: none;">Please enter a valid date in DD-MM-YYYY format.</span>
                </div>
                <asp:Button ID="btnAddDrive" runat="server" Text="Add Drive" CssClass="btn btn-custom" OnClick="btnAddDrive_Click" />
            </div>

            <!-- Form to apply to a company -->
            <div class="form-container">
                <h3>Apply to a Company</h3>
                <div class="form-group">
                    <asp:DropDownList ID="ddlStudents" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control">
                       
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtStudentMarks" runat="server" CssClass="form-control" Placeholder="Student Marks" />
                </div>
                <div class="form-group">
                    <asp:DropDownList ID="ddlStudentStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Status" Value="" />
                        <asp:ListItem Value="Applied">Applied</asp:ListItem>
                        <asp:ListItem Value="Accepted">Accepted</asp:ListItem>
                        <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:Button ID="btnApply" runat="server" Text="Apply" CssClass="btn btn-custom" OnClick="btnApply_Click" />
            </div>
        </div>
    </form>

    <script>
        document.getElementById('<%= txtDriveDate.ClientID %>').addEventListener('input', function () {
            var dateInput = this.value;
            var pattern = /^(\d{2})-(\d{2})-(\d{4})$/;
            var errorElement = document.getElementById('dateError');

            if (!pattern.test(dateInput)) {
                errorElement.style.display = 'block';
            } else {
                errorElement.style.display = 'none';
            }
        });
    </script>
</body>
</html>
