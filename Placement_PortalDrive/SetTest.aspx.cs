using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_Module
{
    public partial class SetTest : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadJobs();
            }
        }

        private void LoadJobs()
        {
            string query = "SELECT JobId, Title FROM Jobs";
            DataTable dt = ExecuteQuery(query);
            jobDropDown.DataSource = dt;
            jobDropDown.DataTextField = "Title";
            jobDropDown.DataValueField = "JobId";
            jobDropDown.DataBind();
            jobDropDown.Items.Insert(0, new ListItem("Select a Job", ""));
        }

        private void LoadQuestions()
        {
            if (string.IsNullOrEmpty(jobDropDown.SelectedValue)) return;

            string query = "SELECT * FROM Questions WHERE JobId = @JobId";
            SqlParameter[] parameters = { new SqlParameter("@JobId", jobDropDown.SelectedValue) };
            DataTable dt = ExecuteQuery(query, parameters);
            GridViewQuestions.DataSource = dt;
            GridViewQuestions.DataBind();
        }

        private void LoadExamTimer()
        {
            if (string.IsNullOrEmpty(jobDropDown.SelectedValue)) return;

            string query = "SELECT ExamTimer FROM Jobs WHERE JobId = @JobId";
            SqlParameter[] parameters = { new SqlParameter("@JobId", jobDropDown.SelectedValue) };
            object result = ExecuteScalar(query, parameters);
            examTimerTextBox.Text = result?.ToString() ?? string.Empty;
        }

        protected void AddQuestion(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(jobDropDown.SelectedValue)) return;

            string query = "INSERT INTO Questions (JobId, QuestionText, Option1, Option2, Option3, Option4, CorrectOption) " +
                           "VALUES (@JobId, @QuestionText, @Option1, @Option2, @Option3, @Option4, @CorrectOption)";
            SqlParameter[] parameters =
            {
                new SqlParameter("@JobId", jobDropDown.SelectedValue),
                new SqlParameter("@QuestionText", questionTextBox.Text),
                new SqlParameter("@Option1", option1TextBox.Text),
                new SqlParameter("@Option2", option2TextBox.Text),
                new SqlParameter("@Option3", option3TextBox.Text),
                new SqlParameter("@Option4", option4TextBox.Text),
                new SqlParameter("@CorrectOption", correctOptionDropDown.SelectedValue)
            };
            ExecuteNonQuery(query, parameters);

            ClearQuestionInputs();
            LoadQuestions();
        }

        protected void SaveExamTimer(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(jobDropDown.SelectedValue) || string.IsNullOrEmpty(examTimerTextBox.Text)) return;

            string query = "UPDATE Jobs SET ExamTimer = @ExamTimer WHERE JobId = @JobId";
            SqlParameter[] parameters =
            {
                new SqlParameter("@ExamTimer", examTimerTextBox.Text),
                new SqlParameter("@JobId", jobDropDown.SelectedValue)
            };
            ExecuteNonQuery(query, parameters);
        }

        protected void JobDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadQuestions();
            LoadExamTimer();
        }

        protected void GridViewQuestions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewQuestions.EditIndex = e.NewEditIndex;
            LoadQuestions();
        }

        protected void GridViewQuestions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int questionId = (int)GridViewQuestions.DataKeys[e.RowIndex].Value;
            GridViewRow row = GridViewQuestions.Rows[e.RowIndex];
            string query = "UPDATE Questions SET QuestionText = @QuestionText, Option1 = @Option1, Option2 = @Option2, " +
                           "Option3 = @Option3, Option4 = @Option4, CorrectOption = @CorrectOption WHERE QuestionId = @QuestionId";
            SqlParameter[] parameters =
            {
                new SqlParameter("@QuestionId", questionId),
                new SqlParameter("@QuestionText", ((TextBox)row.FindControl("txtQuestionText")).Text),
                new SqlParameter("@Option1", ((TextBox)row.FindControl("txtOption1")).Text),
                new SqlParameter("@Option2", ((TextBox)row.FindControl("txtOption2")).Text),
                new SqlParameter("@Option3", ((TextBox)row.FindControl("txtOption3")).Text),
                new SqlParameter("@Option4", ((TextBox)row.FindControl("txtOption4")).Text),
                new SqlParameter("@CorrectOption", ((DropDownList)row.FindControl("ddlCorrectOption")).SelectedValue)
            };
            ExecuteNonQuery(query, parameters);

            GridViewQuestions.EditIndex = -1;
            LoadQuestions();
        }

        protected void GridViewQuestions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewQuestions.EditIndex = -1;
            LoadQuestions();
        }

        protected void GridViewQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int questionId = (int)GridViewQuestions.DataKeys[e.RowIndex].Value;
            string query = "DELETE FROM Questions WHERE QuestionId = @QuestionId";
            SqlParameter[] parameters = { new SqlParameter("@QuestionId", questionId) };
            ExecuteNonQuery(query, parameters);
            LoadQuestions();
        }

        private DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        private object ExecuteScalar(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    connection.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        private void ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    connection.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ClearQuestionInputs()
        {
            questionTextBox.Text = string.Empty;
            option1TextBox.Text = string.Empty;
            option2TextBox.Text = string.Empty;
            option3TextBox.Text = string.Empty;
            option4TextBox.Text = string.Empty;
            correctOptionDropDown.SelectedIndex = 0;
        }
    }
}
