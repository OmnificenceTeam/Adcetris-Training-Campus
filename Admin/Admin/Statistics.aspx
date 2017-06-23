<%@ page language="C#" autoeventwireup="true" inherits="Admin_Statistics, App_Web_ggucirnq" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Reports</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="../css/demo_page.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery.dataTables_themeroller.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery-ui-1.8.4.custom.css" type="text/css" cache="false" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->
    <style type="text/css">
        #Summary_filter {
            display:none;
        }

        #UserTranscript_filter {
            display:none;
        }
    </style>
</head>
<body onload="">

    <section class="vbox">
        <LMS:CommonHeader ID="CommonHeader" runat="server" />
        <section style="border-top: 1px solid lightgray;">
            <section class="hbox stretch">
                <!-- .aside -->
                <LMS:Menu ID="Menu" runat="server" ActiveItem="report" />
                <!-- /.aside -->
                <section id="content">
                    <section class="vbox">
                        <section class="scrollable padder">
                            <form id="StatisticsReport" runat="server">
                                  <%--input hidden fields--%>
                                 <asp:HiddenField runat="server" ID="hdnModuleid" />
                                 <asp:HiddenField runat="server" ID="hdnUserid" />
                                <div class="m-b-md">
                                    <h3 class="m-b-none">User activity reports</h3>
                                </div>
                                <asp:Button ID="Back" runat="server" CssClass="btn btn-primary" Text="< Back" UseSubmitBehavior="false" OnClick="Back_Click" Visible="false" Style="margin-bottom: 10px;" />

                                <%--UserList--%>
                                <div id="listOfusers" runat="server">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <section class="panel panel-default">
                                                <header class="panel-heading font-bold">
                                                    <div>List of Users <span style="font-size: 10px; color: gray;">- Click &#39;Name&#39; to view the activity report</span></div>
                                                </header>
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="UserList" runat="server" AutoGenerateColumns="false" CssClass="display" Width="100%" DataKeyNames="User_Id" Style="font-size: 12px;">
                                                            <Columns>
                                                                <asp:BoundField HeaderText="ID" DataField="User_ID" />
                                                                <asp:BoundField HeaderText="Title" DataField="Title" />
                                                                <asp:TemplateField HeaderText="Name">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="GetReports" OnClick="GetReports_Click" runat="server" Text='<%#Eval("First_Name") + " " + Eval("Last_Name") %>' CommandArgument='<%# Eval("User_Id") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Designation" DataField="Designation" />
                                                                <asp:BoundField HeaderText="EMail ID" DataField="EMail_ID" />
                                                            </Columns>
                                                            <RowStyle CssClass="rowStyle" />
                                                            <HeaderStyle CssClass="headerStyle" />
                                                            <FooterStyle CssClass="footerStyle" />
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                </div>

                                <%--Reports--%>
                                <div runat="server" id="reports" visible="false">
                                    <%--User Transcript--%>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <section class="panel panel-default">
                                                <header class="panel-heading font-bold">
                                                    <div>User transcript report</div>
                                                    <div style="float: right; margin-top: -20px;">
                                                        <asp:LinkButton ID="exportTranscript" OnClick="exportExcel_Click" CommandArgument="User_Transcript" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                    </div>
                                                </header>
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="UserTranscript" runat="server" AutoGenerateColumns="false" CssClass="display" Width="100%" Style="font-size: 12px;">
                                                            <Columns>
                                                                <asp:BoundField HeaderText="Module" DataField="CourseName" />
                                                                <asp:BoundField HeaderText="Total marks" DataField="TotalMarks" />
                                                                <asp:BoundField HeaderText="Marks obtained" DataField="MarksObtained" />
                                                                <asp:BoundField HeaderText="Result" DataField="Result" />
                                                            </Columns>
                                                            <RowStyle CssClass="rowStyle" />
                                                            <HeaderStyle CssClass="headerStyle" />
                                                            <FooterStyle CssClass="footerStyle" />
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                    <%--Summary Report--%>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <span style="color:black;font-size:large">Summary report for: </span>
                                            <strong style="font-size:large" id="SummaryUser" runat="server"></strong>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <section class="panel panel-default">
                                                <header class="panel-heading font-bold">
                                                    <div>Learning activity - Summary report <span style="font-size: 10px; color: gray;"> - (Click &#39;Learning Activity&#39; to view the detailed report)</span></div>
                                                    <div style="float: right; margin-top: -20px;">
                                                        <asp:LinkButton ID="exportSummary" OnClick="exportExcel_Click" CommandArgument="Summary_Report" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                    </div>
                                                </header>
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="Summary" runat="server" AutoGenerateColumns="false" CssClass="display" Width="100%" Style="font-size: 12px;" OnRowDataBound="Summary_RowDataBound">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Learning Activity">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="detailedReport" runat="server" CommandArgument='<%# Eval("UserId") + "?" + Eval("CourseId") %>' Text='<%# Eval("LearningActivity") %>' OnClick="detailedReport_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Aggregate Attempts" DataField="AggregateAttempts" />
                                                                <asp:BoundField HeaderText="Best Score" DataField="BestScore" />
                                                                <asp:BoundField HeaderText="Seat Time" DataField="SeatTime" />
                                                                <asp:BoundField HeaderText="Last Attempt" DataField="LastAttempt" />
                                                            </Columns>
                                                            <RowStyle CssClass="rowStyle" />
                                                            <HeaderStyle CssClass="headerStyle" />
                                                            <FooterStyle CssClass="footerStyle" />
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                    <%--Detailed Report--%>
                                 
                                    <div id="detailsDiv" runat="server" visible="false">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <span style="color:black;font-size:large">Module Name: </span>
                                                <strong style="font-size:large" id="moduleName" runat="server"></strong>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <section class="panel panel-default">
                                                    <header class="panel-heading font-bold">
                                                        <div>Learning activity - Detailed report</div>
                                                        <div style="float: right; margin-top: -20px;">
                                                            <asp:LinkButton ID="detailReport" OnClick="exportExcel_Click" CommandArgument="Detailed_Report" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                        </div>
                                                    </header>
                                                    <div class="panel-body">
                                                        <div class="table-responsive">
                                                            <asp:GridView ID="Details" runat="server" AutoGenerateColumns="false" CssClass="display" Width="100%" Style="font-size: 12px;" OnRowDataBound="Details_RowDataBound">
                                                                <Columns>
                                                                    <asp:BoundField HeaderText="Learning Activity" DataField="Activity" />
                                                                    <asp:BoundField HeaderText="Score" DataField="Score" />
                                                                    <asp:BoundField HeaderText="Seat Time" DataField="SeatTime" />
                                                                    <asp:BoundField HeaderText="Last Attempt" DataField="LastAttempt" />
                                                                </Columns>
                                                                <RowStyle CssClass="rowStyle" />
                                                                <HeaderStyle CssClass="headerStyle" />
                                                                <FooterStyle CssClass="footerStyle" />
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </section>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
        $('#UserTranscript').GridviewFix();
        $('#UserList').GridviewFix();
        $('#Summary').GridviewFix();
        $('#Details').GridviewFix();

        $(document).ready(function () {
            $('#UserTranscript').dataTable({
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": false,
                "bSort": false,
            }).columnFilter();
        });

        $(document).ready(function () {
            $('#UserList').dataTable({
                "bJQueryUI": true,
                "sPaginationType": "full_numbers",
                "bSort": false,
            }).columnFilter();
        });

        $(document).ready(function () {
            $('#Summary').dataTable({
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": false,
                "bSort": false,
            }).columnFilter();
        });

        $(document).ready(function () {
            $('#Details').dataTable({
                "bJQueryUI": true,
                "sPaginationType": "full_numbers",
                "bSort": false,
            }).columnFilter();
        });
    </script>

</body>
</html>
