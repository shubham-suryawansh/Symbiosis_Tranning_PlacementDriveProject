using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Student_Test
{
    public partial class StartTest : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadJobs();
            }
        }

        private void LoadJobs()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT JobId, Title FROM Jobs", con);
                ddlJobs.DataSource = cmd.ExecuteReader();
                ddlJobs.DataTextField = "Title";
                ddlJobs.DataValueField = "JobId";
                ddlJobs.DataBind();
            }
        }

        protected void btnStartTest_Click(object sender, EventArgs e)
        {
            Session["JobId"] = ddlJobs.SelectedValue;
            Session["StudentName"] = txtStudentName.Text;
            Response.Redirect("TakeTest.aspx");
        }
    }
}
