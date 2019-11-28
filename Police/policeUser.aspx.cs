using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Police_policeUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet table = new DataSet();
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();
            var query = "Select police_name As 'First Name', police_lName As 'Last Name', police_status AS Role, Id_number AS 'ID Number' From police";
            var command = new OdbcCommand(query, connection);
            var ad = new OdbcDataAdapter(command);
            ad.Fill(table);

            GridView1.DataSource = table;
            GridView1.DataBind();

            connection.Close();
        }
    }
    protected void AddButton_Click(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            if (Name.Text != null && Name.Text != string.Empty && Surname.Text != null && Surname.Text != string.Empty)
            {
                connection.Open();
                string ExistingUser = "Select Count(*) From police Where Id_number = '" + IdNo.Text + "'";
                OdbcCommand ExistCommand = new OdbcCommand(ExistingUser, connection);
                var Temp = ExistCommand.ExecuteScalar();
                connection.Close();

                if (Convert.ToInt32(Temp) == 0)
                {
                    connection.Open();
                    string query = "insert into police values (null,'" + Name.Text + "','" + Surname.Text + "','" + role.SelectedValue + "',NULL,123456,'" + IdNo.Text + "')";
                    OdbcCommand command = new OdbcCommand(query, connection);
                    command.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);

                    connection.Close();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "Exist();", true);
                }

                Page_Load(sender, e);
            }
        }
    }
}