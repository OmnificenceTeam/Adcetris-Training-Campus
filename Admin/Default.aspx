<%@ page language="C#" autoeventwireup="true" inherits="_Default, App_Web_x2nyizk0" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="bg-dark">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>ADCETRIS - Login</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="css/app.v2.css" type="text/css" />
    <link rel="stylesheet" href="css/font.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" />

    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->
</head>
<body onload="HideMail();">
    <section id="content" class="m-t-lg wrapper-md animated fadeInUp">
        <div class="container aside-xxl">
            <section class="panel panel-default bg-white m-t-lg">
                <header class="panel-heading text-center">
                    <img src="img/logo.png" />
                </header>
                <form id="loginForm" runat="server" class="panel-body wrapper-lg">
                    <div id="login">
                        <asp:Label ID="resetMsg" runat="server" Visible="false"></asp:Label>
                        <div class="form-group">
                            <label class="control-label">Login Id</label>
                            <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="Login Id" ID="TextUserName" data-validation-engine="validate[required]"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Password</label>
                            <asp:TextBox runat="server" CssClass="form-control input-lg" TextMode="Password" placeholder="Password" ID="TextPassword" data-validation-engine="validate[required]"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label Text="Invalid Credentials" runat="server" ForeColor="Red" Visible="false" ID="loginMsg"></asp:Label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" id="KeepMe" runat="server" />
                                Keep me logged in
                            </label>
                        </div>
                        <a href="#" onclick="ShowMail();" class="pull-right m-t-xs"><small>Forgot Password ?</small></a>
                        <asp:Button ID="Login" CssClass="btn btn-primary" OnClick="Login_Click" Text="Login" runat="server" />
                    </div>
                    <div id="forgot" style="display:none">
                        <div class="form-group">
                            <label class="control-label">Your Email ID</label>
                            <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="Your Email ID" ID="TextEmail" data-validation-engine="validate[required,custom[email]]"></asp:TextBox>
                        </div>
                        <asp:Button ID="SubmitEmailID" OnClick="SubmitEmailID_Click" runat="server" CssClass="btn btn-primary" Text="Submit"></asp:Button>
                    </div>

                </form>
            </section>
        </div>
    </section>
    <!-- footer -->
    <footer id="footer">
        <div class="text-center padder">
            <p><small>Adcetris &copy; 2014</small> </p>
        </div>
    </footer>
    <!-- / footer -->
    <script src="js/app.v2.js"></script>
    <script type="text/javascript" src="js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="js/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="js/jquery.validationEngine-en.js"></script>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#loginForm").validationEngine();
        });

        function ShowMail() {
            document.getElementById('login').style.display = "none";
            document.getElementById('forgot').style.display = "block";
        }

        function HideMail() {
            document.getElementById('forgot').style.display = "none";
        }
    </script>
</body>
</html>
