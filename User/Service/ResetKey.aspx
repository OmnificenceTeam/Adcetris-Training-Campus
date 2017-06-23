<%@ page language="C#" autoeventwireup="true" inherits="ResetKey, App_Web_dq2bcqoe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="bg-dark">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>ResetPassword</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <link rel="stylesheet" href="../css/validationEngine.jquery.css" type="text/css" />

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,400italic,700,800' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Raleway:300,200,100' rel='stylesheet' type='text/css' />

    <!-- Bootstrap core CSS -->
    <link href="../js/bootstrap/dist/css/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../js/bootstrap.switch/bootstrap-switch.css" />
    <link rel="stylesheet" type="text/css" href="../js/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css" />

    <!-- Select2 -->
    <link rel="stylesheet" type="text/css" href="../js/jquery.select2/select2.css" />


    <!-- Slider -->
    <link rel="stylesheet" type="text/css" href="../js/bootstrap.slider/css/slider.css" />

    <!-- Custom styles for this template -->
    <link href="../css/style.css" rel="stylesheet" />

    <link rel="stylesheet" href="../fonts/font-awesome-4/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../css/pygments.css" />
    <link rel="stylesheet" type="text/css" href="../js/jquery.nanoscroller/nanoscroller.css" />
</head>
<body class="texture">
    <div id="cl-wrapper" class="login-container">
        <div class="middle-login">
            <div class="block-flat">
                <div class="header">
                    <h3 class="text-center">
                        <img class="logo-img" src="../img/logo.png" alt="logo" /></h3>
                </div>
                <div>
                    <form style="margin-bottom: 0px !important;" class="form-horizontal" id="resetPwd" runat="server">
                        <div class="content">
                            <div id="login">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon" style="min-width: 20px;"><i class="fa fa-lock"></i></span>
                                            <asp:TextBox runat="server" TextMode="Password" CssClass="form-control" placeholder="Password" ID="TextPwd" data-validation-engine="validate[required]">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-addon" style="min-width: 20px;"><i class="fa fa-lock"></i></span>
                                            <asp:TextBox runat="server" CssClass="form-control input-lg" TextMode="Password" placeholder="Confirm Password" ID="TextRPwd" data-validation-engine="validate[required,equals[TextPwd]]"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="foot" style="padding: 0px;">
                                    <asp:Label ID="resetMsg" runat="server" ForeColor="Green" Visible="false"></asp:Label>
                                    <asp:Button ID="ResetPassword" CssClass="btn btn-default" OnClick="ResetPassword_Click" Text="Reset" runat="server" />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/jquery.js"></script>
    <script src="../js/jquery.select2/select2.min.js" type="text/javascript"></script>
    <script src="../js/jquery.parsley/parsley.js" type="text/javascript"></script>
    <script src="../js/bootstrap.slider/js/bootstrap-slider.js" type="text/javascript"></script>
    <script src="../js/modernizr.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/jquery.nanoscroller/jquery.nanoscroller.js"></script>
    <script type="text/javascript" src="../js/jquery.nestable/jquery.nestable.js"></script>
    <script type="text/javascript" src="../js/behaviour/general.js"></script>
    <script src="../js/jquery.ui/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/bootstrap.switch/bootstrap-switch.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../js/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="../js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#resetPwd").validationEngine();
        });
    </script>
</body>
</html>
