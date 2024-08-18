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
    public partial class RegisterStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void txtGR_TextChanged(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            string grNumber = txtGR.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT StudentName FROM StudentAdmission WHERE GR = @GR";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@GR", grNumber);

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    lblName.Text = result.ToString();
                    lblGRNotFound.Visible = false;
                }
                else
                {
                    lblName.Text = "";
                    lblGRNotFound.Visible = true;
                }


                string checkQuery = "SELECT COUNT(*) FROM Students WHERE GR = @GR";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@GR", txtGR.Text.Trim());
                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        Label1.Visible = true;
                         lblName.Text = "";
                    }
                  

                }  
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO Students (GR, FullName, EmailID, MobileNo, Gender, Branch, CurrentYear, Password) " +
                               "VALUES (@GR, @FullName, @EmailID, @MobileNo, @Gender, @Branch, @CurrentYear, @Password)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@GR", txtGR.Text.Trim());
                cmd.Parameters.AddWithValue("@FullName", lblName.Text);
                cmd.Parameters.AddWithValue("@EmailID", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@MobileNo", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@Branch", ddlBranch.SelectedValue);
                cmd.Parameters.AddWithValue("@CurrentYear", ddlYear.SelectedValue);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                cmd.ExecuteNonQuery();
                Response.Redirect("DashboardStudent.aspx");
            }
        }

    }
}
