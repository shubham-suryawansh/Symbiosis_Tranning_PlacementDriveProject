<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetTest.aspx.cs" Inherits="HR_Module.SetTest" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Set Test</title>
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
        <h2>Set Test</h2>

        <form id="setTestForm" runat="server">
            <div class="form-group">
                <label for="jobDropDown">Select Job</label>
                <asp:DropDownList ID="jobDropDown" runat="server" CssClass="form-control" 
                    OnSelectedIndexChanged="JobDropDown_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="examTimerTextBox">Exam Timer (Minutes)</label>
                <asp:TextBox ID="examTimerTextBox" runat="server" CssClass="form-control" />
            </div>

            <asp:Button ID="saveExamButton" runat="server" CssClass="btn btn-primary" Text="Save Exam Timer" OnClick="SaveExamTimer" />

            <h3 class="mt-4">Manage Questions</h3>

            <asp:GridView ID="GridViewQuestions" runat="server" AutoGenerateColumns="False" DataKeyNames="QuestionId"
                OnRowEditing="GridViewQuestions_RowEditing" OnRowUpdating="GridViewQuestions_RowUpdating"
                OnRowCancelingEdit="GridViewQuestions_RowCancelingEdit" OnRowDeleting="GridViewQuestions_RowDeleting"
                CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="QuestionId" HeaderText="ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Question Text">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtQuestionText" runat="server" CssClass="form-control" Text='<%# Bind("QuestionText") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("QuestionText") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Option 1">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOption1" runat="server" CssClass="form-control" Text='<%# Bind("Option1") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Option1") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Option 2">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOption2" runat="server" CssClass="form-control" Text='<%# Bind("Option2") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Option2") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Option 3">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOption3" runat="server" CssClass="form-control" Text='<%# Bind("Option3") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Option3") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Option 4">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOption4" runat="server" CssClass="form-control" Text='<%# Bind("Option4") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Option4") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Correct Option">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="form-control">
                                <asp:ListItem Text="A" Value="A" />
                                <asp:ListItem Text="B" Value="B" />
                                <asp:ListItem Text="C" Value="C" />
                                <asp:ListItem Text="D" Value="D" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("CorrectOption") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>

            <div class="mt-4">
                <h4>Add New Question</h4>
                <div class="form-group">
                    <label for="questionTextBox">Question</label>
                    <asp:TextBox ID="questionTextBox" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="option1TextBox">Option 1</label>
                    <asp:TextBox ID="option1TextBox" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="option2TextBox">Option 2</label>
                    <asp:TextBox ID="option2TextBox" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="option3TextBox">Option 3</label>
                    <asp:TextBox ID="option3TextBox" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="option4TextBox">Option 4</label>
                    <asp:TextBox ID="option4TextBox" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="correctOptionDropDown">Correct Option</label>
                    <asp:DropDownList ID="correctOptionDropDown" runat="server" CssClass="form-control">
                        <asp:ListItem Text="A" Value="A" />
                        <asp:ListItem Text="B" Value="B" />
                        <asp:ListItem Text="C" Value="C" />
                        <asp:ListItem Text="D" Value="D" />
                    </asp:DropDownList>
                </div>
                <asp:Button ID="addQuestionButton" runat="server" CssClass="btn btn-primary" Text="Add Question" OnClick="AddQuestion" />
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="scripts/settest.js"></script>
</body>
</html>
