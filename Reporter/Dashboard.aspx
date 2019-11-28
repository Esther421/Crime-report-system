<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Reporter_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card" style="background: rgba(0,0,0,.8)">
        <div class="card-header bg-danger">
            <strong>Case You have Reported</strong>
            <button type="button" class="pull-right btn btn-secondary" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;Report New Case</button>
        </div>
        <div class="card-body">
            <div class="card-columns">
                <asp:Label ID="Cases" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-dark">Report a new case</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-dark">Place</label>
                                <asp:TextBox ID="place" CssClass="form-control" placeholder="Place" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-dark">Crime Type</label>
                                <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Murder">Murder</asp:ListItem>
                                    <asp:ListItem Value="Assault">Assault</asp:ListItem>
                                    <asp:ListItem Value="Hijack">Hijack</asp:ListItem>
                                    <asp:ListItem Value="Rape">Rape</asp:ListItem>
                                    <asp:ListItem Value="Gun Fight">Gun Fight</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Crime Description</label>
                                <asp:TextBox ID="crimeDsc" CssClass="form-control" placeholder="Crime Description" TextMode="MultiLine" Rows="7" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="ReportButton" OnClick="ReportButton_Click" class="btn btn-sm btn-primary" Text="submit" />
                    <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal">Close</button>
                </div>

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

