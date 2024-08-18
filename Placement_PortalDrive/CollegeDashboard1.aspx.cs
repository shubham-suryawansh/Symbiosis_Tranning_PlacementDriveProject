using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_PortalDrive
{
    public partial class CollegeDashboard1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTotalStudents();
                BindStudentGrid();
                BindStudentStatus();
             
            }
        }

        private void BindStudentGrid()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "SELECT Id, FName, LName, Email, MobileNo, Gender, CourseName, Year FROM Students";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            // Clear the session
            Session.Clear();
            Session.Abandon();

            // Redirect to the login page
            Response.Redirect("CollegeDashboard.aspx");
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "DELETE FROM Students WHERE Id = @Id";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Re-bind the student list grid to reflect the deletion
            BindStudentGrid();
        }

        private void BindStudentStatus()
        {
            DataTable dt = GetSampleStudentStatusData();
            GridViewStudentStatus.DataSource = dt;
            GridViewStudentStatus.DataBind();
        }

        private DataTable GetSampleStudentStatusData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("FName", typeof(string));
            dt.Columns.Add("LName", typeof(string));
            dt.Columns.Add("CompanyName", typeof(string));
            dt.Columns.Add("MarksPercentage", typeof(int));
            dt.Columns.Add("SelectionStatus", typeof(string));

            // Adding some sample data
            dt.Rows.Add("Shubham", "Surywanshi", "TCS", 85, "Selected");
            dt.Rows.Add("Ajay", "Kedar", "Innovate Ltd", 78, "Selected");
            dt.Rows.Add("Ravindra", "Ravindr", "Google", 78, "Rejected");



            return dt;
        }

        private void LoadTotalStudents()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM Students";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                int studentCount = (int)command.ExecuteScalar();
                lblTotalStudents.Text = $"Total Students: {studentCount}";
            }
        }
    }

}
