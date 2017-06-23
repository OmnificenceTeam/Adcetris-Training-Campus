<%@ control language="C#" autoeventwireup="true" inherits="headers_Menu, App_Web_t2yyjlaf" %>

<div id="head-nav" class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="header-top"></div>
        <div class="header-help">
            <img class="headerleftbg" src="img/headerCorBg.png" />
        </div>
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="fa fa-gear"></span>
            </button>

            <a class="navbar-brand" href="#"><span>
                <img src="img/logo.png" alt="logo" style="margin-top: -8%;" /></span></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li runat="server"><a id="home" runat="server" href="../Homepage.aspx">Home</a></li>
                <li runat="server"><a id="learning" runat="server" href="../Learning.aspx">My Learning</a></li>
                <li runat="server"><a id="score" runat="server" href="../Scores.aspx">My Score</a></li>
                <li runat="server"><a id="support" runat="server" href="../TechSupport.aspx">Tech Support</a></li>
                <li runat="server"><a id="logout" runat="server" href="../Default.aspx?type=logout">Logout</a></li>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</div>
