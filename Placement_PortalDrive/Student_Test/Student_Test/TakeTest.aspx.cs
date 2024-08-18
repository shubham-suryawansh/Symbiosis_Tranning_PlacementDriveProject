using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student_Test
{
    public partial class TakeTest : Page
    {
        public int ExamTimer { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQuestions();
            }
        }

        private void LoadQuestions()
        {
            int jobId = Convert.ToInt32(Session["JobId"]);
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT TOP (@RandomNo) * FROM Questions WHERE JobId = @JobId ORDER BY NEWID()", con);
                cmd.Parameters.AddWithValue("@JobId", jobId);
                cmd.Parameters.AddWithValue("@RandomNo", GetRandomNoForJob(jobId, con));
                rptQuestions.DataSource = cmd.ExecuteReader();
                rptQuestions.DataBind();

                // Get exam timer from the job
                ExamTimer = GetExamTimerForJob(jobId, con);
            }
        }

        private int GetRandomNoForJob(int jobId, SqlConnection con)
        {
            SqlCommand cmd = new SqlCommand("SELECT RandomNo FROM Jobs WHERE JobId = @JobId", con);
            cmd.Parameters.AddWithValue("@JobId", jobId);
            return (int)cmd.ExecuteScalar();
        }

        private int GetExamTimerForJob(int jobId, SqlConnection con)
        {
            SqlCommand cmd = new SqlCommand("SELECT ExamTimer FROM Jobs WHERE JobId = @JobId", con);
            cmd.Parameters.AddWithValue("@JobId", jobId);
            return (int)cmd.ExecuteScalar();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int jobId = Convert.ToInt32(Session["JobId"]);
            string studentName = Session["StudentName"].ToString();
            int testId = SaveTestAttempt(jobId, studentName);
            decimal score = CalculateScore(testId);
            SaveScore(testId, score);
            Response.Redirect("TestResult.aspx?TestId=" + testId);
        }

        private int SaveTestAttempt(int jobId, string studentName)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            int testId;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO StudentTests (StudentName, JobId) OUTPUT INSERTED.TestId VALUES (@StudentName, @JobId)", con);
                cmd.Parameters.AddWithValue("@StudentName", studentName);
                cmd.Parameters.AddWithValue("@JobId", jobId);
                testId = (int)cmd.ExecuteScalar();
            }

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                int questionId = Convert.ToInt32((item.FindControl("RadioOption1") as RadioButton).GroupName);
                string selectedOption = GetSelectedOption(item);
                SaveStudentAnswer(testId, questionId, selectedOption);
            }

            return testId;
        }

        private string GetSelectedOption(RepeaterItem item)
        {
            if ((item.FindControl("RadioOption1") as RadioButton).Checked)
                return "A";
            if ((item.FindControl("RadioOption2") as RadioButton).Checked)
                return "B";
            if ((item.FindControl("RadioOption3") as RadioButton).Checked)
                return "C";
            if ((item.FindControl("RadioOption4") as RadioButton).Checked)
                return "D";
            return null;
        }

        private void SaveStudentAnswer(int testId, int questionId, string selectedOption)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO StudentAnswers (TestId, QuestionId, SelectedOption) VALUES (@TestId, @QuestionId, @SelectedOption)", con);
                cmd.Parameters.AddWithValue("@TestId", testId);
                cmd.Parameters.AddWithValue("@QuestionId", questionId);
                cmd.Parameters.AddWithValue("@SelectedOption", selectedOption);
                cmd.ExecuteNonQuery();
            }
        }

        private decimal CalculateScore(int testId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            decimal score = 0;
            int totalQuestions = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM StudentAnswers SA " +
                    "JOIN Questions Q ON SA.QuestionId = Q.QuestionId " +
                    "WHERE SA.TestId = @TestId AND SA.SelectedOption = Q.CorrectOption", con);
                cmd.Parameters.AddWithValue("@TestId", testId);
                score = (int)cmd.ExecuteScalar();

                SqlCommand totalCmd = new SqlCommand("SELECT COUNT(*) FROM StudentAnswers WHERE TestId = @TestId", con);
                totalCmd.Parameters.AddWithValue("@TestId", testId);
                totalQuestions = (int)totalCmd.ExecuteScalar();
            }

            return (score / totalQuestions) * 100;
        }

        private void SaveScore(int testId, decimal score)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE StudentTests SET Score = @Score WHERE TestId = @TestId", con);
                cmd.Parameters.AddWithValue("@Score", score);
                cmd.Parameters.AddWithValue("@TestId", testId);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
