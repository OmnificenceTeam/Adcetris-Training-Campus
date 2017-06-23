using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class download : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["AppDB"].ConnectionString;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "INSERT INTO LMS_APP_DOWNLOAD_TIME (Time) VALUES ('" + DateTime.Now + "');";
            cmd.CommandType = CommandType.Text;
            cmd.Connection = connection;

            connection.Open();
            cmd.ExecuteNonQuery();
        }
        Response.Redirect("itms-services://?action=download-manifest&url=https://www.adcetristrainingcampus.com/user/app/manifest.plist");

    }
}