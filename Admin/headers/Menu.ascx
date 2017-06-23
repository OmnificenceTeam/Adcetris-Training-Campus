<%@ control language="C#" autoeventwireup="true" inherits="headers_Menu, App_Web_ens0wzhn" %>
<aside class="bg-black lter aside-md hidden-print" id="nav">
    <section class="vbox" style="top: 5px">

        <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="5px" data-color="#333333">
                <!-- nav -->
                <nav class="nav-primary hidden-xs">
                    <ul class="nav">
                        <li runat="server"><a id="admin" runat="server" href="../admin/Admin.aspx"><i class="fa fa-dashboard icon"><b class="bg-danger"></b></i><span>Dashboard</span> </a></li>
                        <li runat="server">
                            <a id="user" runat="server" href="../admin/UserManagement.aspx">
                                <i class="fa fa-users icon">
                                    <b class="bg-warning"></b></i>
                                <span>Users</span>
                            </a>
                        </li>
                        <li runat="server">
                            <a id="course" runat="server" href="../admin/CourseManagement.aspx">
                                <i class="fa fa-flask icon">
                                    <b class="bg-success"></b></i>
                                <span>Course Manager</span>
                            </a>
                        </li>
                        <li runat="server">
                            <a id="content" runat="server" href="../admin/ContentManagement.aspx">
                                <i class="fa fa-file-text icon">
                                    <b class="bg-primary"></b></i>
                                <span>Content Manager</span>
                            </a>
                        </li>
                        <li runat="server">
                            <a id="report" runat="server" href="../admin/Reports.aspx">
                                <i class="fa fa-pencil icon"><b class="bg-primary dker"></b></i><span>Reports</span>
                            </a>
                            <ul class="nav lt">
                                <li><a href="../admin/Reports.aspx"><i class="fa fa-angle-right"></i><span>Course statistics</span> </a></li>
                                <li><a href="../admin/Statistics.aspx"><i class="fa fa-angle-right"></i><span>User activity</span> </a></li>
                            </ul>
                        </li>
                        <li runat="server"><a id="support" runat="server" href="../admin/SupportRequest.aspx"><i class="fa fa-envelope-o icon"><b class="bg-info"></b></i><span>Tech Support</span> </a></li>
                    </ul>
                </nav>
                <!-- / nav -->
            </div>
        </section>
        <footer class="footer lt hidden-xs b-t b-black">
        </footer>
    </section>
</aside>
