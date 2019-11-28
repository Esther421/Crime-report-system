<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="booking.aspx.cs" Inherits="Reporter_booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card" style="background: rgba(0,0,0,.8)">
        <div class="card-header bg-danger">
            <strong>Visit List</strong>
            <button type="button" class="pull-right btn btn-secondary" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;book Visit</button>
        </div>
        <div class="card-body">
            <asp:Label ID="visit" runat="server" Text=""></asp:Label>
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
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Criminal Name</label>
                                <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Select The Time </label>
                                <asp:TextBox ID="TextBox1" TextMode="Time" class="form-control"  runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <label class="text-dark">Select a Date</label>
                                        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="750px">
                                            <DayHeaderStyle Font-Bold="True" Font-Size="8pt"></DayHeaderStyle>

                                            <NextPrevStyle VerticalAlign="Bottom" Font-Bold="True" Font-Size="8pt" ForeColor="#333333"></NextPrevStyle>

                                            <OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>

                                            <SelectedDayStyle BackColor="#333399" ForeColor="White"></SelectedDayStyle>

                                            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399"></TitleStyle>

                                            <TodayDayStyle BackColor="#CCCCCC"></TodayDayStyle>
                                        </asp:Calendar>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="VisitButton" OnClick="VisitButton_Click" class="btn btn-sm btn-primary" Text="submit" />
                    <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>

    <script>
        function success() {
            swal({
                title: "Success",
                text: "You Have successfully made a booking",
                type: "success"
            });
        }
    </script>
</asp:Content>



