<%@ control language="C#" autoeventwireup="true" inherits="headers_CommonHeader, App_Web_ens0wzhn" %>


<header class="bg-black dk header navbar navbar-fixed-top-xs">
    <div class="navbar-header aside-md">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"><i class="fa fa-bars"></i></a><a href="#" class="navbar-brand" data-toggle="fullscreen">
            <img src="../img/logo.png" class="m-r-sm" style="width:159px;max-height:45px;position:relative;"></a> <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".nav-user"><i class="fa fa-cog"></i></a>
    </div>
    <ul class="nav navbar-nav navbar-right hidden-xs nav-user">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span runat="server" id="username">Username</span>  <b class="caret"></b></a>
            <ul class="dropdown-menu animated fadeInRight">
                <span class="arrow top"></span>
                <li><a href="../Default.aspx?type=logout">Logout</a> </li>
            </ul>
        </li>
    </ul>
</header>
