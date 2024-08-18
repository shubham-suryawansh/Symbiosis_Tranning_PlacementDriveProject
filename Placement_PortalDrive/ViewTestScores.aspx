<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewTestScores.aspx.cs" Inherits="HR_Module.ViewTestScores" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>View Test Scores</title>
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
        <h2>Test Scores</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Score</th>
                </tr>
            </thead>
            <tbody id="scoresTable" runat="server"></tbody>
        </table>
        <div id="alertPlaceholder"></div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="scripts/viewtestscores.js"></script>
</body>
</html>
