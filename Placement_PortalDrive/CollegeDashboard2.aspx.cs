using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_PortalDrive
{
    public partial class CollegeDashboad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUpcomingDrives();
                BindCompanyInfo();
            }
        }

        protected void SaveDetails_Click(object sender, EventArgs e)
        {
            // Retrieve data from input fields
            string companyName = CompanyName.Text.Trim();
            string driveDate = DriveDate.Text.Trim();
            string location = Location.Text.Trim();
            string position = Position.Text.Trim();
            string vacancy = Vacancy.Text.Trim();
            string branch = Branch.Text.Trim(); // Retrieve Branch field value

            // Validate data (you may add more validations as needed)
            if (string.IsNullOrEmpty(companyName) || string.IsNullOrEmpty(driveDate) || string.IsNullOrEmpty(location) || string.IsNullOrEmpty(position) || string.IsNullOrEmpty(vacancy) || string.IsNullOrEmpty(branch))
            {
                // Handle validation errors (e.g., display a message)
                // Example: ErrorMessage.Text = "All fields are required.";
                return;
            }

            // Insert data into the database
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "INSERT INTO Company (CompanyName, DriveDate, Location, Position, Vacancy, Branch) VALUES (@CompanyName, @DriveDate, @Location, @Position, @Vacancy, @Branch)";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CompanyName", companyName);
                        cmd.Parameters.AddWithValue("@DriveDate", driveDate);
                        cmd.Parameters.AddWithValue("@Location", location);
                        cmd.Parameters.AddWithValue("@Position", position);
                        cmd.Parameters.AddWithValue("@Vacancy", int.Parse(vacancy)); // Assuming Vacancy is an integer
                        cmd.Parameters.AddWithValue("@Branch", branch);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Rebind the upcoming drives GridView to reflect the new entry
                BindUpcomingDrives();

                // Optionally, clear the form fields after saving
                CompanyName.Text = "";
                DriveDate.Text = "";
                Location.Text = "";
                Position.Text = "";
                Vacancy.Text = "";
                Branch.Text = "";
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
                // Example: ErrorMessage.Text = "An error occurred: " + ex.Message;
            }
        }

        private void BindUpcomingDrives()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "SELECT Id, CompanyName,Position, Vacancy, Branch FROM Company"; // Updated query to include Branch

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridViewUpcomingDrives.DataSource = dt;
                    GridViewUpcomingDrives.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
                // Example: ErrorMessage.Text = "An error occurred while binding the grid: " + ex.Message;
            }
        }

        private void BindCompanyInfo()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "SELECT CompanyName, HRName, CompanyAddress FROM CompanyLogin";

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridViewCompanyInfo.DataSource = dt;
                    GridViewCompanyInfo.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
                // Example: ErrorMessage.Text = "An error occurred while binding company info: " + ex.Message;
            }
        }

        protected void GridViewUpcomingDrives_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Apply")
            {
                string driveId = e.CommandArgument.ToString();
                Response.Redirect("Apply.aspx?Id=" + driveId);
            }
        }



    }

}
