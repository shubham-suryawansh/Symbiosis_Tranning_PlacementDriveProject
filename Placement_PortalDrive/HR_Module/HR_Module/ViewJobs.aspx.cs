using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace HR_Module
{
    public partial class ViewJobs : System.Web.UI.Page
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
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT JobId, Title, Description, Location, Salary, CreatedAt, DriveDate FROM Jobs";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable jobsTable = new DataTable();
                    adapter.Fill(jobsTable);

                    GridViewJobs.DataSource = jobsTable;
                    GridViewJobs.DataBind();
                }
            }
        }

        protected void SaveJob(object sender, EventArgs e)
        {
            string title = titleTextBox.Text;
            string description = descriptionTextArea.Text;
            string location = locationTextBox.Text;
            decimal salary;

            if (!decimal.TryParse(salaryTextBox.Text, out salary))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid salary amount!');", true);
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

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
                        LoadJobs(); // Refresh the GridView to include the new job
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Failed to post job.');", true);
                    }
                }
            }
        }

        protected void GridViewJobs_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewJobs.EditIndex = e.NewEditIndex;
            LoadJobs();
        }

        protected void GridViewJobs_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int jobId = Convert.ToInt32(GridViewJobs.DataKeys[e.RowIndex].Value);

                TextBox txtTitle = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtTitle");
                TextBox txtDescription = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtDescription");
                TextBox txtLocation = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtLocation");
                TextBox txtSalary = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtSalary");
                TextBox txtDateOfDrive = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtDateOfDrive");

                if (txtTitle == null || txtDescription == null || txtLocation == null || txtSalary == null || txtDateOfDrive == null)
                {
                    throw new Exception("One or more controls are not found.");
                }

                string title = txtTitle.Text;
                string description = txtDescription.Text;
                string location = txtLocation.Text;
                decimal salary = decimal.Parse(txtSalary.Text);
                DateTime? dateOfDrive = null;

                string dateOfDriveText = txtDateOfDrive.Text;
                if (DateTime.TryParse(dateOfDriveText, out var parsedDate))
                {
                    dateOfDrive = parsedDate.Date;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Jobs SET Title = @Title, Description = @Description, Location = @Location, Salary = @Salary, DriveDate = @DriveDate WHERE JobId = @JobId";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.Add("@JobId", SqlDbType.Int).Value = jobId;
                        cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 255).Value = title;
                        cmd.Parameters.Add("@Description", SqlDbType.Text).Value = description;
                        cmd.Parameters.Add("@Location", SqlDbType.NVarChar, 255).Value = location;
                        cmd.Parameters.Add("@Salary", SqlDbType.Decimal).Value = salary;
                        cmd.Parameters.Add("@DriveDate", SqlDbType.Date).Value = dateOfDrive.HasValue ? (object)dateOfDrive.Value : DBNull.Value;

                        connection.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                GridViewJobs.EditIndex = -1;
                LoadJobs();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message; // Display error on the page
            }
        }

        protected void GridViewJobs_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewJobs.EditIndex = -1;
            LoadJobs();
        }

        protected void GridViewJobs_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int jobId = Convert.ToInt32(GridViewJobs.DataKeys[e.RowIndex].Value);

                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Jobs WHERE JobId = @JobId";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.Add("@JobId", SqlDbType.Int).Value = jobId;

                        connection.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadJobs();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message; // Display error on the page
            }
        }
    }
}
