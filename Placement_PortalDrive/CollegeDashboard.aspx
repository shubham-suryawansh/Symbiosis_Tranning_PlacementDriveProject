<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CollegeDashboard.aspx.cs" Inherits="Placement_PortalDrive.CollegeDashboard2" %>




<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>College Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Container for the Add Company Drive Details Section */


        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000; /* Ensure it stays above other content */
        }
        .navbar-brand img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
        }
        .nav-link {
            cursor: pointer;
        }
        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 10px 0;
            margin-top: auto;
        }
        .container {
            margin-top: 80px; /* Space for fixed header */
            flex: 1;
        }
        .dashboard-title {
            background-color: #007bff;
            color: #fff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .dashboard-section {
            margin-bottom: 30px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            overflow: hidden;
        }
        .dashboard-section h4 {
            margin-bottom: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .table thead th {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .table tbody tr:last-child td:first-child {
            border-bottom-left-radius: 10px;
        }
        .table tbody tr:last-child td:last-child {
            border-bottom-right-radius: 10px;
        }
        .btn-edit, .btn-delete {
            margin-right: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            font-size: 0.9em;
            cursor: pointer;
        }
        .btn-edit {
            background-color: #ffc107;
            color: #fff;
        }
        .btn-edit:hover {
            background-color: #e0a800;
        }
        .btn-delete {
            background-color: #dc3545;
            color: #fff;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .btn-group {
            display: flex;
            justify-content: flex-end;
        }
        .total-students {
            font-size: 1.2em;
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
 
    <!-- Header and Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">
            <img src="images/Logo.jpg" alt="Placement Drive Logo" />
            Placement_Drive
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.aspx">Back Home</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <form id="form1" runat="server">
        <div class="container">
            <div class="dashboard-title">
                <h2>College Dashboard</h2>
            </div>

            <!-- Student Registration Details Section -->
            <div class="dashboard-section">
                <h4>Student Registration Details</h4>
                <asp:GridView ID="StudentsGridView" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                    OnRowEditing="StudentsGridView_RowEditing"
                    OnRowDeleting="StudentsGridView_RowDeleting"
                    OnRowUpdating="StudentsGridView_RowUpdating"
                    OnRowCancelingEdit="StudentsGridView_RowCancelingEdit"
                    DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                         <asp:BoundField DataField="GR" HeaderText="GR Number" />
                        <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                        <asp:BoundField DataField="EmailID" HeaderText="Email" />
                        <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
                       
                        <asp:BoundField DataField="Gender" HeaderText="Gender" />
                        <asp:BoundField DataField="Branch" HeaderText="Course" />
                        <asp:BoundField DataField="CurrentYear" HeaderText="Year" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="btn-group">
                                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" CssClass="btn btn-edit" Text="Edit" />
                                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" CssClass="btn btn-delete" Text="Delete" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Companies and Placement Status Section -->
            <div class="dashboard-section">
                <h4>Companies and Placement Status</h4>
               <h2>Job Listings</h2>
        <asp:GridView ID="gvJobs" runat="server" CssClass="table table-striped" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Title" HeaderText="Job Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:BoundField DataField="Salary" HeaderText="Salary" DataFormatString="{0:C}" />
                <asp:BoundField DataField="DriveDate" HeaderText="Drive Date" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>
            </div>

            <!-- Student Applications and Status Section -->
            <div class="dashboard-section">
                <h4>Student Applications and Status</h4>
                <div class="container mt-5">
           <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="ContactNo" HeaderText="Contact No" />
                    <asp:BoundField DataField="Branch" HeaderText="Branch" />
                    <asp:BoundField DataField="Marks10th" HeaderText="10th Marks" />
                    <asp:BoundField DataField="Marks12th" HeaderText="12th Marks" />
                    <asp:BoundField DataField="GraduateMarks" HeaderText="Graduate Marks" />
                    <asp:BoundField DataField="MCAMarks" HeaderText="MCA Marks" />
                </Columns>
            </asp:GridView>
        </div>
            </div>

            <!-- Total Number of Students Section -->
            <div class="row">
                <div class="col-md-12 total-students">
                    <h4>Total Number of Students</h4>
                    <asp:Label ID="TotalStudentsLabel" runat="server" CssClass="form-control"></asp:Label>
                </div>
            </div>
        </div>
                   <!-- Add Company Drive Details Section -->
        <div class="dashboard-section">
              <div class="container mt-4">
        <div class="card-header">
            <h4 class="mb-0">Add Company Drive Details</h4>
        </div>
        <div class="card-body">
            <div class="form-group">
                <label for="CompanyName">Company Name</label>
                <asp:TextBox ID="CompanyName" runat="server" CssClass="form-control" placeholder="Enter company name"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="DriveDate">Drive Date</label>
                <asp:TextBox ID="DriveDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Select drive date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="Location">Location</label>
                <asp:TextBox ID="Location" runat="server" CssClass="form-control" placeholder="Enter location"></asp:TextBox>
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


          <!--create form for Student Admission-->

          <div class="container mt-4">
            <h2>Collage Dashboard - Student Details</h2>
            <asp:GridView ID="GridViewStudents" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
                    <asp:BoundField DataField="StudentName" HeaderText="StudentName" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="GR" HeaderText="GR Number" />
                    <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
                    <asp:BoundField DataField="Address" HeaderText="Address " />
                    <asp:BoundField DataField="Gender" HeaderText="Gender " />
                    <asp:BoundField DataField="Branch" HeaderText="Branch " />

                </Columns>
            </asp:GridView>

            <div class="form-group mt-3">
                <label for="txtEmail">Enter Email to Generate GR Number:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter Email"></asp:TextBox>
            </div>

            <asp:Button ID="btnGenerateGR" runat="server" Text="Generate GR Number" CssClass="btn btn-primary mt-3" OnClick="btnGenerateGR_Click" />
        </div>


    </form>
  
    
    
    <footer>
        <p>© 2024 Placement Drive | All rights reserved</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
``
