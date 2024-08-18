using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Student_Test
{
    public partial class TestResult : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTestResult();
            }
        }

        private void LoadTestResult()
        {
            int testId = Convert.ToInt32(Request.QueryString["TestId"]);
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Score FROM StudentTests WHERE TestId = @TestId", con);
                cmd.Parameters.AddWithValue("@TestId", testId);
                lblScore.Text = cmd.ExecuteScalar().ToString() + "%";
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("StartTest.aspx");
        }
    }
}
