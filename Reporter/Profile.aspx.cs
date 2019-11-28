using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reporter_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();

                string AllCaseForUser = "Select * from reporter Where reporter_ID_num ='" + Session["reporter"].ToString() + "'";
                var command = new OdbcCommand(AllCaseForUser, connection);
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    firstName.Text = reader.GetValue(1).ToString();
                    LastName.Text = reader.GetValue(2).ToString();
                    idNumber.Text = reader.GetValue(3).ToString();
                    idNumber.ReadOnly = true;
                    password.Text = reader.GetValue(7).ToString();
                    place.Text = reader.GetValue(4).ToString();
                }

                connection.Close();

            }
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string AllCaseForUser = "Update reporter Set reporter_fname = '" + firstName.Text + "', reporter_lname ='" + LastName.Text + "',password ='" + password.Text + "',reporter_place ='" + place.Text + "' Where reporter_ID_num = '" + Session["reporter"].ToString() + "'";
            var command = new OdbcCommand(AllCaseForUser, connection);
            command.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);
            connection.Close();

        }
    }
}