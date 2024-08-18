using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Placement_PortalDrive
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Any initialization code
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Replace this with your actual logic for validating credentials
            if (username == "admin" && password == "1234")
            {
                Session["Username"] = username;
                Response.Redirect("CollegeDashboard.aspx");
            }
            else
            {
                // Show an error message
                Response.Write("<script>alert('Invalid username or password.');</script>");
            }
        }
    }
}