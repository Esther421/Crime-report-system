using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Reports_case : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            connection.Open();
            string Criminal = "Select DISTINCT crime_place AS NAME  from crime";
            var Criminalcommand = new OdbcCommand(Criminal, connection);
            DropDownList1.DataSource = Criminalcommand.ExecuteReader();
            DropDownList1.DataTextField = "NAME";
            DropDownList1.DataValueField = "NAME";
            DropDownList1.DataBind();
            DropDownList1.AutoPostBack = true;
            connection.Close();

            DataSet table = new DataSet();
            connection.Open();

            string AllCaseForUser = "Select `reporter_fname` As Name, `reporter_lname` As `Last Name`, COUNT(C.Reporter_id) As Cases from reporter R LEFT JOIN crime C ON R.reporter_id = C.reporter_id Where crime_place = '" + DropDownList1.SelectedValue + "'";
            var command = new OdbcCommand(AllCaseForUser, connection);
            var ad = new OdbcDataAdapter(command);
            ad.Fill(table);

            GridView1.DataSource = table;
            GridView1.DataBind();
            connection.Close();

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string attachment = "attachment; filename=User.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        HtmlForm frm = new HtmlForm();
        GridView1.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(GridView1);
        frm.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.AddHeader("content-disposition", "attachment;filename= User.doc");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.word";

        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);


        HtmlForm frm = new HtmlForm();
        GridView1.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(GridView1);
        frm.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=AcademicReport.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        HtmlForm frm = new HtmlForm();
        GridView1.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(GridView1);
        frm.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();
    }
}