using System;
using System.Data.SqlClient;
using System.Configuration;

namespace HR_Module
{
    public partial class ViewTestScores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadScores();
            }
        }
        private void LoadScores()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT StudentName, Score FROM TestScores";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string row = $@"
                        <tr>
                            <td>{reader.GetString(0)}</td>
                            <td>{reader.GetDecimal(1):F2}</td>
                        </tr>";

                        scoresTable.InnerHtml += row;
                    }
                }
            }
        }
    }
}