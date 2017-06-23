<%@ page language="C#" autoeventwireup="true" inherits="ResetKey, App_Web_l4jd2wnn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="bg-dark">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>ResetPassword</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="../css/app.v2.css" type="text/css" />
    <link rel="stylesheet" href="../css/font.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/validationEngine.jquery.css" type="text/css" />
</head>
<body>
    <section id="content" class="m-t-lg wrapper-md fadeInUp">
        <div class="container aside-xxl">
            <section class="panel panel-default bg-white m-t-lg">
                <header class="panel-heading text-center">Reset your key</header>
                <form id="resetPwd" runat="server" class="panel-body wrapper-lg">
                    <div class="form-group">
                        <label class="control-label">Password</label>
                        <asp:TextBox runat="server" TextMode="Password" CssClass="form-control input-lg" placeholder="Password" ID="TextPwd" data-validation-engine="validate[required]"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Confirm Password</label>
                        <asp:TextBox runat="server" CssClass="form-control input-lg" TextMode="Password" placeholder="Confirm Password" ID="TextRPwd" data-validation-engine="validate[required,equals[TextPwd]]"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ForeColor="Green" Visible="false" ID="resetMsg"></asp:Label>
                    </div>
                    <asp:Button ID="ResetPassword" CssClass="btn btn-default" OnClick="ResetPassword_Click" Text="Reset" runat="server" />
                    <div class="line line-dashed"></div>
                </form>
            </section>
        </div>
    </section>
    <script src="../js/app.v2.js"></script>
    <script type="text/javascript" src="../js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="../js/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../js/jquery.validationEngine-en.js"></script>

    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#resetPwd").validationEngine();
        });
    </script>
</body>
</html>