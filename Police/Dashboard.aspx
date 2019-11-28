<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Police_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card" style="background: rgba(0,0,0,.8)">
        <div class="card-header bg-danger">
            <strong>All Reported Cases</strong>
        </div>
        <div class="card-body">
            <div class="card-columns">
                <asp:Label ID="Cases" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </div>
    <script>
        function success() {
            swal({
                title: "Success",
                text: "You have successfully reported a case the police will work on it ",
                type: "success"
            });
        }
    </script>

</asp:Content>

