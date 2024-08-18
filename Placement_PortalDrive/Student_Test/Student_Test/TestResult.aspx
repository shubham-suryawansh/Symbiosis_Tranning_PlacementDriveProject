<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestResult.aspx.cs" Inherits="Student_Test.TestResult" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card">
                <div class="card-header">
                    <h3>Test Result</h3>
                </div>
                <div class="card-body">
                    <h4>Your Score: <asp:Label ID="lblScore" runat="server"></asp:Label></h4>
                    <asp:Button ID="btnBack" runat="server" CssClass="btn btn-primary mt-3" Text="Back to Home" OnClick="btnBack_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
