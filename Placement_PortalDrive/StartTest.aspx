<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartTest.aspx.cs" Inherits="Student_Test.StartTest" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Start Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card">
                <div class="card-header">
                    <h3>Select Job</h3>
                </div>
                <div class="card-body">
                    <asp:DropDownList ID="ddlJobs" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:TextBox ID="txtStudentName" runat="server" CssClass="form-control mt-3" placeholder="Enter your name"></asp:TextBox>
                    <asp:Button ID="btnStartTest" runat="server" CssClass="btn btn-primary mt-3" Text="Start Test" OnClick="btnStartTest_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
