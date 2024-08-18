using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Placement_PortalDrive
{
    public partial class CollegeDashboard2 : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudentData();
                //BindCompanyData();
                //BindApplicationData();
                DisplayTotalStudents();
                LoadStudentData();
                LoadJobs();
                LoadStudentDataApply();
            }
                
        }

        private void BindStudentData()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Id,GR,FullName,EmailID,MobileNo,Gender,Branch,CurrentYear FROM Students";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    StudentsGridView.DataSource = dt;
                    StudentsGridView.DataBind();
                }
            }
        }


        private void LoadJobs()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Title, Description, Location, Salary, DriveDate FROM Jobs";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvJobs.DataSource = dt;
                    gvJobs.DataBind();
                }
            }
        }


        private void LoadStudentDataApply()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Name, ContactNo, Branch, Marks10th, Marks12th, GraduateMarks, MCAMarks FROM StudentInfo";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable studentTable = new DataTable();
                    adapter.Fill(studentTable);

                    GridView1.DataSource = studentTable;
                    GridView1.DataBind();
                }
            }
        }
            //private void BindCompanyData()
            //{
            //    using (SqlConnection con = new SqlConnection(connectionString))
            //    {
            //        using (SqlCommand cmd = new SqlCommand("SELECT * FROM Company", con))
            //        {
            //            con.Open();
            //            SqlDataAdapter da = new SqlDataAdapter(cmd);
            //            DataTable dt = new DataTable();
            //            da.Fill(dt);
            //            CompanyGridView.DataSource = dt;
            //            CompanyGridView.DataBind();
            //        }
            //    }
            //}

            //private void BindApplicationData()
            //{
            //    using (SqlConnection con = new SqlConnection(connectionString))
            //    {
            //        // Ensure CompanyName is being selected from the Company table
            //        using (SqlCommand cmd = new SqlCommand("SELECT c.CompanyName, sa.Position, sa.Status, sa.ApplyDate FROM StudentApplications sa JOIN Company c ON sa.CompanyId = c.CompanyId", con))
            //        {
            //            con.Open();
            //            SqlDataAdapter da = new SqlDataAdapter(cmd);
            //            DataTable dt = new DataTable();
            //            da.Fill(dt);
            //            ApplicationsGridView.DataSource = dt;
            //            ApplicationsGridView.DataBind();
            //        }
            //    }
            //}
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

        private void DisplayTotalStudents()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Students", con))
                {
                    con.Open();
                    int totalStudents = (int)cmd.ExecuteScalar();
                    TotalStudentsLabel.Text = $"Total Number of Students: {totalStudents}";
                }
            }
        }

        protected void StudentsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int studentId = Convert.ToInt32(StudentsGridView.DataKeys[e.RowIndex].Value);
            string fullName = ((TextBox)StudentsGridView.Rows[e.RowIndex].FindControl("txtFullName")).Text;
            string email = ((TextBox)StudentsGridView.Rows[e.RowIndex].FindControl("txtEmail")).Text;
            string mobileNo = ((TextBox)StudentsGridView.Rows[e.RowIndex].FindControl("txtMobileNo")).Text;
            string gr = ((TextBox)StudentsGridView.Rows[e.RowIndex].FindControl("txtGR")).Text;
            string gender = ((DropDownList)StudentsGridView.Rows[e.RowIndex].FindControl("ddlGender")).SelectedValue;
            string courseName = ((TextBox)StudentsGridView.Rows[e.RowIndex].FindControl("txtCourseName")).Text;
            int year = Convert.ToInt32(((TextBox)StudentsGridView.Rows[e.RowIndex].FindControl("txtYear")).Text);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE Students SET StudentFullName = @FullName, Email = @Email, MobileNo = @MobileNo, GR = @GR, Gender = @Gender, CourseName = @CourseName, Year = @Year WHERE Id = @StudentId", con))
                {
                    cmd.Parameters.AddWithValue("@FullName", (object)fullName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Email", (object)email ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MobileNo", (object)mobileNo ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@GR", (object)gr ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Gender", (object)gender ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@CourseName", (object)courseName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Year", (object)year ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@StudentId", studentId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            StudentsGridView.EditIndex = -1;
            BindStudentData();
        }


        protected void StudentsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int studentId = Convert.ToInt32(StudentsGridView.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Students WHERE Id = @StudentId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@StudentId", studentId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            // Rebind data to reflect changes
            BindStudentData();
        }





        protected void StudentsGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            StudentsGridView.EditIndex = e.NewEditIndex;
            BindStudentData(); // Refresh the GridView to show the edit interface
        }

        protected void StudentsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            StudentsGridView.EditIndex = -1;
            BindStudentData(); // Refresh the GridView
        }

        private void LoadStudentData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM StudentAdmission";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewStudents.DataSource = dt;
                GridViewStudents.DataBind();
            }
        }

        // Method to generate GR number for the entered email and update the database
        protected void btnGenerateGR_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            if (string.IsNullOrEmpty(email))
            {
                // Handle the case where the email input is empty
                // You can display a message or alert here if needed
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if the email already has a GR number
                string selectQuery = "SELECT StudentID, GR FROM StudentAdmission WHERE Email = @Email";
                using (SqlCommand selectCmd = new SqlCommand(selectQuery, conn))
                {
                    selectCmd.Parameters.AddWithValue("@Email", email);

                    using (SqlDataReader reader = selectCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int studentID = reader.GetInt32(0);
                            string existingGR = reader["GR"] as string;

                            if (string.IsNullOrEmpty(existingGR))
                            {
                                // Generate a unique GR number if it's not already generated
                                string generatedGR = GenerateGRNumber();

                                // Update the GR number in the StudentAdmission table
                                reader.Close(); // Close reader before executing update
                                string updateQuery = "UPDATE StudentAdmission SET GR = @GR WHERE StudentID = @StudentID";
                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@GR", generatedGR);
                                    updateCmd.Parameters.AddWithValue("@StudentID", studentID);
                                    updateCmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // Handle the case where GR is already generated
                                // You can display a message or alert here if needed
                            }
                        }
                    }
                }
            }
            LoadStudentData();
        }

        // Method to generate a unique GR number with a length of 10 characters
        // Method to generate a unique GR number with a length of 10 characters
        public string GenerateGRNumber()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Query to get the last GR number from the StudentAdmission table
                string query = "SELECT MAX(CAST(GR AS INT)) FROM StudentAdmission WHERE ISNUMERIC(GR) = 1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    object result = cmd.ExecuteScalar();
                    int lastGRNumber = 0;

                    if (result != DBNull.Value)
                    {
                        lastGRNumber = Convert.ToInt32(result);
                    }

                    // Increment the last GR number to generate the new GR number
                    int newGRNumber = lastGRNumber + 1;

                    // Ensure the new GR number is always 10 digits long by padding with zeros if necessary
                    return newGRNumber.ToString("D10");
                }
            }
        }

    }
}