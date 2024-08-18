using System;
using System.Data.SqlClient;
using System.Configuration;

namespace HR_Module
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Count Jobs
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Jobs", connection))
                {
                    int jobCount = (int)cmd.ExecuteScalar();
                    jobCountLabel.Text = jobCount.ToString();
                }

                // Count Tests
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Questions", connection))
                {
                    int testCount = (int)cmd.ExecuteScalar();
                    testCountLabel.Text = testCount.ToString();
                }

                // Recent Scores
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 StudentName + ': ' + CAST(Score AS NVARCHAR) FROM TestScores ORDER BY TestScoreId DESC", connection))
                {
                    var recentScores = cmd.ExecuteScalar();
                    recentScoresLabel.Text = recentScores != null ? recentScores.ToString() : "N/A";
                }
            }
        }
    }
}
