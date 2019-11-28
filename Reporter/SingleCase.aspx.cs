using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reporter_SingleCase : System.Web.UI.Page
{
    public Case SingleCase = new Case();
    public class Case
    {
        public string CrimeType { get; set; }
        public string CrimeDescription { get; set; }
        public string CrimeStatus { get; set; }
        public string CrimeOffer { get; set; }
        public string CrimePlace { get; set; }
        public string Comment { get; set; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        var CaseId = Request.QueryString["CaseId"];

        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string AllCaseForUser = "Select * from crime C Left JOIN police P ON P.police_id = C.police_id Where C.crime_id=" + Convert.ToInt32(CaseId);
            var command = new OdbcCommand(AllCaseForUser, connection);
            var reader = command.ExecuteReader();

            while (reader.Read())
            {
                SingleCase.CrimeType = reader.GetValue(1).ToString();
                SingleCase.CrimeDescription = reader.GetValue(2).ToString();
                SingleCase.CrimeStatus = reader.GetValue(3).ToString();
                SingleCase.CrimePlace = reader.GetValue(6).ToString();
                SingleCase.Comment = reader.GetValue(8).ToString();
                if (reader.GetValue(9).ToString() != "")
                {
                    SingleCase.CrimeOffer = reader.GetValue(9).ToString() + " " + reader.GetValue(10).ToString() + " (" + reader.GetValue(11).ToString() + ")";
                }
                else
                {
                    SingleCase.CrimeOffer = "NO OFFICER ASSOCIATED WITH THE CASE YET!";
                }
            }

            connection.Close();

            connection.Open();
            string query = "Select * from crimeImage Where crime_id = " + Convert.ToInt32(CaseId);
            var imagecommand = new OdbcCommand(query, connection);
            var imageReader = imagecommand.ExecuteReader();

            Images.Text = "";
            var count = 1;
            while(imageReader.Read())
            {
                Images.Text += " <div class=\"mySlides fade\"><img src=\"/CrimeImages/" + imageReader.GetValue(2).ToString() + "\"style=\"width:100%\"></div>";
            }
            connection.Close();

     /*       connection.Open();
            string Criminal = "Select criminal_id,CONCAT(criminal_fname,' ',criminal_lname) AS NAME  from criminal";
            var Criminalcommand = new OdbcCommand(Criminal, connection);
            DropDownList1.DataSource = Criminalcommand.ExecuteReader();
            DropDownList1.DataTextField = "NAME";
            DropDownList1.DataValueField = "criminal_id";
            DropDownList1.DataBind();
            connection.Close();

        /*    connection.Open();
            string police = "Select police_id,CONCAT(police_name,' ',police_lname) AS NAME  from police";
            var policecommand = new OdbcCommand(police, connection);
            DropDownList4.DataSource = policecommand.ExecuteReader();
            DropDownList4.DataTextField = "NAME";
            DropDownList4.DataValueField = "police_id";
            DropDownList4.DataBind();
            connection.Close();
            */
        }
    }
    protected void UploadButton_Click(object sender, EventArgs e)
    {
        var CaseId = Request.QueryString["CaseId"];

        if (FileUploadControl.HasFile)
        {
            try
            {
                string filename = Path.GetFileName(FileUploadControl.FileName);
                FileUploadControl.SaveAs(Server.MapPath("~/CrimeImages/") + filename);

                using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    connection.Open();

                    string query = "insert into crimeimage values (null,'" + CaseId + "','" + filename + "')";
                    OdbcCommand command = new OdbcCommand(query, connection);
                    command.ExecuteNonQuery();

                    connection.Close();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "error();", true);
            }
        }
    }
    protected void AddButton_Click(object sender, EventArgs e)
    {
        var CaseId = Request.QueryString["CaseId"];

        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            if (Name.Text != null && Name.Text != string.Empty && Surname.Text != null && Surname.Text != string.Empty)
            {
                connection.Open();
                string query = "insert into criminal values (null,'" + Name.Text + "','" + Surname.Text + "','" + IdNo.Text + "','" + crime.SelectedValue + "')";
                OdbcCommand command = new OdbcCommand(query, connection);
                command.ExecuteNonQuery();

                connection.Close();

                connection.Open();
                string Criminal = "Select MAX(criminal_id) from criminal";
                var Criminalcommand = new OdbcCommand(Criminal, connection);
                var temp = Criminalcommand.ExecuteScalar();
                connection.Close();

                connection.Open();

                string query1 = "Update crime Set criminal_id ='" + Convert.ToInt32(temp) + "' Where crime_id = " + CaseId;
                OdbcCommand command1 = new OdbcCommand(query1, connection);
                command1.ExecuteNonQuery();

                connection.Close();

                Name.Text = "";
                Surname.Text = "";
                IdNo.Text = "";

            }
            else
            {
                connection.Open();

                string query = "Update crime Set criminal_id ='" + DropDownList1.SelectedValue + "' Where crime_id =" + CaseId;

                OdbcCommand command = new OdbcCommand(query, connection);
                command.ExecuteNonQuery();

                connection.Close();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "criminal();", true);

            Page_Load(sender, e);
        }
    }
    protected void Status_Click(object sender, EventArgs e)
    {
         var CaseId = Request.QueryString["CaseId"];

        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string query = "Update crime Set crime_status ='" + DropDownList2.SelectedValue + "', police_id = '" + DropDownList4.SelectedValue + "' Where crime_id =" + CaseId;
            OdbcCommand command = new OdbcCommand(query, connection);
            command.ExecuteNonQuery();

            connection.Close();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "status();", true);
            Page_Load(sender, e);
        }
    }
    protected void Comment_Click(object sender, EventArgs e)
    {
        var CaseId = Request.QueryString["CaseId"];

        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();

            string query = "Update crime Set comment ='" + TbxComment.Text + "' Where crime_id =" + CaseId;
            OdbcCommand command = new OdbcCommand(query, connection);
            command.ExecuteNonQuery();

            connection.Close();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "comment();", true);
            Page_Load(sender, e);
        }
    }
}