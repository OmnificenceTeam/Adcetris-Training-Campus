<%@ page language="C#" autoeventwireup="true" inherits="Admin_Admin, App_Web_ggucirnq" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Admin Console</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="../css/demo_page.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery.dataTables_themeroller.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery-ui-1.8.4.custom.css" type="text/css" cache="false" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->

    <script type="text/javascript" src="../js/chart/RGraph.common.core.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.dynamic.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.tooltips.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.effects.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.line.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.drawing.rect.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.key.js"></script>
    <style type="text/css">
        #Aggregate_filter {
            display:none;
        }
    </style>
</head>
<body onload="DashboardGraph();">

    <section class="vbox">
        <LMS:CommonHeader ID="CommonHeader" runat="server" />
        <section style="border-top: 1px solid lightgray;">
            <section class="hbox stretch">
                <!-- .aside -->
                <LMS:Menu ID="Menu" runat="server" ActiveItem="admin" />
                <!-- /.aside -->
                <section id="content">
                    <section class="vbox">

                        <section class="scrollable padder">
                            <ul class="breadcrumb no-border no-radius b-b b-light pull-in">
                                <li><a href="#"><i class="fa fa-bar-chart-o"></i>&nbsp;Aggregate Statistics</a></li>
                            </ul>
                            <section class="panel panel-default">
                                <div class="row m-l-none m-r-none bg-light lter">
                                    <div class="col-sm-6 col-md-3 padder-v b-r b-light">
                                        <span class="fa-stack fa-2x pull-left m-r-sm">
                                            <i class="fa fa-circle fa-stack-2x text-info"></i>
                                            <i class="fa fa-users fa-stack-1x text-white"></i>
                                        </span>
                                        <a class="clear" href="#">
                                            <span class="h3 block m-t-xs">
                                                <strong id="totalTrainees" runat="server">5</strong>
                                            </span>
                                            <small class="text-muted text-uc">Trainees</small>
                                        </a>
                                    </div>
                                    <div class="col-sm-6 col-md-2 padder-v b-r b-light">
                                        <span class="fa-stack fa-2x pull-left m-r-sm">
                                            <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                            <i class="fa fa-book fa-stack-1x text-white"></i>
                                        </span>
                                        <a class="clear" href="#">
                                            <span class="h3 block m-t-xs">
                                                <strong id="totalcourse" runat="server">5</strong>
                                            </span>
                                            <small class="text-muted text-uc">Courses registered</small>
                                        </a>
                                    </div>

                                    <div class="col-sm-6 col-md-2 padder-v b-r b-light">
                                        <span class="fa-stack fa-2x pull-left m-r-sm">
                                            <i class="fa fa-circle fa-stack-2x text-warning"></i>
                                            <i class="fa fa-spinner fa-stack-1x text-white"></i>
                                        </span>
                                        <a class="clear" href="#">
                                            <span class="h3 block m-t-xs">
                                                <strong id="inprogress" runat="server">3</strong>
                                            </span>
                                            <small class="text-muted text-uc">Courses In progress</small>
                                        </a>
                                    </div>
                                    <div class="col-sm-6 col-md-2 padder-v b-r b-light">
                                        <span class="fa-stack fa-2x pull-left m-r-sm">
                                            <i class="fa fa-circle fa-stack-2x text-success"></i>
                                            <i class="fa fa-check-square fa-stack-1x text-white"></i>
                                        </span>
                                        <a class="clear" href="#">
                                            <span class="h3 block m-t-xs">
                                                <strong id="completed" runat="server">2</strong>
                                            </span>
                                            <small class="text-muted text-uc">Courses completed</small>
                                        </a>
                                    </div>
                                    <div class="col-sm-6 col-md-3 padder-v b-r b-light">
                                        <span class="fa-stack fa-2x pull-left m-r-sm">
                                            <i class="fa fa-circle fa-stack-2x text-muted"></i>
                                            <i class="fa fa-lock fa-stack-1x text-white"></i>
                                        </span>
                                        <a class="clear" href="#">
                                            <span class="h3 block m-t-xs">
                                                <strong id="notstarted" runat="server">5</strong>
                                            </span>
                                            <small class="text-muted text-uc">Courses Not yet started</small>
                                        </a>
                                    </div>
                                </div>
                            </section>
                            <%-- Course Completed by Last Month --%>
                            <form runat="server" id="DashBoardReport">
                                <div class="row">
                                    <div class="col-md-12">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Completed Courses</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:LinkButton ID="exportCompleted" OnClick="exportCompleted_Click" CommandArgument="Course_Completion_LastMonth" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="CourseCompleted" height="500">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Aggregate Statistics--%>

                                <div id="aggregateReport" runat="server">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <section class="panel panel-default">
                                                <header class="panel-heading font-bold">
                                                    <div>Aggregate Statistics</div>
                                                    <div style="float: right; margin-top: -20px;">
                                                        <asp:LinkButton ID="exportStatistics" OnClick="exportCompleted_Click" CommandArgument="Aggregate_Statistics" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                    </div>
                                                </header>
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="Aggregate" runat="server" AutoGenerateColumns="false" CssClass="display" Width="100%" Style="font-size: 12px;">
                                                            <Columns>
                                                                <asp:BoundField HeaderText="Module Name" DataField="CourseName" />
                                                                <asp:BoundField HeaderText="Not Attempted" DataField="NotAttempted" />
                                                                <asp:BoundField HeaderText="Incomplete" DataField="Incomplete" />
                                                                <asp:BoundField HeaderText="Completed" DataField="Completed" />
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
                            </form>
                        </section>
                    </section>
                    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
                </section>
            </section>
        </section>
    </section>
    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script type="text/javascript">
        // Make canvas responsive
        $(document).ready(function () {
            //New Registrations
            var CourseCompleted = $('#CourseCompleted');
            var CourseCompletedContainer = $(CourseCompleted).parent().parent().parent();

            $(window).resize(respondCanvas);

            // Get Max-Width
            function respondCanvas() {
                CourseCompleted.attr('width', $(CourseCompletedContainer).width());
            }

            //Initial call 
            respondCanvas();

        });
    </script>
    <script type="text/javascript">
        $('#Aggregate').GridviewFix();

        $(document).ready(function () {
            $('#Aggregate').dataTable({
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": false,
                "bSort": false,
            }).columnFilter();
        });
    </script>
</body>
</html>
