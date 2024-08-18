using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_PortalDrive
{
    public partial class CollegeDashboard : System.Web.UI.Page
    {
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
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mydbConnectionString+"].ConnectionString;

            // Define your SQL query
            string query = "SELECT * FROM Students WHERE Email = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    // Populate labels with student details
                    lblFirstName.Text = reader["FName"].ToString();
                    lblLastName.Text = reader["LName"].ToString();
                    lblEmail.Text = reader["Email"].ToString();
                    lblMobileNo.Text = reader["MobileNo"].ToString();
                    lblGender.Text = reader["Gender"].ToString();
                    lblCourseName.Text = reader["CourseName"].ToString();
                    lblYear.Text = reader["Year"].ToString();

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

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            // Redirect to the edit page with the email as a query parameter
            Response.Redirect($"EditStudent.aspx?Email={lblEmail.Text}");
        }

    }
}