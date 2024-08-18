using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace HR_Module
{
    public partial class CreateJob : System.Web.UI.Page
    {
        protected void SaveJob(object sender, EventArgs e)
        {
            // Access the TextBox and TextArea values
            string title = titleTextBox.Text;
            string description = descriptionTextArea.Text;
            string location = locationTextBox.Text;
            decimal salary;

            // Ensure the salary value is parsed correctly
            if (!decimal.TryParse(salaryTextBox.Text, out salary))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid salary amount!');", true);
                return;
            }

            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            // SQL insertion
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "INSERT INTO Jobs (Title, Description, Location, Salary) VALUES (@Title, @Description, @Location, @Salary)";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@Salary", salary);

                    int result = cmd.ExecuteNonQuery();
                    if (result > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Job posted successfully!');", true);
                        // Redirect to Home page after successful job posting
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Failed to post job.');", true);
                    }
                }
            }
        }
    }
}
