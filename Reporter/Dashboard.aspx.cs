using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reporter_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string AllCaseForUser = "Select * from reporter R JOIN crime C ON R.Reporter_id = C.reporter_id Where R.reporter_id = '" + Session["reporter"].ToString() + "'";
            var command = new OdbcCommand(AllCaseForUser,connection);
            var reader = command.ExecuteReader();

            Cases.Text = "";
            while(reader.Read())
            {
                Cases.Text += "<div class=\"card\"><div class=\"card-header\">" + reader.GetValue(1) + " " + reader.GetValue(2) + "</div><div class=\"card-body\"><blockquote class=\"blockquote mb-0\"><p>" + reader.GetValue(10) + "</p><footer class=\"blockquote-footer\">Case Type <cite title=\"Source Title\"><strong>" + reader.GetValue(9) + "</strong></cite></footer></blockquote><a class=\"btn btn-secondary\" href=\"/Reporter/SingleCase.aspx?CaseId=" + reader.GetValue(8) + "\"><i class=\"fa fa-eye\"></i> view case Details</a></div></div><br>";
            }

            connection.Close();

        }
    }
    protected void ReportButton_Click(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string insertCrime = "insert into crime values(null,'" + DropDownList1.SelectedValue + "','" + crimeDsc.Text + "','Pending','" + Session["reporter"] + "',Null,'"+place.Text+"',null,null)";
            OdbcCommand insertCommand = new OdbcCommand(insertCrime, connection);
            insertCommand.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);

            connection.Close();

        }
    }
}