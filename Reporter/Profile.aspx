<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Reporter_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="card" style="background: rgba(0,0,0,.8)">
                <div class="card-header bg-danger"><strong>Your Profile</strong></div>
                <div class="card-body">
                    <h1>Personal Information</h1>
                    <h2><i class="fa fa-user"></i></h2>
                    <div class="form-group">
                        <label for="exampleInputEmail1">First Name</label>
                        <asp:TextBox ID="firstName" CssClass="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Last Name</label>
                        <asp:TextBox ID="LastName" CssClass="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">ID Number</label>
                        <asp:TextBox ID="idNumber" CssClass="form-control" placeholder="ID Number" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Password</label>
                        <asp:TextBox ID="password" CssClass="form-control" placeholder="Password" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Place</label>
                        <asp:TextBox ID="place" CssClass="form-control" placeholder="Place" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-12 text-center mb-3">
                        <asp:Button ID="Button2" CssClass="btn btn-block mybtn btn-danger tx-tfm" runat="server" Text="update Profile" OnClick="Button2_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
        <script>
            function success() {
                swal({
                    title: "Profile Update",
                    text: "Update was successfully",
                    type: "success"
                });
            }
    </script>
</asp:Content>

