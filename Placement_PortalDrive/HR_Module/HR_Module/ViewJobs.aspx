<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewJobs.aspx.cs" Inherits="HR_Module.ViewJobs" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>View Jobs</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <style>
        .datepicker {
            z-index: 1151 !important; /* Adjust z-index to prevent overlap issues */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">HR Dashboard</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item"><a class="nav-link" href="Home.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewJobs.aspx">Job Post</a></li>
                    <li class="nav-item"><a class="nav-link" href="SetTest.aspx">Set Test</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewTestScores.aspx">View Responses</a></li>
                </ul>
            </div>
        </nav>
        <div class="container mt-4">
            <h2>Create Job</h2>
            <div class="form-group">
                <label for="title">Title</label>
                <asp:TextBox ID="titleTextBox" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <asp:TextBox ID="descriptionTextArea" runat="server" TextMode="MultiLine" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="location">Location</label>
                <asp:TextBox ID="locationTextBox" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="salary">Salary</label>
                <asp:TextBox ID="salaryTextBox" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="saveButton" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="SaveJob" />

            <h2 class="mt-5">Posted Jobs</h2>
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            <asp:GridView ID="GridViewJobs" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                OnRowEditing="GridViewJobs_RowEditing" OnRowUpdating="GridViewJobs_RowUpdating"
                OnRowCancelingEdit="GridViewJobs_RowCancelingEdit" OnRowDeleting="GridViewJobs_RowDeleting"
                DataKeyNames="JobId">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Location" HeaderText="Location" />
                    <asp:BoundField DataField="Salary" HeaderText="Salary" DataFormatString="{0:C}" />
                    <asp:TemplateField HeaderText="Date of Drive">
                        <ItemTemplate>
                            <asp:TextBox ID="txtDateOfDrive" runat="server" Text='<%# Bind("DriveDate", "{0:yyyy-MM-dd}") %>' CssClass="form-control datepicker" Enabled="False" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDateOfDrive" runat="server" Text='<%# Bind("DriveDate", "{0:yyyy-MM-dd}") %>' CssClass="form-control datepicker" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $(".datepicker").datepicker({
                    dateFormat: 'yy-mm-dd',
                    autoclose: true
                });
            });
        </script>
    </form>
</body>
</html>
