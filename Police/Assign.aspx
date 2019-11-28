<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Assign.aspx.cs" Inherits="Police_Assign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
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
</asp:Content>

