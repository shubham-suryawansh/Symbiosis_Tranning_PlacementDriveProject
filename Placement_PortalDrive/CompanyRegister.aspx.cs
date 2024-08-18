using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Placement_PortalDrive
{
    public partial class CompanyRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Add your registration logic here
            // Example: Save the details to the database

            string companyName = txtCompanyName.Text;
            string hrName = txtHRName.Text;
            string companyAddress = txtCompanyAddress.Text;
            string emailID = txtEmailID.Text;
            string password = txtPassword.Text;

            // TODO: Implement database logic to save the details

            // After registration, redirect to a success or login page
            //Response.Redirect("indexx.aspx");
            string connString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            // SQL Insert Query
            string query = "INSERT INTO CompanyLogin (CompanyName, HRName, CompanyAddress, EmailID, Password) " +
                           "VALUES (@CompanyName, @HRName, @CompanyAddress, @EmailID, @Password)";

            // Use ADO.NET to connect to the database and execute the query
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to the command
                    cmd.Parameters.AddWithValue("@CompanyName", companyName);
                    cmd.Parameters.AddWithValue("@HRName", hrName);
                    cmd.Parameters.AddWithValue("@CompanyAddress", companyAddress);
                    cmd.Parameters.AddWithValue("@EmailID", emailID);
                    cmd.Parameters.AddWithValue("@Password", password);


                    // Open the connection and execute the query
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Data inserted successfully!'); window.location='indexx.aspx';", true);



                    }
                    catch (Exception ex)
                    {
                        // Handle any errors
                        Response.Write("Error: " + ex.Message);
                    }
                }

            }
        }
        }
}