<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreatedJob.aspx.cs" Inherits="Placement_PortalDrive.CreatedJob" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Collage Dashboard</title>
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
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .card-header {
            background-color: #007bff;
            color: white;
        }
        .btn-primary {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-primary:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .table th {
            background-color: #343a40;
            color: white;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        .form-control {
            border-radius: 0.25rem;
        }
        .card {
            border-radius: 0.5rem;
        }
        .table-responsive {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
    <h3>Placement Drive </h3>
</div>
    <form id="form1" runat="server">
        <div class="container mt-5">
           <!-- Add Company Drive Details Section -->
<div class="col-md-12">
    <div class="card mb-4">
        <div class="card-header">
            <h4 class="mb-0">Add Company Drive Details</h4>
        </div>
        <div class="card-body">
            <div class="form-group">
                <label for="CompanyName">Company Name</label>
                <asp:TextBox ID="CompanyName" runat="server" CssClass="form-control" placeholder="Enter company name"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="Position">Position</label>
                <asp:TextBox ID="Position" runat="server" CssClass="form-control" placeholder="Enter position"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="Vacancy">Vacancy</label>
                <asp:TextBox ID="Vacancy" runat="server" CssClass="form-control" placeholder="Enter number of vacancies"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="Branch">Branch</label>
                <asp:TextBox ID="Branch" runat="server" CssClass="form-control" placeholder="Enter branch"></asp:TextBox>
            </div>
            <asp:Button ID="SaveDetails" runat="server" Text="Save Details" CssClass="btn btn-primary" OnClick="SaveDetails_Click" />
        </div>
    </div> 
</div>
</form>
</body>
</html>
