<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Scores.aspx.cs" Inherits="Scores" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>My Score</title>
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />
    <style type="text/css">
        th {
            border-right: 1px solid white;
            text-align: center;
        }

        table tr {
            background-color: white;
            text-align: center;
        }

            table tr td:first-child {
                text-align: left;
            }
    </style>
</head>
<body style="overflow-x:hidden;">
    <LMS:Menu ID="Menu" runat="server" ActiveItem="score" />

    <form runat="server">
        <div id="cl-wrapper">
            <div class="container-fluid">
                <div class="page-head" style="padding: 50px 0px 25px 50px;">
                    <h3>Have I Completed My Course ?</h3>
                    <p>View your learning activity scores and track your progress through the modules as completed, in-progress or not attempted.</p>
                </div>
                <div class="cl-mcont">
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="block-flat" style="margin: 1% 5%; background-color: rgba(201, 225, 229, 0.5); border-radius: 15px;">
                                <asp:GridView ID="MyScoreGrid" GridLines="None" runat="server" HeaderStyle-Height="40" HeaderStyle-BackColor="#00718e" HeaderStyle-ForeColor="White" AutoGenerateColumns="false" OnRowDataBound="MyScoreGrid_RowDataBound">
                                    <Columns>
                                        <asp:BoundField HeaderText="Module" DataField="Module" />
                                        <asp:BoundField HeaderText="Category" DataField="Category" />
                                        <asp:TemplateField HeaderText="Score">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="PercentLbl" Text='<%# Eval("Percentage").ToString() + " %" %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Status" DataField="Status" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row" style="margin-bottom:5%;">
                        <div class="col-sm-12 col-md-12" style="margin:0px 5%;">
                            <p>
                                <strong>Note: </strong>75 % is a pass score for all courses.
                            </p>
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
