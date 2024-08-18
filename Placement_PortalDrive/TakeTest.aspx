<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TakeTest.aspx.cs" Inherits="Student_Test.TakeTest" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Take Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript">
        var timer;
        function startTimer(duration, display) {
            var start = Date.now(),
                diff,
                minutes,
                seconds;
            function timer() {
                diff = duration - (((Date.now() - start) / 1000) | 0);

                minutes = (diff / 60) | 0;
                seconds = (diff % 60) | 0;

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                display.textContent = minutes + ":" + seconds;

                if (diff <= 0) {
                    clearInterval(timer);
                    document.getElementById("btnSubmit").click();
                }
            };
            timer();
            setInterval(timer, 1000);
        }

        window.onload = function () {
            var timerMinutes = parseInt('<%=ExamTimer %>', 10);
            var display = document.querySelector('#time');
            startTimer(timerMinutes * 60, display);
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card">
                <div class="card-header">
                    <h3>Take Test</h3>
                    <span id="time" class="badge bg-primary"></span>
                </div>
                <div class="card-body">
                    <asp:Repeater ID="rptQuestions" runat="server">
                        <ItemTemplate>
                            <div class="mb-4">
                                <h5><%# Eval("QuestionText") %></h5>
                                <div class="form-check">
                                    <asp:RadioButton ID="RadioOption1" GroupName='<%# Eval("QuestionId") %>' runat="server" Text='<%# Eval("Option1") %>' />
                                </div>
                                <div class="form-check">
                                    <asp:RadioButton ID="RadioOption2" GroupName='<%# Eval("QuestionId") %>' runat="server" Text='<%# Eval("Option2") %>' />
                                </div>
                                <div class="form-check">
                                    <asp:RadioButton ID="RadioOption3" GroupName='<%# Eval("QuestionId") %>' runat="server" Text='<%# Eval("Option3") %>' />
                                </div>
                                <div class="form-check">
                                    <asp:RadioButton ID="RadioOption4" GroupName='<%# Eval("QuestionId") %>' runat="server" Text='<%# Eval("Option4") %>' />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary mt-3" Text="Submit Test" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
