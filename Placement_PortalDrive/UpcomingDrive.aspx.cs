using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_PortalDrive
{
    public partial class UpcomingDrive : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUpcomingDrives();
                BindStudents();
                BindCompanies();
            }
        }

        private void BindUpcomingDrives()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CompanyName, DriveDate, Location, Position, Vacancy, Branch FROM UpcomingDrives";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                gvUpcomingDrives.DataSource = reader;
                gvUpcomingDrives.DataBind();
            }
        }

        private void BindStudents()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT StudentId, StudentName FROM Students";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlStudents.DataSource = reader;
                ddlStudents.DataTextField = "StudentName";
                ddlStudents.DataValueField = "StudentId";
                ddlStudents.DataBind();
            }
        }

        private void BindCompanies()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CompanyId, CompanyName FROM Companies";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlCompany.DataSource = reader;
                ddlCompany.DataTextField = "CompanyName";
                ddlCompany.DataValueField = "CompanyId";
                ddlCompany.DataBind();
            }
        }

        protected void btnAddDrive_Click(object sender, EventArgs e)
        {
            string companyName = txtCompanyName.Text;
            string jobLocation = txtJobLocation.Text;
            string jobPosition = txtJobPosition.Text;
            string vacancy = txtVacancy.Text;
            string branch = ddlBranch.SelectedValue;
            DateTime driveDate;

            if (DateTime.TryParseExact(txtDriveDate.Text, "dd-MM-yyyy", null, System.Globalization.DateTimeStyles.None, out driveDate))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO UpcomingDrives (CompanyName, DriveDate, Location, Position, Vacancy, Branch) VALUES (@CompanyName, @DriveDate, @Location, @Position, @Vacancy, @Branch)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CompanyName", companyName);
                    cmd.Parameters.AddWithValue("@DriveDate", driveDate);
                    cmd.Parameters.AddWithValue("@Location", jobLocation);
                    cmd.Parameters.AddWithValue("@Position", jobPosition);
                    cmd.Parameters.AddWithValue("@Vacancy", vacancy);
                    cmd.Parameters.AddWithValue("@Branch", branch);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                BindUpcomingDrives(); // Refresh the GridView
            }
            else
            {
                // Handle invalid date format
                // e.g., show an error message to the user
            }
        }

        

    }
}