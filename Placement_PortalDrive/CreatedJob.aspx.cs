using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_PortalDrive
{
    public partial class CreatedJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
        protected void SaveDetails_Click(object sender, EventArgs e)
        {
            // Retrieve data from input fields
            string companyName = CompanyName.Text.Trim();
           
            string position = Position.Text.Trim();
            string vacancy = Vacancy.Text.Trim();
            string branch = Branch.Text.Trim(); // Retrieve Branch field value

            // Validate data (you may add more validations as needed)
            if (string.IsNullOrEmpty(companyName) || string.IsNullOrEmpty(position) || string.IsNullOrEmpty(vacancy) || string.IsNullOrEmpty(branch))
            {
                // Handle validation errors (e.g., display a message)
                // Example: ErrorMessage.Text = "All fields are required.";
                return;
            }

            // Insert data into the database
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string query = "INSERT INTO CreatedJob (CompanyName, Position, Vacancy, Branch) VALUES (@CompanyName, @DriveDate, @Location, @Position, @Vacancy, @Branch)";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CompanyName", companyName);
                       
                        cmd.Parameters.AddWithValue("@Position", position);
                        cmd.Parameters.AddWithValue("@Vacancy", int.Parse(vacancy)); // Assuming Vacancy is an integer
                        cmd.Parameters.AddWithValue("@Branch", branch);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Rebind the upcoming drives GridView to reflect the new entry
               

                // Optionally, clear the form fields after saving
                CompanyName.Text = "";
               
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
    }
            
}