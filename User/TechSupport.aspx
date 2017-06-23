<%@ page language="C#" autoeventwireup="true" inherits="TechSupport, App_Web_ul3pvwtd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Technical Support</title>
    <link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />
</head>
<body>
    <LMS:Menu ID="Menu" runat="server" ActiveItem="support" />
    <div id="cl-wrapper">
        <div class="container-fluid">
            <div class="page-head" style="padding: 60px 0px 25px 50px;">
                <h2>Tech Support</h2>
            </div>
            <div class="cl-mcont">

                <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <div class="block-flat" style="margin: 1% 15%; background-color:rgba(201, 225, 229, 0.5); border-radius:15px;">
                            <div class="header" style="background: #00718e; color: white;">
                                <h3 class="text-center" style="margin-top: 10px;">Tech Support</h3>
                            </div>
                            <div>
                                <form style="margin-bottom: 0px !important;" class="form-horizontal" id="SupportForm" runat="server">
                                    <div class="content">
                                        <h4 class="title">Ask your queries</h4>
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon">Email</span>
                                                    <asp:TextBox ID="SupportTextEmail" TextMode="Email" runat="server" CssClass="form-control" data-validation-engine="validate[required,custom[email]]">
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon">Subject</span>
                                                    <asp:TextBox ID="SupportTextSubject" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon">Category</span>
                                                    <asp:DropDownList ID="SupportDDCategory" runat="server" CssClass="form-control">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon">Description</span>
                                                    <asp:TextBox ID="SupportTextDescription" TextMode="MultiLine" runat="server" Rows="5" CssClass="form-control" data-validation-engine="validate[required]">
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="foot">
                                        <asp:Label ID="SuccessLabel" runat="server" CssClass="col-xs-10 control-label"></asp:Label>
                                        <asp:Button ID="IssueQuery" style="margin-left:5px; width:14%;" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="IssueQuery_Click" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <LMS:Footer ID="Footer" runat="server" />
    <LMS:CommonScripts ID="CommonScripts" runat="server" />

    <script src="js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#SupportForm").validationEngine();
        });
    </script>
</body>
</html>
