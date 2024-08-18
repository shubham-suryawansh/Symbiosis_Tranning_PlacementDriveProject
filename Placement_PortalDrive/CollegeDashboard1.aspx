<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CollegeDashboard1.aspx.cs" Inherits="Placement_PortalDrive.CollegeDashboard1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Collage Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .btn-danger {
            background-color: red !important;
            border-color: red !important;
        }
        .table thead th {
            background-color: #007bff; /* Primary blue background for headers */
            color: white; /* White text for headers */
            border-top: 0; /* Remove the top border */
        }
        .table tbody tr {
            transition: background-color 0.3s ease-in-out; /* Smooth transition on hover */
        }
        .table tbody tr:hover {
            background-color: #e2e6ea; /* Light gray background on hover */
        }
        .card-header {
            background-color: #007bff;
            color: white;
        }
        .card-body {
            padding: 20px;
        }
        .logout-button {
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1000; /* Ensure it stays above other content */
        }
        .table thead th {
            background-color: #343a40; /* Dark gray */
            color: white;
            text-align: center;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1; /* Light gray */
        }
        .table td, .table th {
            vertical-align: middle; /* Center-align content vertically */
        }
        .table td {
            text-align: center; /* Center-align content horizontally */
        }
        .table th {
            font-weight: bold; /* Make header text bold */
        }

        /* Circle status indicators */
        .status-circle {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: inline-block;
            vertical-align: middle;
            margin-right: 8px;
        }
        .status-selected {
            background-color: green; /* Green for selected */
        }
        .status-rejected {
            background-color: red; /* Red for rejected */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Log Out Button -->
        <asp:Button ID="LogoutButton" runat="server" Text="Back" CssClass="btn btn-danger logout-button" OnClick="LogoutButton_Click" />

        <div class="container mt-5">
            <div class="row">
                <!-- Student List Section -->
                <div class="col-md-12">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4 class="mb-0">Student List</h4>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" DataKeyNames="Id" OnRowDeleting="GridView1_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="FName" HeaderText="First Name" />
                                    <asp:BoundField DataField="LName" HeaderText="Last Name" />
                                    <asp:BoundField DataField="Email" HeaderText="Email" />
                                    <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
                                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                                    <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                                    <asp:BoundField DataField="Year" HeaderText="Year" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' Text="Delete" CssClass="btn btn-danger" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <!-- Total Students Section -->
                <div class="col-md-12">
                    <div class="card mb-4">
                        <div class="card-header bg-success text-white">
                            <h4 class="mb-0">Total Students</h4>
                        </div>
                        <div class="card-body">
                            <asp:Label ID="lblTotalStudents" runat="server" CssClass="h4"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Student Selection Status Section -->
                <div class="col-md-12">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">Student Selection Status</h4>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridViewStudentStatus" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped table-hover rounded shadow">
                                <Columns>
                                    <asp:BoundField DataField="FName" HeaderText="First Name" />
                                    <asp:BoundField DataField="LName" HeaderText="Last Name" />
                                    <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                                    <asp:BoundField DataField="MarksPercentage" HeaderText="Marks (%)" />
                                    <asp:TemplateField HeaderText="Status (Selected/Rejected)">
                                        <ItemTemplate>
                                            <div class="status-circle <%# Eval("SelectionStatus") == "Selected" ? "status-selected" : "status-rejected" %>"></div>
                                            <%# Eval("SelectionStatus") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Bootstrap JavaScript and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </form>
</body>
</html>
