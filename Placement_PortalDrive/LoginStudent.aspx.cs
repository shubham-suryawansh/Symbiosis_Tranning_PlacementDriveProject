using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace Placement_PortalDrive
{
    public partial class LoginStudent : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Hash the password before checking it
               

                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        string query = "SELECT COUNT(*) FROM Students WHERE EmailID = @Email AND Password = @PasswordHash";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@PasswordHash", password);

                            int userCount = (int)cmd.ExecuteScalar();

                            if (userCount > 0)
                            {
                                // Optionally, you can use FormsAuthentication to manage user sessions
                                // FormsAuthentication.SetAuthCookie(email, false);
                                Response.Redirect("DashboardStudent.aspx");
                            }
                            else
                            {
                                lblMessage.Text = "Invalid email or password.";
                                lblMessage.CssClass = "error d-block mb-3";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                    lblMessage.CssClass = "error d-block mb-3";
                }
            }
        }
    }
}
