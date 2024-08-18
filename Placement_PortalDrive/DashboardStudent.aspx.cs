using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_Drive
{
    public partial class DashboardStudent : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUpcomingDrives();
            }
        }
        protected void CheckEmailButton_Click(object sender, EventArgs e)
        {
            string email = EmailInput.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                MessageLabel.Text = "Please enter an email.";
                MessageLabel.CssClass = "text-danger";
                return;
            }

            // Define your connection string
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            // Define your SQL query
            string query = "SELECT * FROM Students WHERE EmailID = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    // Populate labels with student details
                    lblGRNO.Text = reader["GR"].ToString();
                    lblFullName.Text = reader["FullName"].ToString();
                    lblEmail.Text = reader["EmailID"].ToString();
                    lblMobileNo.Text = reader["MobileNo"].ToString();
                    lblBranch.Text = reader["Branch"].ToString();


                    // Show the profile card
                    ProfileCard.Visible = true;
                    MessageLabel.Text = "Student profile found.";
                    MessageLabel.CssClass = "text-success";
                }
                else
                {
                    // Hide the profile card if no record is found
                    ProfileCard.Visible = false;
                    MessageLabel.Text = "No student found with this email.";
                    MessageLabel.CssClass = "text-danger";
                }

                reader.Close();
            }
        }

        private void BindUpcomingDrives()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "SELECT CompanyId,CompanyName, DriveDate, Location, Position,Vacancy,Branch FROM Company";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewUpcomingDrives.DataSource = dt;
                GridViewUpcomingDrives.DataBind();
            }
        }

        protected void GridViewUpcomingDrives_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Apply")
            {
                string driveId = e.CommandArgument.ToString();
                Response.Redirect("Apply.aspx?CompanyId=" + driveId);
            }
        }

    }

}
