<%@ page language="C#" autoeventwireup="true" inherits="Admin_SupportRequest, App_Web_ggucirnq" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Tech Support</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="../css/demo_page.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery.dataTables_themeroller.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery-ui-1.8.4.custom.css" type="text/css" cache="false" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->
</head>
<body>

    <section class="vbox">
        <LMS:CommonHeader ID="CommonHeader" runat="server" />
        <section style="border-top:1px solid lightgray;">
            <section class="hbox stretch">
                <!-- .aside -->
                <LMS:Menu ID="Menu" runat="server" ActiveItem="support" />
                <!-- /.aside -->
                <section id="content">
                    <section class="vbox">

                        <section class="scrollable padder">
                            <form id="techSupport" runat="server">
                                <div class="m-b-md">
                                    <h3 class="m-b-none">Tech Support</h3>
                                </div>
                                <section class="panel panel-default">
                                    <header class="panel-heading" style="height:50px">
                                        <!--DataTables-->
                                        List of service requests
                                        <div style="float: right">
                                            <a href="#" class="btn btn-sm btn-dark btn-icon" title="Save" onclick="onSupportStatusSave()"><i class="fa fa-floppy-o" style="font-size: 19px"></i></a>
                                            <i class="fa fa-info-sign text-muted" data-toggle="tooltip" data-placement="bottom" data-title="ajax to load the data."></i>
                                        </div>
                                    </header>
                                    <div class="table-responsive">

                                        <asp:GridView ID="SupportRequestList" CssClass="display" Width="100%" AutoGenerateColumns="false" runat="server" OnRowDataBound="SupportRequestList_RowDataBound">
                                            <Columns>
                                                <asp:BoundField HeaderText="Request ID" DataField="Request_ID" />
                                                <asp:BoundField HeaderText="E-Mail ID" DataField="EMail_ID" />
                                                <asp:BoundField HeaderText="Subject" DataField="Subject" />
                                                <asp:BoundField HeaderText="Category" DataField="Issue" />
                                                <asp:BoundField HeaderText="Description" DataField="Description" />
                                                <asp:BoundField HeaderText="Requested Date" DataField="Created_Date" />
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="DDIssueStatus" runat="server" onchange="javascript: OnIssueStatusChange(this);" requestid='<%#Eval ("Request_Id")%>'>
                                                            <asp:ListItem Value="1">In Progress</asp:ListItem>
                                                            <asp:ListItem Value="2">Resolved</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="rowStyle" BorderStyle="None" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <FooterStyle CssClass="footerStyle" />
                                        </asp:GridView>
                                    </div>

                                </section>
                            </form>
                        </section>
                    </section>
                    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
                </section>
            </section>
        </section>
    </section>

    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script type="text/javascript" charset="utf-8">
        $('#SupportRequestList').GridviewFix();
        $(document).ready(function () {
            $('#SupportRequestList').dataTable({
                "bJQueryUI": true,
                "sPaginationType": "full_numbers",
                "aaSorting": [[5, "desc"]],
            }).columnFilter();
        });
    </script>
</body>
</html>
