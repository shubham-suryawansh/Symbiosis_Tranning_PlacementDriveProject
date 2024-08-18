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
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

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
            decimal salary= Convert.ToDecimal( salaryTextBox.Text);
            string driveDate = DriveDate.Text.Trim();

            if (!decimal.TryParse(salaryTextBox.Text, out salary))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid salary amount!');", true);
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "INSERT INTO Jobs (Title, Description, Location, Salary,DriveDate) VALUES (@Title, @Description, @Location, @Salary,@DriveDate)";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@Salary", salary);
                    cmd.Parameters.AddWithValue("@DriveDate", driveDate);
                    ;

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

                    titleTextBox.Text = "";
                    descriptionTextArea.Text= "";
                    locationTextBox.Text= "";
                    salaryTextBox.Text = "";
                    DriveDate.Text="";

                }
            }
        }

        //protected void GridViewJobs_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    GridViewJobs.EditIndex = e.NewEditIndex;
        //    LoadJobs();
        //}

        //protected void GridViewJobs_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    try
        //    {
        //        int jobId = Convert.ToInt32(GridViewJobs.DataKeys[e.RowIndex].Value);

        //        TextBox txtTitle = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtTitle");
        //        TextBox txtDescription = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtDescription");
        //        TextBox txtLocation = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtLocation");
        //        TextBox txtSalary = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtSalary");
        //        TextBox txtDateOfDrive = (TextBox)GridViewJobs.Rows[e.RowIndex].FindControl("txtDateOfDrive");

              

        //        string title = txtTitle.Text;
        //        string description = txtDescription.Text;
        //        string location = txtLocation.Text;

        //        if (!decimal.TryParse(txtSalary.Text, out decimal salary))
        //        {
        //            throw new Exception("Invalid salary amount.");
        //        }

        //        DateTime? dateOfDrive = null;
        //        if (DateTime.TryParse(txtDateOfDrive.Text, out var parsedDate))
        //        {
        //            dateOfDrive = parsedDate.Date;
        //        }

        //        string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

        //        using (SqlConnection connection = new SqlConnection(connectionString))
        //        {
        //            string query = "UPDATE Jobs SET Title = @Title, Description = @Description, Location = @Location, Salary = @Salary, DriveDate = @DriveDate WHERE JobId = @JobId";
        //            using (SqlCommand cmd = new SqlCommand(query, connection))
        //            {
        //                cmd.Parameters.Add("@JobId", SqlDbType.Int).Value = jobId;
        //                cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 255).Value = title;
        //                cmd.Parameters.Add("@Description", SqlDbType.Text).Value = description;
        //                cmd.Parameters.Add("@Location", SqlDbType.NVarChar, 255).Value = location;
        //                cmd.Parameters.Add("@Salary", SqlDbType.Decimal).Value = salary;
        //                cmd.Parameters.Add("@DriveDate", SqlDbType.Date).Value = dateOfDrive.HasValue ? (object)dateOfDrive.Value : DBNull.Value;

        //                connection.Open();
        //                cmd.ExecuteNonQuery();
        //            }
        //        }

        //        GridViewJobs.EditIndex = -1;
        //        LoadJobs();
        //    }
        //    catch (Exception ex)
        //    {
        //        lblError.Text = "Error: " + ex.Message; // Display error on the page
        //    }
        //}

        //protected void GridViewJobs_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    GridViewJobs.EditIndex = -1;
        //    LoadJobs();
        //}

        //protected void GridViewJobs_RowDeleting(object sender, GridViewDeleteEventArgs e)
        //{
        //    try
        //    {
        //        int jobId = Convert.ToInt32(GridViewJobs.DataKeys[e.RowIndex].Value);

        //        string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

        //        using (SqlConnection connection = new SqlConnection(connectionString))
        //        {
        //            string query = "DELETE FROM Jobs WHERE JobId = @JobId";
        //            using (SqlCommand cmd = new SqlCommand(query, connection))
        //            {
        //                cmd.Parameters.Add("@JobId", SqlDbType.Int).Value = jobId;

        //                connection.Open();
        //                cmd.ExecuteNonQuery();
        //            }
        //        }

        //        LoadJobs();
        //    }
        //    catch (Exception ex)
        //    {
        //        lblError.Text = "Error: " + ex.Message; // Display error on the page
        //    }
        //}
    }
}
