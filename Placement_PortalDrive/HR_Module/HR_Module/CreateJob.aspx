<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateJob.aspx.cs" Inherits="HR_Module.CreateJob" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Create Job</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
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
        <form id="createJobForm" runat="server">
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
        </form>
        <div id="alertPlaceholder"></div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="scripts/createjob.js"></script>
</body>
</html>
