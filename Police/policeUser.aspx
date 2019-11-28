<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="policeUser.aspx.cs" Inherits="Police_policeUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card" style="background: rgba(0,0,0,.8)">
        <div class="card-header bg-danger">
            <strong>Registered police Man/Woman</strong>
            <button type="button" class="pull-right btn btn-secondary" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>&nbsp; Add new police</button>&nbsp;
        </div>
        <div class="card-body">
            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Width="1070px">
                <AlternatingRowStyle BackColor="White" />
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
        </div>
    </div>

    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-dark">Add new police man/woman</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Name </label>
                                <asp:TextBox ID="Name" class="form-control" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="Name" CssClass="text-danger" ErrorMessage="Name field is required." />
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Surname </label>
                                <asp:TextBox ID="Surname" class="form-control" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="Surname" CssClass="text-danger" ErrorMessage="Surname field is required." />
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Id number</label>
                                <asp:TextBox ID="IdNo" class="form-control" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="IdNo" CssClass="text-danger" ErrorMessage="Id number field is required." />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="IdNo" CssClass="text-danger" ErrorMessage="Invalid ID number" ValidationExpression="^(\d{2})(0[123456789]|1[012])(0[123456789]|[12][0123456789]|3[01])(\d{4})([01])(8)(\d{1})"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Role</label>
                                <asp:DropDownList ID="role" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Police Chief"> Police Chief</asp:ListItem>
                                    <asp:ListItem Value="Police Officer"> Police Officer</asp:ListItem>
                                    <asp:ListItem Value="Detective"> Detective</asp:ListItem>
                                    <asp:ListItem Value="Crime Scene Investigator"> Crime Scene Investigator</asp:ListItem>
                                    <asp:ListItem Value="Evidence Technician"> Evidence Technician</asp:ListItem>
                                    <asp:ListItem Value="Victim Advocate">Victim Advocate</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="AddButton" OnClick="AddButton_Click" class="btn btn-sm btn-primary" Text="submit" />
                    <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <script>
        function success() {
            swal({
                title: "Success",
                text: "You Have successfully add a new police officer his/her password is 123456",
                type: "success"
            });
        }
        comment

        function Exist() {
            swal({
                title: "User Exist",
                text: "The police officer with that id number already Exist",
                type: "warning"
            });
        }
    </script>
</asp:Content>

