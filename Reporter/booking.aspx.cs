using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reporter_booking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string AllCaseForUser = "Select * from visits V JOIN criminal C ON V.criminal_id = C.criminal_id Where V.reporter_id = '" + Session["reporter"].ToString() + "'";
            var command = new OdbcCommand(AllCaseForUser, connection);
            var reader = command.ExecuteReader();

            visit.Text = "";
            while (reader.Read())
            {
                visit.Text += "<div class=\"card\"><div class=\"card-header\"> Booked to visit <b>" + reader.GetValue(6) + " " + reader.GetValue(7) + "</b></div><div class=\"card-body\">Date : " + reader.GetValue(1) + "<br> Time :" + reader.GetValue(2) + "<br> <strong>Please make sure the you arrive on Time Because all visit are 2 hours</strong> </div></div><br>";
            }

            connection.Close();

            connection.Open();

            string Criminal = "Select criminal_id,CONCAT(criminal_fname,' ',criminal_lname) AS NAME  from criminal";
            var Criminalcommand = new OdbcCommand(Criminal, connection);
            DropDownList1.DataSource = Criminalcommand.ExecuteReader();
            DropDownList1.DataTextField = "NAME";
            DropDownList1.DataValueField = "criminal_id";
            DropDownList1.DataBind();
            connection.Close();

        }
    }
    protected void VisitButton_Click(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string query = "insert into visits values (null,'" + Calendar1.SelectedDate.Date.ToShortDateString() + "','" + TextBox1.Text + "','" + DropDownList1.SelectedValue + "','" + Session["reporter"] + "')";
            OdbcCommand command = new OdbcCommand(query, connection);
            command.ExecuteNonQuery();


            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);
            connection.Close();

            Page_Load(sender,e);

        }
    }
}