<%@ page language="C#" autoeventwireup="true" inherits="Homepage, App_Web_ul3pvwtd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Home Page</title>
    <link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />
    <style type="text/css">
        table td {
            border:none;
        }
    </style>
</head>
<body style="background-color: #EAF5F9;" onload="ShowHome();">
    <LMS:Menu ID="Menu" runat="server" ActiveItem="home" />
    <form id="form1" runat="server">
        <div id="cl-wrapper">
            <div class="container-fluid">
                <div class="page-head" style="padding: 25px 0px 25px 50px; margin-top: 6%;">
                    <h3 id="welcome" runat="server">Home</h3>
                    <h3 id="titles" style="display:none;">Notice board</h3>
                    <p id="texts" style="display:none;">Refer this section for any new updates on the modules</p>
                </div>
                <div class="cl-mcont">
                    <div class="row">
                        <input type="button" id="BackButton" value="< Back" style="display:none;" class="btn btn-primary" onclick="ShowHome();" runat="server" />
                    </div>
                    <div class="row" style="background-color: rgb(201, 225, 229); border-radius: 30px; margin-top: 10%;" runat="server" id="homeTabs">
                        <div class="row dash-cols" style="margin: -5%; margin-left: -25px; margin-right: -25px">
                            <div class="col-sm-6 col-md-6 col-lg-3" style="min-height: 400px; max-height: 450px;">
                                <div class="widget-block">
                                    <div class="white-box">
                                        <div class="fact-data">
                                            <img src="img/learning.jpg" alt="Learning" style="width: 75%; height: 100px;" />
                                        </div>
                                        <div class="fact-data no-padding text-shadow">
                                            <h3></h3>
                                            <p style="font-size: 24px;"><a href="Learning.aspx" style="text-decoration: none; color: black;">MY LEARNING</a></p>
                                        </div>
                                    </div>
                                </div>
                                <div style="border-right: 1px solid #EAF5F9; padding:0% 8% 4% 8%; min-height: 250px; margin-right: -16px;">
                                    <div style=" text-align: justify;">
                                        <p> Adcetris e-modules are designed to provide detailed information on Hodgkin Lymphoma (HL) and systemic Anaplastic Large Cell Lymphoma (sALCL), clinical data on Adcetris and key selling messages. The modules also provide some common questions that may be asked by your customers and would present a logical approach to handling these questions. You will also have access to a navigation panel that you can use to visit/revisit sections of your choice.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6 col-md-6 col-lg-3" style="min-height: 400px; max-height: 450px;">
                                <div class="widget-block">
                                    <div class="white-box">
                                        <div class="fact-data">
                                            <img src="img/score.jpg" alt="Score" style="width: 75%; height: 100px;" />
                                        </div>
                                        <div class="fact-data no-padding text-shadow">
                                            <h3></h3>
                                            <p style="font-size: 24px;"><a href="Scores.aspx" style="text-decoration: none; color: black;">MY SCORE</a></p>
                                        </div>
                                    </div>
                                </div>
                                <div style="border-right: 1px solid #EAF5F9; padding:0% 8% 4% 8%; min-height: 250px; margin-right: -16px;">
                                    <div style="text-align: justify;">
                                        <p>View your learning activity scores and track your progress through the modules as completed, in-progress or not attempted.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3" style="min-height: 400px; max-height: 450px;">
                                <div class="widget-block">
                                    <div class="white-box">
                                        <div class="fact-data">
                                            <img src="img/links.png" alt="Quik Links" style="width: 75%; height: 100px;" />
                                        </div>
                                        <div class="fact-data no-padding text-shadow">
                                            <h3></h3>
                                            <p style="font-size: 24px;"><a href="Newsfeed.aspx" style="text-decoration: none; color: black;">QUICK LINKS</a></p>
                                        </div>
                                    </div>
                                </div>
                                <div style="border-right: 1px solid #EAF5F9; padding:0% 8% 4% 8%; min-height: 250px; margin-right: -16px;">
                                    <div style=" text-align: justify;">
                                        <p>Try quick links to read the latest in content therapy area, current news and updates in Hodgkin Lymphoma (HL) and Anaplastic Large Cell Lymphoma (ALCL)</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3" style="min-height: 400px; max-height: 450px;">
                                <div class="widget-block">
                                    <div class="white-box">
                                        <div class="fact-data">
                                            <img src="img/updates.png" alt="Updates" style="width: 75%; height: 100px;" />
                                        </div>
                                        <div class="fact-data no-padding text-shadow">
                                            <h3></h3>
                                            <p style="font-size: 24px;">
                                                <a href="#" onclick="ShowUpdates();" id="updateLink" style="color: black; text-decoration: none">UPDATES</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div style="border-right: 1px solid #EAF5F9; padding:0% 8% 4% 8%; ">
                                    <div style=" text-align: justify; overflow-y: auto;">
                                        <asp:DataList ID="News" runat="server" BorderStyle="None">
                                            <ItemTemplate>
                                                <p><%# DataBinder.Eval(Container.DataItem,"Content") %></p>
                                                <br />
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div id="newUpdates" runat="server" style="background-color: rgb(201, 225, 229); border-radius: 30px; padding: 2%; display:none;">
                            <asp:DataList ID="top5Updates" runat="server" BorderStyle="None">
                                <ItemTemplate>
                                    <div class="alert alert-info alert-white rounded">
                                        <div class="icon"><i class="fa fa-info-circle"></i></div>
                                        <p><%# DataBinder.Eval(Container.DataItem,"Content") %></p>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
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
