<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SingleCase.aspx.cs" Inherits="Reporter_SingleCase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        * {
            box-sizing: border-box;
        }

        .mySlides {
            display: none;
        }

        img {
            vertical-align: middle;
        }

        /* Slideshow container */
        .slideshow-container {
            max-width: 1000px;
            position: relative;
            margin: auto;
        }

        /* Next & previous buttons */
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
        }

        /* Position the "next button" to the right */
        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

            /* On hover, add a black background color with a little bit see-through */
            .prev:hover, .next:hover {
                background-color: rgba(0,0,0,0.8);
            }

        /* Caption text */
        .text {
            color: #f2f2f2;
            font-size: 15px;
            padding: 8px 12px;
            position: absolute;
            bottom: 8px;
            width: 100%;
            text-align: center;
        }

        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        /* Fading animation */
        .fade {
            -webkit-animation-name: fade;
            -webkit-animation-duration: 1.5s;
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @-webkit-keyframes fade {
            from {
                opacity: .4;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes fade {
            from {
                opacity: .4;
            }

            to {
                opacity: 1;
            }
        }

        /* On smaller screens, decrease text size */
        @media only screen and (max-width: 300px) {
            .prev, .next, .text {
                font-size: 11px;
            }
        }
    </style>
    <div class="card" style="background: rgba(0,0,0,.8)">
        <div class="card-header bg-danger">
            <strong>Reported Case</strong>
            <%if (Session["Admin"] != null)
              {%>
            <button type="button" class="pull-right btn btn-secondary" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>&nbsp; Add criminal</button>&nbsp;
             <button type="button" class="pull-right btn btn-warning" data-toggle="modal" data-target="#myModal1"><i class="fa fa-edit"></i>&nbsp; Change Status</button>&nbsp;
            <%} %>

            <%if (Session["police"] != null)
              {%>
            <button type="button" class="pull-right btn btn-primary" data-toggle="modal" data-target="#myModal3"><i class="fa fa-comment"></i>&nbsp; Add Comment</button>&nbsp;
            <%} %>
        </div>
        <div class="card-body text-white">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <p><strong>Case Type</strong> <%=SingleCase.CrimeType %></p>
                <p><strong>Case Description</strong></p>
                <p><%=SingleCase.CrimeDescription %></p>
                <p><strong>Case Status</strong></p>
                <p><%=SingleCase.CrimeStatus %></p>
                <p><strong>Place Of Crime<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Dsn=CMS;uid=root;pwd=root" ProviderName="System.Data.Odbc" SelectCommand="SELECT police_id, police_name FROM police"></asp:SqlDataSource>
                    </strong></p>
                <p><%=SingleCase.CrimePlace %></p>
                <p><strong>Office<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Dsn=CMS;uid=root;pwd=root" ProviderName="System.Data.Odbc" SelectCommand="Select criminal_id,CONCAT(criminal_fname,' ',criminal_lname) AS NAME  from criminal"></asp:SqlDataSource>r Associated with Case </strong></p>
                <p><%=SingleCase.CrimeOffer %></p>
                <p><strong>Officer Comment on Case</strong></p>
                <p><%=SingleCase.Comment %></p>
            </div>
            <div class="col-md-1"></div>
            <div class="card bg-secondary">
                <div class="card-header">
                    Crime Images
                    <asp:Button runat="server" ID="UploadButton" Text="Upload" CssClass="pull-right btn btn-primary" OnClick="UploadButton_Click" />
                    <asp:FileUpload ID="FileUploadControl" CssClass="pull-right" runat="server" />
                </div>
                <div class="card-body">
                    <div class="slideshow-container">
                        <asp:Label ID="Images" runat="server" Text=""></asp:Label>
                        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                        <a class="next" onclick="plusSlides(1)">&#10095;</a>
                        <asp:DataList ID="DataList1" runat="server" DataSourceID="dtsrcImages" RepeatColumns="4" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <asp:Image ID="Image3" runat="server" ImageUrl='<%# Eval("image_url") %>' />
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="dtsrcImages" runat="server" ConnectionString="Dsn=CMS;uid=root;pwd=root" ProviderName="System.Data.Odbc" SelectCommand="SELECT image_url FROM crimeimage
WHERE crime_id = ?">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="crime_id" QueryStringField="caseID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-dark">Add a criminal</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#old">&nbsp;Existing Criminal</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#new">&nbsp;New Criminal</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div id="old" class="row tab-pane active">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text-dark">Criminal Name</label>
                                    <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server" DataSourceID="SqlDataSource2" DataTextField="NAME" DataValueField="criminal_id">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div id="new" class="row tab-pane">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text-dark">Name </label>
                                    <asp:TextBox ID="Name" class="form-control" runat="server"></asp:TextBox>

                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text-dark">Surname </label>
                                    <asp:TextBox ID="Surname" class="form-control" runat="server"></asp:TextBox>

                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text-dark">Id number</label>
                                    <asp:TextBox ID="IdNo" class="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text-dark">crime Commited</label>
                                    <asp:DropDownList ID="crime" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="Murder">Murder</asp:ListItem>
                                        <asp:ListItem Value="Assault">Assault</asp:ListItem>
                                        <asp:ListItem Value="Hijack">Hijack</asp:ListItem>
                                        <asp:ListItem Value="Rape">Rape</asp:ListItem>
                                        <asp:ListItem Value="Gun Fight">Gun Fight</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
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

    <div class="modal fade" id="myModal1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-dark">Change status</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Crime status</label>
                                <asp:DropDownList ID="DropDownList2" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="assigned">Assigned</asp:ListItem>
                                    <asp:ListItem Value="completed">Completed</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label class="text-dark">Police To work on Case</label>
                                <asp:DropDownList ID="DropDownList4" CssClass="form-control" runat="server" DataSourceID="SqlDataSource1" DataTextField="police_name" DataValueField="police_id">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="Status" OnClick="Status_Click" class="btn btn-sm btn-primary" Text="submit" />
                    <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal3">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-dark">Add Comment</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-dark">Comments</label>
                                <asp:TextBox ID="TbxComment" CssClass="form-control" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="Comment" OnClick="Comment_Click" class="btn btn-sm btn-primary" Text="submit" />
                    <button type="button" class="btn btn-sm btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>


    <script>
        var slideIndex = 1;
        showSlides(slideIndex);

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace("active", "");
            }
            slides[slideIndex - 1].style.display = "block";
        }

        function success() {
            swal({
                title: "Success",
                text: "You Have successfully made a uploaded a photo",
                type: "success"
            });
        }

        function criminal() {
            swal({
                title: "Success",
                text: "You Have successfully captured a criminal",
                type: "success"
            });
        }

        function status() {
            swal({
                title: "Success",
                text: "You Have successfully update the status for the case",
                type: "success"
            });
        }
        comment

        function comment() {
            swal({
                title: "Success",
                text: "You Have successfully Add a comment to the case",
                type: "success"
            });
        }
    </script>
</asp:Content>

