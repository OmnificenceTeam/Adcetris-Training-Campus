<%@ page language="C#" autoeventwireup="true" inherits="Learning, App_Web_ul3pvwtd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>My Learning</title>
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("[class*=fa-plus-square]").live("click", function () {
            $(this).closest("tr").after("<tr><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("class", "fa fa-minus-square");
        });
        $("[class*=fa-minus-square]").live("click", function () {
            $(this).attr("class", "fa fa-plus-square");
            $(this).closest("tr").next().remove();
        });
    </script>
    <style type="text/css">
        .SubGrid th {
            text-align: center;
            background-color: #FFFFFF;
            padding: 10px;
        }

        .SubGrid td {
            background-color: #FFFFFF;
            padding: 10px;
        }

        .SubGrid {
            border-collapse: separate !important;
            border-spacing: 3px;
        }

            .SubGrid tbody tr th:first-child {
                border-bottom-left-radius: 10px;
                border-top-left-radius: 10px;
            }

            .SubGrid tbody tr {
                text-align: center;
            }

                .SubGrid tbody tr th:last-child {
                    border-bottom-right-radius: 10px;
                    border-top-right-radius: 10px;
                }

                .SubGrid tbody tr td:first-child {
                    border-bottom-left-radius: 10px;
                    border-top-left-radius: 10px;
                    text-align: left;
                }

                .SubGrid tbody tr td:last-child {
                    border-bottom-right-radius: 10px;
                    border-top-right-radius: 10px;
                }

        .block-flat div table tbody tr td:first-child {
            border-bottom-left-radius: 10px;
            border-top-left-radius: 10px;
        }

        table td:last-child {
            border: none;
        }

        table td {
            border: none;
        }

        table:first-child {
            border-collapse: separate !important;
            border-spacing: 3px;
        }

        .block-flat div table tbody tr td:last-child {
            border-bottom-right-radius: 10px;
            border-top-right-radius: 10px;
        }

        .customLabel {
            background-color: white;
            width: 100%;
            border-bottom-right-radius: 10px;
            border-top-right-radius: 10px;
            border-bottom-left-radius: 10px;
            border-top-left-radius: 10px;
            padding: 10px;
            padding-left: 2%;
        }

        .Title {
            border-left: none;
            font-size: 16px;
            font-weight: bold;
        }
        ul.sq {
            list-style-type:square;
        }
    </style>
</head>
<body>
    <LMS:Menu ID="Menu" runat="server" ActiveItem="learning" />

    <form id="Form1" runat="server">
        <div id="cl-wrapper">
            <div class="container-fluid">
                <div class="page-head" style="padding: 50px 0px 25px 50px;">
                    <h3>My Learning</h3>
                    <p> Adcetris e-modules are designed to provide detailed information on Hodgkin Lymphoma (HL) and systemic Anaplastic Large Cell Lymphoma (sALCL), clinical data on Adcetris and key selling messages. The modules also provide some common questions that may be asked by your customers and would present a logical approach to handling these questions. You will also have access to a navigation panel that you can use to visit/revisit sections of your choice.</p>
                </div>
                <div class="cl-mcont">
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="block-flat" style="margin: 1% 5%; background: rgba(201, 225, 229, 0.5); border-radius: 15px;">
                                <asp:GridView ID="ModuleGrid" GridLines="None" DataKeyNames="Course_Id" ShowHeader="false" runat="server" RowStyle-Height="40" RowStyle-BackColor="#00718e" RowStyle-ForeColor="White" AutoGenerateColumns="false" OnRowDataBound="ModuleGrid_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Width="3%">
                                            <ItemTemplate>
                                                <i style="cursor: pointer" class="fa fa-plus-square"></i>
                                                <asp:Panel ID="subListPanel" runat="server" Style="display: none">
                                                    <%--<div id="descriptionContainer" runat="server" class="customLabel">
                                                    </div>--%>
                                                    <asp:GridView CssClass="SubGrid" DataKeyNames="Sub_Course_Id" ID="InnerGrid" GridLines="None" runat="server" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="MY COURSE" ItemStyle-Width="70%">
                                                                <ItemTemplate>
                                                                    <div style="width: 30px; float: left;">
                                                                        <a id="playerId" runat="server" target="_blank">
                                                                            <img src="img/play.png" style="width: 24px; height: 24px; margin-top:50%;" alt="Play" /></a>
                                                                    </div>
                                                                    <div style="margin-left: 35px">
                                                                       <u style="font-weight:bold"> <%# Eval("Category") %></u>
                                                                        <br />
                                                                        <%--<p style="padding: 4px 4px 4px 0px;"><%# Eval("Description") %></p>--%>
                                                                        <div runat="server" id="description" style="padding:4px 4px 4px 0px"></div>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <%--<asp:BoundField HeaderText="CATEGORY" DataField="Category" ItemStyle-Width="20%" />--%>
                                                            <asp:TemplateField HeaderText="SEAT TIME" ItemStyle-Width="10%">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="seatTime" runat="server" Text='<%# Eval("Duration") + " " + "min(s)"%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="STATUS" DataField="Status" ItemStyle-Width="20%" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:Panel>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Name" ItemStyle-CssClass="Title" />

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <LMS:Footer ID="Footer" runat="server" />
    <LMS:CommonScripts ID="CommonScripts" runat="server" />

</body>
</html>

