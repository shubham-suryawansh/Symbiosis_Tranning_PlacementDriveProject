<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="HR_Module.Home" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>HR Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="Home.aspx">HR Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link" href="Home.aspx">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="ViewJobs.aspx">Job Post</a></li>
                <li class="nav-item"><a class="nav-link" href="SetTest.aspx">Set Test</a></li>
                <li class="nav-item"><a class="nav-link" href="ViewTestScores.aspx">View Responses</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-header">Jobs Posted</div>
                    <div class="card-body">
                        <h5 class="card-title">
                            <asp:Label ID="jobCountLabel" runat="server" Text="0"></asp:Label>
                        </h5>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-header">Tests Created</div>
                    <div class="card-body">
                        <h5 class="card-title">
                            <asp:Label ID="testCountLabel" runat="server" Text="0"></asp:Label>
                        </h5>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-danger mb-3">
                    <div class="card-header">Recent Scores</div>
                    <div class="card-body">
                        <h5 class="card-title">
                            <asp:Label ID="recentScoresLabel" runat="server" Text="N/A"></asp:Label>
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="scripts/home.js"></script>
</body>
</html>
