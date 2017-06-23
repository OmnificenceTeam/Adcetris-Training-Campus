<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Welcome to Adcetris</title>
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />
    <link type="text/css" rel="stylesheet" href="css/animation.css" />

    <style type="text/css">
        .bgCover {
            background: url(img/bg.png) no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
    </style>
    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script type="text/javascript" src="js/app/animation.js"></script>
    <script src="js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#Form1").validationEngine();
        });
    </script>

    <script type="text/javascript">
        function openFpModal() {
            $('#resetPwdMsg').modal('show');
        }

        function openActivateModal() {
            $('#activateMsg').modal('show');
        }

        function openSupportModal() {
            $('#supportMsg').modal('show');
        }
    </script>

    <script type="text/javascript">
        function ClickLogin(e) {
            if (e.keyCode === 13) {
                var btn = document.getElementById("<%=Login.ClientID %>");
                btn.click();
            }
        }
    </script>

</head>
<body style="overflow-y: auto; background-color: #C8E1E5;" onload="Loading()">
    <div id="head-nav" class="navbar navbar-default navbar-fixed-top" style="background-color: #C8E1E5;">
        <div class="container-fluid">
            <div class="header-top"></div>
            <div class="header-help">
                <img class="headerleftbg" src="img/headerCorBg.png" />
            </div>
            <div class="navbar-header">
                <a class="navbar-brand" href="#"><span>
                    <img src="img/logo.png" alt="logo" style="margin-top: -8%;" /></span></a>
            </div>
        </div>
    </div>
    <form id="Form1" runat="server" autocomplete="off">
        <%--ASP hidden fields--%>
        <asp:HiddenField ID="StateID" runat="server" Value="" />
        <asp:HiddenField ID="CityID" runat="server" Value="" />

        <div id="cl-wrapper" class="login-container" style="background-color: #C8E1E5;">

            <div class="middle-login" style="width: 661px; height: 373px; left: 42%; top: 38%; background-color: #C8E1E5;">

                <div class="block-flat" style="border: none; box-shadow: none; background-color: #C8E1E5;">
                    <div id="loading">
                        <div style="height: 373px; width: 661px;">
                            <img src="img/loading.gif" style="margin-left: 40%; margin-top: 25%; width: 100px; height: 100px;" />
                        </div>
                    </div>
                    <div id="screen" style="display: none;">
                        <div style="height: 373px; width: 661px;" id="reverse">
                            <img id="imgScreen" src="img/Welcome.png" class="MenuImage" border="0" width="661" height="373" usemap="#animationMenu" alt="" />

                            <map name="animationMenu">
                                <area shape="rect" coords="659,371,661,373" alt="Image Map" title="Image Map" />
                                <area id="welcome" shape="poly" coords="211,251,236,178,261,196,233,257" alt="Welcome" title="Welcome" style="outline: none;" onclick="animateWelcome()" href="#" />
                                <area id="accesscode" shape="poly" coords="244,169,306,103,324,125,267,186" alt="Access Code" title="Access Code" style="outline: none;" onclick="animateAccessCode()" href="#" />
                                <area id="signin" shape="poly" coords="314,93,364,63,377,86,334,115" alt="Sign In" title="Sign In" style="outline: none;" onclick="animateLogin()" href="#" />
                                <area id="support" shape="poly" coords="370,58,449,33,459,54,386,83" alt="Tech Support" title="Tech Support" style="outline: none;" onclick="animateSupport()" href="#" />
                            </map>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--For IE Forgot Password--%>

        <div id="forIEPwd" style="display: none">
            <div class="login-container">
                <div class="middle-login">

                    <div class="block-flat">
                        <div class="header" style="border-bottom: 1px solid lightgray; background: transparent;">
                            <h3 class="text-center" style="background-color: #00718e; font-family: Open Sans">Submit your Email</h3>
                        </div>
                        <div>
                            <div class="content">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <p>Please enter your email address to retrieve your password</p>
                                        <div class="input-group">
                                            <span class="input-group-addon" style="min-width: 20px;"><i class="fa fa-envelope"></i></span>
                                            <asp:TextBox ID="TextFpwd" runat="server" CssClass="form-control" placeholder="Your Email ID" data-validation-engine="validate[required,custom[email]]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="foot">
                                    <p id="notExistIE" style="color: red; display: none;"></p>
                                    <a href="Default.aspx">Click here to Login</a>
                                    <asp:Button ID="FogotPasswordIE" OnClientClick="return IsEmailExist('IE')" OnClick="FogotPasswordIE_Click" runat="server" Style="margin-right: -15px;" CssClass="btn btn-primary" Text="Submit"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--For IE Login Page--%>
        <div id="forIELogin" style="display: none">
            <div class="login-container">
                <div class="middle-login">

                    <div class="block-flat">
                        <div class="header" style="border-bottom: 1px solid lightgray; background: transparent;">
                            <h3 class="text-center">
                                <img class="logo-img" src="img/logo.png" alt="logo" /></h3>
                        </div>
                        <div>
                            <div class="content">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon" style="min-width: 20px;"><i class="fa fa-user"></i></span>
                                            <asp:TextBox ID="LoginIEUsername" runat="server" CssClass="form-control" placeholder="Login Id" data-validation-engine="validate[required,custom[email]]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon" style="min-width: 35px;"><i class="fa fa-lock"></i></span>
                                            <asp:TextBox ID="LoginIEPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password" data-validation-engine="validate[required]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" id="KeepMeIE" runat="server" />
                                                Keep me logged in
                                            </label>
                                            <a href="#" style="float: right;" onclick="ForgotPassword()">Forgot Password ?</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="foot">
                                    <p id="InvalidMsg" runat="server" style="color: red; display: none;">Invalid Credentials</p>
                                    <br />
                                    <a href="#" title="Welcome" onclick="ShowWelcomeMsgIE()" style="margin-right: 1%;">Welcome</a> | 
                                    <a href="#" title="Support" onclick="ShowSupportIE()" style="margin-right: 1%;">Tech Support</a> | 
                                    <a href="#" title="Register" onclick="ShowRegIE()" style="margin-right: 1%;">Access Code</a>
                                    <asp:Button ID="LoginIE" runat="server" Text="Login" OnClientClick="return AuthenticateUser()" Style="margin-right: -15px" OnClick="LoginIE_Click" CssClass="btn btn-primary" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--For IE Registration Page--%>
        <div id="forIEReg" style="display: none">
            <div class="login-container">
                <div class="middle-login" style="width: 650px; left: 42%; top: 40%;">

                    <div class="block-flat">
                        <div class="header" style="border-bottom: 1px solid lightgray; background: transparent;">
                            <h3 class="text-center">
                                <img class="logo-img" src="img/logo.png" alt="logo" /></h3>
                        </div>
                        <div>
                            <div class="content">
                                <div id="accessToken">
                                    <h4 class="title" id="firstTime">Is this your first time here?</h4>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div id="firstTimeContent">
                                                <p style="text-align: justify">Registration on Adcetris training campus requires a valid access code. You will receive an invite (with an access code) from Adcetris Team on your official e-mail address.</p>
                                                <br />
                                                <p style="text-align: justify">If you already have a valid account on the Adcetris training campus, click on the sign-in button (on the landing page) to start the course.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <h4 class="title" id="activate" style="display: none;">Activate your account</h4>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">Code</span>
                                            <asp:TextBox ID="TextAccessTokenIE" runat="server" placeholder="Enter the code and click 'Register' button" CssClass="form-control" data-validation-engine="validate[required]">
                                            </asp:TextBox>
                                        </div>
                                        <div style="width: 100%">
                                            <div style="float: left; width: 20%;">
                                                <a href="Default.aspx" style="width: 100%; margin: 0px;" class="btn btn-primary" id="redirect">&lt; Back</a>
                                            </div>
                                            <div style="margin-left: 22%;">
                                                <input type="button" style="margin: 0px;" class="btn btn-primary" value="Register" id="getAccessDetails" onclick="GetEmailIDIE();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="registerDetails" style="display: none">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Title</span>
                                                <asp:DropDownList ID="DDTextTitleIE" runat="server" CssClass="form-control" data-validation-engine="validate[required] radio">
                                                    <asp:ListItem Text="Dr." Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Mr." Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Mrs." Value="2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">First Name</span>
                                                <asp:TextBox ID="TextFirstNameIE" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Last Name</span>
                                                <asp:TextBox ID="TextLastNameIE" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Designation</span>
                                                <asp:DropDownList ID="DDDesignationIE" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Address</span>
                                                <asp:TextBox ID="TextAddressIE" TextMode="MultiLine" runat="server" Rows="3" CssClass="form-control">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Country</span>
                                                <asp:DropDownList ID="DDCountryIE" runat="server" CssClass="form-control" data-validation-engine="validate[required] radio" onchange="PopulateStatesOfCountryIE(this.value);">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">State / Region</span>
                                                <asp:DropDownList ID="DDRegionIE" runat="server" CssClass="form-control" onchange="PopulateCityOfStatesIE(this);">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
<p style="margin-top: -15px;
font-style: italic;
margin-left: 95px;">In case you don’t find your state/region in the list, please select others</p>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">City</span>
                                                <asp:DropDownList ID="DDCityIE" runat="server" data-validation-engine="validate[required] radio" CssClass="form-control" onchange="SetCityID('IE')">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
<p style="margin-top: -15px;
font-style: italic;
margin-left: 95px;">In case you don’t find your city name in the list, please select the nearest city</p>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">EMail ID</span>
                                                <asp:TextBox ID="TextEMailIDIE" runat="server" CssClass="form-control">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Username</span>
                                                <asp:TextBox ID="TextNameIE" runat="server" CssClass="form-control" data-validation-engine="validate[required,custom[email],funcCall[IsUsernameExist]]">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Password</span>
                                                <asp:TextBox ID="TextPasswordIE" TextMode="Password" runat="server" CssClass="form-control" data-validation-engine="validate[required,minSize[8]]">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">Repeat Password</span>
                                                <asp:TextBox ID="TextRePasswordIE" TextMode="Password" runat="server" CssClass="form-control col-sm-10" data-validation-engine="validate[required,equals[TextPasswordIE]]">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="foot">
                                        <%--<a href="Default.aspx">Click here to Login</a>--%>
                                        <asp:Label ID="SuccessLabel" Visible="false" runat="server" CssClass="col-xs-10 control-label"></asp:Label>
                                        <asp:Label ID="registerMessageIE" runat="server" Text="Mail ID already exists." Style="display: none; color: red"></asp:Label>
                                        <asp:Button CssClass="btn btn-primary" ID="RegIE" OnClientClick="return CheckMailAndCodeIE();" OnClick="RegIE_Click" Text="Activate" Style="margin-right: -15px" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p style="text-align: justify; color: white; display: none;" id="regMsg">
                        <b style="color: brown;">Takeda employees:</b> Your Campus Username is your official email address. If your email address is jsmith@takeda.com, your Campus Username = jsmith@takeda.com. Using jsmith@yahoo.com will cause an error
                    </p>
                </div>
            </div>
        </div>

        <%--For IE Tech Support --%>
        <div id="forIETech" style="display: none">
            <div class="login-container">
                <div class="middle-login" style="width: 650px; left: 42%; top: 40%;">

                    <div class="block-flat">
                        <div class="header" style="border-bottom: 1px solid lightgray; background: transparent;">
                            <h3 class="text-center" style="background-color: #00718e; font-family: Open Sans">Tech Support</h3>
                        </div>
                        <div>
                            <div class="content">
                                <h4 class="title">Ask your queries</h4>

                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">Email</span>
                                            <asp:TextBox ID="SupportTextEmailIE" TextMode="Email" runat="server" CssClass="form-control" data-validation-engine="validate[required,custom[email]]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">Subject</span>
                                            <asp:TextBox ID="SupportTextSubjectIE" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">Category</span>
                                            <asp:DropDownList ID="SupportDDCategoryIE" runat="server" CssClass="form-control">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">Description</span>
                                            <asp:TextBox ID="SupportTextDescriptionIE" TextMode="MultiLine" runat="server" Rows="5" CssClass="form-control" data-validation-engine="validate[required]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="foot">
                                    <div style="width: 100%">
                                        <div style="float: left; width: 20%;">
                                            <a href="Default.aspx" style="width: 100%; margin: 0px;" class="btn btn-primary" id="A1">&lt; Back</a>
                                        </div>
                                        <div style="margin-left: 22%;">
                                            <asp:Button ID="IssueQueryIE" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="IssueQueryIE_Click" />
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Login Form--%>
        <div class="modal fade" id="login-form" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Login</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-addon" style="min-width: 20px;"><i class="fa fa-user"></i></span>
                                    <asp:TextBox ID="LoginUsername" runat="server" CssClass="form-control" placeholder="Login Id" data-validation-engine="validate[required]">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-addon" style="min-width: 34px;"><i class="fa fa-lock"></i></span>
                                    <asp:TextBox ID="LoginPassword" runat="server" CssClass="form-control" onkeydown="ClickLogin(event)" placeholder="Password" TextMode="Password" data-validation-engine="validate[required]">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" id="KeepMe" runat="server" />
                                        Keep me logged in
                                    </label>
                                    <a href="#reset-pwd" data-dismiss="modal" data-toggle="modal" style="float: right;">Forgot Password ?</a>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Label ID="loginMsg" Text="Invalid Credentials" ForeColor="Red" runat="server"></asp:Label>
                            <br />
                            <a href="#register-form" data-dismiss="modal" data-toggle="modal" title="Register">Access Code</a>
                            <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                            <asp:Button ID="Login" runat="server" Text="Login" OnClientClick="return AuthenticateUser()" OnClick="Login_Click" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Forgot Password Form--%>
        <div class="modal fade" id="reset-pwd" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Submit your Email</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <p>Please enter your email address to retrieve your password</p>
                                <div class="input-group">
                                    <span class="input-group-addon" style="min-width: 20px;"><i class="fa fa-envelope"></i></span>
                                    <asp:TextBox ID="TextEmail" runat="server" CssClass="form-control" placeholder="Your Email ID" data-validation-engine="validate[required,custom[email]]">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <p id="notExist" style="color: red; display: none;"></p>
                            <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                            <asp:Button ID="SubmitEmailID" OnClientClick="return IsEmailExist('ch')" OnClick="SubmitEmailID_Click" runat="server" CssClass="btn btn-primary" Text="Submit"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Welcome Form--%>
        <div class="modal fade" id="welcome-form" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Welcome to Adcetris Training Campus!</h4>
                    </div>
                    <div class="modal-body">
                        <p style="text-align: justify">This training platform is intended to be a comprehensive portal for all the essential self-training information on Adcetris. The website features interactive modules which are aimed at enhancing your knowledge related to Adcetris in Hodgkin Lymphoma (HL) and Anaplastic Large Cell Lymphoma (ALCL). The site also includes useful links for latest updates from key congresses.</p>
                        <br />
                        <p style="text-align: justify">Have a happy learning !</p>
                        <div class="modal-footer">
                            <a href="#" class="btn btn-default" data-dismiss="modal">OK</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Registration Form--%>
        <div class="modal fade" id="register-form" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" id="modalTitle">Is this your first time here?</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div id="accessContent">
                                    <p style="text-align: justify">Registration on Adcetris training campus requires a valid access code. You will receive an invite (with an access code) from Adcetris Team on your official e-mail address.</p>
                                    <br />
                                    <p style="text-align: justify">If you already have a valid account on the Adcetris training campus, click on the sign-in button (on the landing page) to start the course.</p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div id="registerContent">
                                    <p style="text-align: justify"><b style="color: brown">Takeda employees:</b> Your Campus Username is your official email address. If your email address is jsmith@takeda.com, your Campus Username = jsmith@takeda.com. Using jsmith@yahoo.com will cause an error </p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-addon">Code</span>
                                    <asp:TextBox ID="TextAccessToken" placeholder="Enter the code and click 'Register' button" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                    </asp:TextBox>
                                </div>
                                <input type="button" style="margin: 0px" class="btn btn-primary" value="Register" id="getDetails" onclick="GetEmailID();" />
                            </div>
                        </div>
                        <div id="regDetails">
                            <div class="form-group" id="UserTitle">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Title</span>
                                        <asp:DropDownList ID="DDTextTitle" runat="server" CssClass="form-control" data-validation-engine="validate[required] radio">
                                            <asp:ListItem Text="Dr." Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Mr." Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Mrs." Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserFName">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">First Name</span>
                                        <asp:TextBox ID="TextFirstName" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserLName">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Last Name</span>
                                        <asp:TextBox ID="TextLastName" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserDesignation">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Designation</span>
                                        <asp:DropDownList ID="DDDesignation" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserAddress">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Address</span>
                                        <asp:TextBox ID="TextAddress" TextMode="MultiLine" runat="server" Rows="3" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserCountry">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Country</span>
                                        <asp:DropDownList ID="DDCountry" runat="server" CssClass="form-control" data-validation-engine="validate[required] radio" onchange="PopulateStatesOfCountry(this.value);">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserRegion">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">State / Region</span>
                                        <asp:DropDownList ID="DDRegion" runat="server" CssClass="form-control"  onchange="PopulateCityOfStates(this);">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
<p style="margin-top: -15px;
font-style: italic;
margin-left: 95px;">In case you don’t find your state/region in the list, please select others</p>
                            <div class="form-group" id="UserCity">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">City</span>
                                        <asp:DropDownList ID="DDCity" runat="server" data-validation-engine="validate[required] radio" CssClass="form-control" onchange="SetCityID('other')">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <p style="margin-top: -15px;
font-style: italic;
margin-left: 95px;">In case you don’t find your city name in the list, please select the nearest city</p>
                            <div class="form-group" id="UserMail">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">EMail ID</span>
                                        <asp:TextBox ID="TextEMailID" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserName">
                                <%--<div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Username</span>
                                        <asp:TextBox ID="TextName" runat="server" CssClass="form-control" data-validation-engine="validate[required,funcCall[IsUsernameExist]]">
                                        </asp:TextBox>
                                    </div>
                                </div>--%>
                            </div>
                            <div class="form-group" id="UserPwd">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Password</span>
                                        <asp:TextBox ID="TextPassword" TextMode="Password" runat="server" CssClass="form-control" data-validation-engine="validate[required,minSize[8]]">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="UserRePwd">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Repeat Password</span>
                                        <asp:TextBox ID="TextRepeatPassword" TextMode="Password" runat="server" CssClass="form-control col-sm-10" data-validation-engine="validate[required,equals[TextPassword]]">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" id="UserRegButton">
                                <asp:Label ID="registerMessage" runat="server" Text="Mail ID already exists." Style="display: none; color: red"></asp:Label>
                                <asp:Button CssClass="btn btn-primary" ID="RegisterUser" OnClientClick="return CheckMailAndCode();" OnClick="RegisterUser_Click" Text="Activate" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Tech Support Form--%>
        <div class="modal fade" id="tech-support">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Ask your queries</h4>
                    </div>
                    <div class="modal-body">
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
                        <div class="modal-footer">
                            <asp:Button ID="IssueQuery" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="IssueQuery_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <%--Messages--%>

        <%--Reset Password Message--%>
        <div class="modal fade" id="resetPwdMsg" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Forgot Password !</h4>
                    </div>
                    <div class="modal-body">
                        <p style="text-align: justify" id="FpMessage" runat="server">Your password has been sent to your registered e-mail address. If you did not receive email in your inbox, please check your Spam/Junk folder.</p>
                        <br />
                        <p style="text-align: justify" id="loginInto" runat="server">Login to <a href="Default.aspx">Adcetris Training Campus</a></p>
                        <p style="text-align: justify">For any support contact us at: techsupport@adcetristrainingcampus.com</p>
                        <div class="modal-footer">
                            <a href="#" class="btn btn-default" data-dismiss="modal">OK</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Activate Message--%>
        <div class="modal fade" id="activateMsg" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Account activation</h4>
                    </div>
                    <div class="modal-body">
                        <p style="text-align: justify" id="AcMessage" runat="server">Your account has been activated successfully</p>
                        <div class="modal-footer">
                            <a href="#" class="btn btn-default" data-dismiss="modal">OK</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Support Message--%>
        <div class="modal fade" id="supportMsg" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Tech Support</h4>
                    </div>
                    <div class="modal-body">
                        <p style="text-align: justify" id="supMessage" runat="server">Your query has been submitted</p>
                        <div class="modal-footer">
                            <a href="#" class="btn btn-default" data-dismiss="modal">OK</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <LMS:Footer ID="Footer" runat="server" />
    </form>
    <script type="text/javascript">
        var isIpad = /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());

        if (isIpad)
            window.location.href = "download.aspx"
    </script>
</body>
</html>

