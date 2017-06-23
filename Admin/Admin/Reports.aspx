<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Admin_Reports" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Reports</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->

    <script type="text/javascript" src="../js/chart/RGraph.common.core.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.dynamic.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.tooltips.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.effects.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.bar.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.drawing.rect.js"></script>
    <script type="text/javascript" src="../js/chart/RGraph.common.key.js"></script>

     <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script type="text/javascript">
        // Make canvas responsive
        $(document).ready(function () {
            //New Registrations
            var newReg = $('#newReg');
            var newRegContainer = $(newReg).parent().parent().parent();

            //Distribution of Users by Country
            var byCountry = $('#byCountry');
            var byCountryContainer = $(byCountry).parent().parent().parent();

            //Distribution of Users by City
            var byCity = $('#byCity');
            var byCityContainer = $(byCity).parent().parent().parent();

            // Not Yet Started Course
            var NotStartedCountry = $('#NotStartedCountry');
            var NotStartedCountryContainer = $(NotStartedCountry).parent().parent().parent();

            var NotStartedCity = $('#NotStartedCity');
            var NotStartedCityContainer = $(NotStartedCity).parent().parent().parent();

            // In Progress Course
            var InProgressCountry = $('#InProgressCountry');
            var InProgressCountryContainer = $(InProgressCountry).parent().parent().parent();

            var InProgressCity = $('#InProgressCity');
            var InProgressCityContainer = $(InProgressCity).parent().parent().parent();

            // Completed Course
            var CompletedCountry = $('#CompletedCountry');
            var CompletedCountryContainer = $(CompletedCountry).parent().parent().parent();

            var CompletedCity = $('#CompletedCity');
            var CompletedCityContainer = $(CompletedCity).parent().parent().parent();

            // Best Scorer
            var ScorerinCountry = $('#BestScorerCountry');
            var ScorerinCountryContainer = $(ScorerinCountry).parent().parent().parent();

            var ScorerinCity = $('#BestScorerCity');
            var ScorerinCityContainer = $(ScorerinCity).parent().parent().parent();

            // Course Score
            var CourseScoreCountry = $('#CourseScoreCountry');
            var CourseScoreCountryContainer = $(CourseScoreCountry).parent().parent().parent();

            var CourseScoreCity = $('#CourseScoreCity');
            var CourseScoreCityContainer = $(CourseScoreCity).parent().parent().parent();

            // Seat Report 
            var SeatTimeCountry = $('#SeatTimeCountry');
            var SeatTimeCountryContainer = $(SeatTimeCountry).parent().parent().parent();

            var SeatTimeCity = $('#SeatTimeCity');
            var SeatTimeCityContainer = $(SeatTimeCity).parent().parent().parent();

            $(window).resize(respondCanvas);

            // Get Max-Width
            function respondCanvas() {
                newReg.attr('width', $(newRegContainer).width());
                byCountry.attr('width', $(byCountryContainer).width());
                byCity.attr('width', $(byCityContainer).width());
                NotStartedCountry.attr('width', $(NotStartedCountryContainer).width());
                NotStartedCity.attr('width', $(NotStartedCityContainer).width());
                InProgressCountry.attr('width', $(InProgressCountryContainer).width());
                InProgressCity.attr('width', $(InProgressCityContainer).width());
                CompletedCountry.attr('width', $(CompletedCountryContainer).width());
                CompletedCity.attr('width', $(CompletedCityContainer).width());
                ScorerinCountry.attr('width', $(ScorerinCountryContainer).width());
                ScorerinCity.attr('width', $(ScorerinCityContainer).width());
                CourseScoreCountry.attr('width', $(CourseScoreCountryContainer).width());
                CourseScoreCity.attr('width', $(CourseScoreCityContainer).width());
                SeatTimeCountry.attr('width', $(SeatTimeCountryContainer).width());
                SeatTimeCity.attr('width', $(SeatTimeCityContainer).width());
            }

            //Initial call 
            respondCanvas();

        });
    </script>
    <script type="text/javascript">
        function openPopupModal() {
            $('#reportErrMsg').modal('show');
        }
    </script>
</head>
<body onload="GetReports();">

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
                            <form id="Reports" runat="server">
                                <%--Hidden Fields--%>
                                <input type="hidden" clientmode="static" runat="server" id="NysCity" />
                                <input type="hidden" clientmode="static" runat="server" id="IpCity" />
                                <input type="hidden" clientmode="static" runat="server" id="CCity" />
                                <input type="hidden" clientmode="static" runat="server" id="BstScrCity" />
                                <input type="hidden" clientmode="static" runat="server" id="CrsScrCity" />
                                <input type="hidden" clientmode="static" runat="server" id="SeatCity" />
                                <div class="m-b-md">
                                    <h3 class="m-b-none">Reports</h3>
                                </div>

                                <%--New Registration--%>

                                <div class="row">
                                    <div class="col-md-12">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>New Registrations</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:LinkButton ID="exportNewReg" OnClick="exportExcel_Click" CommandArgument="New_Registration" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="newReg" height="350">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Distribution of Users by Country--%>

                                <div class="row">
                                    <div class="col-md-12">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Distribution of Users by Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:LinkButton ID="exportDistCountry" OnClick="exportExcel_Click" CommandArgument="User_Distribution_By_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="byCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Distribution of Users by City--%>

                                <div class="row">
                                    <div class="col-md-12">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Distribution of Users by Country / City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList" runat="server" onchange="javascript: UsersfromCityReport(this.value);">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportDistCity" OnClick="exportExcel_Click" CommandArgument="User_Distribution_By_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="byCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Not yet Started Courses Country / City--%>

                                <div class="row">
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Not yet started - User-Course Status by Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList1" runat="server" onchange="javascript: OnChangeNotYetStartedInCountry(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportNotYetCountry" OnClick="exportExcel_Click" CommandArgument="Course_Not_Taken_By_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="NotStartedCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Not yet started - User-Course Status by City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CityList" runat="server" onchange="javascript: OnChangeNotYetStartedInCity(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportNotYetCity" OnClick="exportExcel_Click" CommandArgument="Course_Not_Taken_By_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="NotStartedCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--In Progress Courses Country / City--%>

                                <div class="row">
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>In Progress - User-Course Status by Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList2" runat="server" onchange="javascript: OnChangeInProgressInCountry(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportInProgressCountry" OnClick="exportExcel_Click" CommandArgument="Course_In_Progress_By_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="InProgressCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>In Progress - User-Course Status by City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CityList1" runat="server" onchange="javascript: OnChangeInProgressInCity(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportInProgressCity" OnClick="exportExcel_Click" CommandArgument="Course_In_Progress_By_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="InProgressCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Completed Courses Country / City--%>

                                <div class="row">
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Completed - User-Course Status by Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList3" runat="server" onchange="javascript: OnChangeCompletedInCountry(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportCompletedCountry" OnClick="exportExcel_Click" CommandArgument="Course_Completed_By_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="CompletedCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Completed - User-Course Status by City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CityList2" runat="server" onchange="javascript: OnChangeCompletedInCity(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportCompletedCity" OnClick="exportExcel_Click" CommandArgument="Course_Completed_By_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="CompletedCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Best Scorer Report by Country / City--%>

                                <div class="row">
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Best Scorer in Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList4" runat="server" onchange="javascript: OnChangeBestScorerInCountry(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportBestScorerInCountry" OnClick="exportExcel_Click" CommandArgument="Best_Scorer_In_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="BestScorerCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Best Scorer in City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CityList3" runat="server" onchange="javascript: OnChangeBestScorerInCity(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportBestScorerInCity" OnClick="exportExcel_Click" CommandArgument="Best_Scorer_In_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="BestScorerCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Course Score Report by Country / City--%>

                                <div class="row">
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Aggregate Score of the Users as per Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList5" runat="server" onchange="javascript: OnChangeCourseScoreByCountry(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportCourseScoreByCountry" OnClick="exportExcel_Click" CommandArgument="Course_Score_By_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="CourseScoreCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Aggregate Score of the Users as per City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CityList4" runat="server" onchange="javascript: OnChangeCourseScoreByCity(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportCourseScoreByCity" OnClick="exportExcel_Click" CommandArgument="Course_Score_By_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="CourseScoreCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Seat Time Report by Country / City--%>

                                <div class="row">
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Aggregate Seat Time of Each Module as per Country</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CountryList6" runat="server" onchange="javascript: OnChangeSeatTimeByCountry(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportSeatTimeByCountry" OnClick="exportExcel_Click" CommandArgument="Seat_Time_By_Country" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="SeatTimeCountry" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="col-md-6">
                                        <section class="panel panel-default">
                                            <header class="panel-heading font-bold">
                                                <div>Aggregate Seat Time of Each Module as per City</div>
                                                <div style="float: right; margin-top: -20px;">
                                                    <asp:DropDownList ID="CityList5" runat="server" onchange="javascript: OnChangeSeatTimeByCity(this.value);" Style="max-width: 120px;">
                                                    </asp:DropDownList>
                                                    <asp:LinkButton ID="exportSeatTimeByCity" OnClick="exportExcel_Click" CommandArgument="Seat_Time_By_City" runat="server"><img src="../img/export.png" alt="Export" style="margin-top:-5px; margin-left:1em;" /></asp:LinkButton>
                                                </div>
                                            </header>
                                            <div class="panel-body">
                                                <canvas id="SeatTimeCity" height="400">[No canvas support]</canvas>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <%--Report Error Modal--%>
                                <div class="modal fade" id="reportErrMsg" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Export error.</h4>
                                            </div>
                                            <div class="modal-body">
                                                <p style="text-align: justify" id="ErrMessage" runat="server">Report seems to be empty for the selected Country / City.</p>
                                                <div class="modal-footer">
                                                    <a href="#" class="btn btn-default" data-dismiss="modal">OK</a>
                                                </div>
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
</body>
</html>
