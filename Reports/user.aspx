<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="user.aspx.cs" Inherits="Reports_user" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card" style="top: 30px; left: 21px;">
        <div class="card-header bg-danger">
            <strong>User Reports</strong>
        </div>
        <div class="card-body">
            <h1  class="text-dark">Report Of all Users</h1>

            <h1  class="text-dark">Report</h1>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="970px">
                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#330099" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                <SortedAscendingCellStyle BackColor="#FEFCEB" />
                <SortedAscendingHeaderStyle BackColor="#AF0101" />
                <SortedDescendingCellStyle BackColor="#F6F0C0" />
                <SortedDescendingHeaderStyle BackColor="#7E0000" />
            </asp:GridView>
            <br>
            <div class="row">
                <div class="col-md-4">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Export Excel" onclick="Button1_Click"/>
                </div>
                 <div class="col-md-4">
                        <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary" Text="Export Word" onclick="Button2_Click"/>
                 </div>
                 <div class="col-md-4">
                        <asp:Button ID="Button3" runat="server" CssClass="btn btn-danger" Text="Export PDF" onclick="Button3_Click"/>
                 </div>
            </div>
        </div>
    </div>
</asp:Content>

