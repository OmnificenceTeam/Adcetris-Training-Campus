<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register your account</title>
    <link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" />

    <LMS:CommonStyles ID="CommonStyles" runat="server" />

</head>
<body style="background-color: transparent;" onload="hideDetails();">
    <div id="cl-wrapper" class="login-container">

        <div class="middle-login" style="width: 850px; left: 28%; top: 30%;">

            <div class="block-flat">
                <div class="header" style="border-bottom: 1px solid lightgray; background: transparent;">
                    <h3 class="text-center">
                        <img class="logo-img" src="img/logo.png" alt="logo" /></h3>
                </div>
                <div>
                    <form style="margin-bottom: 0px !important;" class="form-horizontal" id="RegisterForm" runat="server" autocomplete="off">
                         <%--ASP hidden fields--%>
                        <asp:HiddenField ID="StateID" runat="server" Value="" />
                        <asp:HiddenField ID="CityID" runat="server" Value="" />
                        <div class="content">
                            <h4 class="title" id="activate" style="display: none;">Activate your account</h4>
                            <h4 class="title" id="firstTime">Is this your first time here?</h4>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <div id="firstTimeContent">
                                        <p style="text-align: justify">Registration on Adcetris training campus requires a valid access code. You will receive an invite (with an access code) from Adcetris Team on your official e-mail address. </p>
                                        <br />
                                        <p style="text-align: justify">If you already have a valid account on the Adcetris training campus, click on the sign-in button (on the landing page) to start the course.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Code</span>
                                        <asp:TextBox ID="TextAccessToken" runat="server" placeholder="Enter the code and click 'Register' button" CssClass="form-control" data-validation-engine="validate[required]">
                                        </asp:TextBox>
                                    </div>
                                    <input type="button" style="margin: 0px" class="btn btn-primary" value="Get my details" id="getAccessDetails" onclick="GetMailId();" />
                                </div>
                            </div>
                            <div id="regDetails" style="display: none">
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
                                            <asp:DropDownList ID="DDRegion" runat="server" CssClass="form-control" onchange="PopulateCityOfStates(this);">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
<p style="margin-top: -15px;
font-style: italic;
margin-left: 130px;">In case you don’t find your state/region in the list, please select others</p>

                                  <div class="form-group" id="UserCity">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">City</span>
                                            <asp:DropDownList ID="DDCity" runat="server" CssClass="form-control" data-validation-engine="validate[required] radio" onchange="SetCityID()">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                      <p style="margin-top: -15px;
font-style: italic;
margin-left: 130px;">In case you don’t find your city name in the list, please select the nearest city</p>
                        
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
                                            <asp:TextBox ID="TextName" runat="server" CssClass="form-control" data-validation-engine="validate[required]">
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
                            </div>
                        </div>
                        <div class="foot" id="UserRegButton" style="display: none">
                            <asp:Label ID="registerMessage" runat="server" Text="Mail ID already exists." style="display:none; color:red"></asp:Label>
                            <asp:Button CssClass="btn btn-primary" ID="RegisterUser" OnClientClick="return CheckMailAndCode();" OnClick="RegisterUser_Click" Text="Activate" runat="server" />
                        </div>
                        <div class="foot">
                            <asp:Label ID="SuccessLabel" Visible="false" runat="server" CssClass="col-xs-10 control-label"></asp:Label>
                            <br />
                            <a href="Default.aspx" runat="server" visible="false" id="loginLink">Click here to Login</a>
                        </div>
                    </form>
                </div>
            </div>
            <p style="text-align: justify; color: black;" id="regMsg">
                <b style="color: brown;">Takeda employees:</b> Your Campus Username is your official email address. If your email address is jsmith@takeda.com, your Campus Username = jsmith@takeda.com. Using jsmith@yahoo.com will cause an error
            </p>
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
    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script src="js/app/registration.js" type="text/javascript"></script>
    <script src="js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#RegisterForm").validationEngine();
        });

        function openActivateModal() {
            $('#activateMsg').modal('show');
        }
    </script>



</body>
</html>
