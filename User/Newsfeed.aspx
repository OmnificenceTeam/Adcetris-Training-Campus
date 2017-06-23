﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Newsfeed.aspx.cs" Inherits="Newsfeed" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>News Feed</title>
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />

    <style type="text/css">
        a {
            text-decoration: none;
        }

        .tab-container > .nav > li {
            background-color: transparent;
        }
    </style>

    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script src="http://cdnjs.cloudflare.com/ajax/libs/bootbox.js/4.0.0/bootbox.min.js"></script>
    <script type="text/javascript">

        function loadXml() {

            var data = "";
            var name = "";

            for (var i = 1; i < 5; i++) {

                if (i == 1) {
                    data = $('#data1').val();
                }
                else if (i == 2) {
                    data = $('#data2').val();
                }
                else if (i == 3) {
                    data = $('#data3').val();
                }
                else if (i == 4) {
                    data = $('#data4').val();
                }
                name = ".tab" + i + "Contents";

                var parser = new DOMParser();
                data = parser.parseFromString(data, "text/xml");

                LoadData(name, data);
            }
        }

        function LoadData(name, data) {

            $(data).find('item').each(function () {

                var $item = $(this);
                var title = $item.find('title').text();
                var link = $item.find('link').text();
                var description = $item.find('description').text();
                var pubDate = $item.find('pubDate').text();

                var html = '<div class="alert alert-info alert-white rounded"><div class="icon"><i class="fa fa-info-circle"></i></div>';
                html += '<p style="color:blue; cursor:pointer;" id= ' + link + ' onclick="ConfirmationDialog(this);" >' + title + '</p>';
                html += '<p> ' + description + '</p>';
                html += '<p style=color:gray>' + pubDate + '</p>';
                html += '</div>';

                $(name).append($(html));
            });
        }

        function ConfirmationDialog(link) {
            bootbox.confirm({
                title: 'The page at adcetristrainingcampus says:',
                message: 'The information you are about to access was not prepared by Takeda and may not comply with your country regulations. Takeda do not review or control the content of these websites, nor are they responsible for accuracy, practices or standards of any of these sources. Do you wish to continue ?',
                buttons: {
                    'cancel': {
                        label: 'No',
                        className: 'btn btn-default'
                    },
                    'confirm': {
                        label: 'Yes',
                        className: 'btn btn-primary'
                    }
                },
                callback: function (result) {
                    if (result) {
                        var params = 'width=' + screen.width;
                        params += ', height=' + screen.height;
                        params += ', top=0, left=0'
                        params += ', status=no'
                        params += ', resizable=yes';

                        window.open(link.id, 'newWindow', params);
                    }
                }
            });
        }

    </script>

</head>
<body onload="loadXml()">
    <LMS:Menu ID="Menu" runat="server" ActiveItem="home" />

    <form id="Form1" runat="server">
        <%--Hidden Fields--%>
        <input type="hidden" runat="server" id="data1" />
        <input type="hidden" runat="server" id="data2" />
        <input type="hidden" runat="server" id="data3" />
        <input type="hidden" runat="server" id="data4" />

        <div id="cl-wrapper">
            <div class="container-fluid">
                <div class="page-head" style="padding: 50px 0px 25px 50px;">
                    <h3>Quick Links</h3>
                    <p>Try quick links to read the latest in content therapy area, current news and updates in Hodgkin Lymphoma (HL) and Anaplastic Large Cell Lymphoma (ALCL)</p>
                </div>
                <div class="cl-mcont">
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="block-flat" style="margin: 1%; background: rgba(201, 225, 229, 0.5); border-radius: 15px;">
                                <div class="tab-container">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a href="#medlineplus" data-toggle="tab">MedlinePlus</a></li>
                                        <li style="max-width: 255px;"><a href="#ash" data-toggle="tab">American Society of Hematology (ASH)</a></li>
                                        <li style="max-width: 160px;"><a href="#asco" data-toggle="tab">ASCO News Release</a></li>
                                        <li style="max-width: 160px;"><a href="#esmo" data-toggle="tab">ESMO News Release</a></li>
                                        <li style="max-width: 60px;"><a href="#other" data-toggle="tab">Others</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active cont" id="medlineplus">
                                            <div class="row">
                                                <div class="tab1Contents" style="padding: 1%;" runat="server" id="MedPlus">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane cont" id="ash">
                                            <div class="row">
                                                <div class="tab2Contents" style="padding: 1%;" runat="server" id="ASOH">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="asco">
                                            <div class="row">
                                                <div class="tab3Contents" style="padding: 1%;" runat="server" id="ASC">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="esmo">
                                            <div class="row">
                                                <div class="tab4Contents" style="padding: 1%;" runat="server" id="ESM">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="other">
                                            <div class="row">
                                                <div class="tab5Contents" style="padding: 1%;">
                                                    <div class="alert alert-info alert-white rounded">
                                                        <div class="icon">
                                                            <i class="fa fa-info-circle"></i>
                                                        </div>
                                                        <p style="color: blue; cursor: pointer;" id="http://www.ehaweb.org/" onclick="ConfirmationDialog(this);">European Hematology Association (EHA)</p>
                                                    </div>
                                                    <br />
                                                    <div class="alert alert-info alert-white rounded">
                                                        <div class="icon">
                                                            <i class="fa fa-info-circle"></i>
                                                        </div>
                                                        <p style="color: blue; cursor: pointer;" id="https://www.ebmt.org/Contents/Pages/Default.aspx" onclick="ConfirmationDialog(this);">European Bone Marrow Transplantation (EBMT)</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <LMS:Footer ID="Footer" runat="server" />
</body>
</html>
