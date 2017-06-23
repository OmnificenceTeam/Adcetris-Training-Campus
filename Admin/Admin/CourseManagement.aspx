<%@ page language="C#" autoeventwireup="true" inherits="Admin_CourseManagement, App_Web_ggucirnq" validaterequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Course Manager</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="../css/demo_page.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery.dataTables_themeroller.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery-ui-1.8.4.custom.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../js/fuelux/fuelux.css" type="text/css" cache="false" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->

    <style type="text/css">
        .subGrid {
            width: 100%;
            border: 1px solid #01a4e0;
        }

        table.subGrid td {
            /*background-color: #FFFFFF !important;*/
            color: black;
            font-size: 10pt;
            line-height: 200%;
            width: 30%;
            border-color: #FFFFFF;
            border: 3px solid #FFFFFF;
        }

        table.subGrid th {
            /*background: url(../img/smooth/ui-bg_flat_0_aaaaaa_40x100.png) repeat-x !important;*/
            color: floralwhite;
            font-size: 10pt;
            line-height: 200%;
            width: 30%;
            text-align: center;
            background-color: #007184;
            border: 3px solid #FFFFFF;
        }

        ul.sq {
            list-style-type:square;
        }
    </style>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript">
        $("[class*=fa-plus-square]").live("click", function () {
            $(this).closest("tr").after("<tr class='rowStyle odd'><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("class", "fa fa-minus-square");
        });
        $("[class*=fa-minus-square]").live("click", function () {
            $(this).attr("class", "fa fa-plus-square");
            $(this).closest("tr").next().remove();
        });
    </script>

</head>
<body>

    <section class="vbox">
        <LMS:CommonHeader ID="CommonHeader" runat="server" />
        <section style="border-top: 1px solid lightgray;">
            <section class="hbox stretch">
                <!-- .aside -->
                <LMS:Menu ID="Menu" runat="server" ActiveItem="course" />
                <!-- /.aside -->
                <section id="content">
                    <section class="vbox">

                        <section class="scrollable padder">
                            <form id="courseManager" runat="server">
                                <asp:HiddenField ID="hdnCourseID" runat="server" Value="0" />
                                <div class="m-b-md">
                                    <h3 class="m-b-none">Course Manager</h3>
                                    <h5 class="m-b-none" id="Msg" runat="server">Click on course name to edit the course.</h5>
                                </div>
                                <div id="course_table" runat="server">
                                    <section class="panel panel-default">
                                        <header class="panel-heading" style="height: 50px">
                                            <!--DataTables-->
                                            List of courses in the system.
                                            <div style="float: right">
                                                <asp:LinkButton ID="addCourse" runat="server" OnClick="GoAddEditForm" class="btn btn-sm btn-dark btn-icon" title="Add Course"><i class="fa fa-plus" style="font-size:19px"></i></asp:LinkButton>
                                                &nbsp;&nbsp;
                                                <asp:LinkButton ID="assCourse" runat="server" OnClick="GoAssignForm" class="btn btn-sm btn-dark btn-icon" title="Assign Course"><i class="fa fa-book" style="font-size:19px"></i></asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="assGroupCourse" runat="server" OnClick="GoAssigntoGroupForm" class="btn btn-sm btn-dark btn-icon" title="Assign Course to Group"><i class="fa fa-group" style="font-size:19px"></i></asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <i class="fa fa-info-sign text-muted" data-toggle="tooltip" data-placement="bottom" data-title="ajax to load the data."></i>
                                            </div>
                                        </header>
                                        <div class="table-responsive">

                                            <asp:GridView ID="CourseList" runat="server" AutoGenerateColumns="false" CssClass="display"
                                                DataKeyNames="Course_Id" OnRowDataBound="CourseList_OnRowDataBound">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <i style="cursor: pointer" class="fa fa-plus-square"></i>
                                                            <asp:Panel ID="subListPanel" runat="server" Style="display: none">
                                                                <asp:GridView ID="SubCourseList" runat="server" AutoGenerateColumns="false" CssClass="subGrid">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="Name" HeaderText="Course Name" />
                                                                        <asp:TemplateField HeaderText="Description">
                                                                            <ItemTemplate>
                                                                                <div id="description" runat="server"></div>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Duration" HeaderText="Duration" DataFormatString="{0:## min(s)}" />
                                                                        <asp:BoundField DataField="Pass_Percentage" HeaderText="Pass %" DataFormatString="{0:#0.0}%" />
                                                                        <asp:TemplateField HeaderText="Active" SortExpression="Active">
                                                                            <ItemTemplate><%# (Boolean.Parse(Eval("Active").ToString())) ? "Yes" : "No" %></ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Material">
                                                                            <ItemTemplate>
                                                                                <a href="Download.aspx?sid=<%# Eval("Sub_course_Id")%>&cid=<%# Eval("Course_ID")%>">Download</a>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Course_Id" HeaderText="Course ID" />
                                                    <asp:TemplateField HeaderText="Course Name">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkCourseName" Text='<%#Eval ("Name")%>' runat="server" CommandArgument='<%#Eval("Course_Id") %>' OnClick="Edit_Course" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Description">
                                                        <ItemTemplate>
                                                            <div id="descriptionContainer" runat="server">
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Created_Date" HeaderText="Date Created" DataFormatString="{0:dd/MM/yyyy}" />
                                                    <asp:BoundField DataField="Modified_date" HeaderText="Last Modified" DataFormatString="{0:dd/MM/yyyy}" />
                                                    <asp:TemplateField HeaderText="Active">
                                                        <ItemTemplate>
                                                            <input type="checkbox" id="checkBoxStatus" checked='<%#Eval("Active") %>' runat="server" onchange="javascript: OnCourseSettingsChange(this);" courseid='<%#Eval ("Course_Id")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <RowStyle CssClass="rowStyle" />
                                                <HeaderStyle CssClass="headerStyle" />
                                                <FooterStyle CssClass="footerStyle" />
                                            </asp:GridView>
                                        </div>
                                    </section>
                                </div>
                                <div id="AddEditForm" runat="server">
                                    <header class="header bg-light dker bg-gradient">
                                        <p runat="server" id="add_edit_title">Course Creation</p>
                                    </header>
                                    <section class="scrollable wrapper">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label>Course Name</label>
                                                        <asp:TextBox runat="server" ID="CourseName" CssClass="form-control input-lg" placeholder="Course Name" data-validation-engine="validate[required]"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Description</label>
                                                        <asp:TextBox runat="server" ID="CourseDescription" TextMode="MultiLine" Rows="5" CssClass="form-control input-lg" placeholder="Describe the Course..." data-validation-engine="validate[required]"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <section class="panel panel-default">
                                                    <div class="wizard clearfix">
                                                        <ul class="steps">
                                                            <li data-target="#pre_test" class="active"><span class="badge badge-info">1</span>Pre Assessment</li>
                                                            <li data-target="#module_test"><span class="badge">2</span>Course</li>
                                                            <li data-target="#post_test"><span class="badge">3</span>Post Assessment</li>
                                                        </ul>
                                                        <div class="actions">
                                                            <button type="button" class="btn btn-default btn-xs btn-prev" disabled="disabled">Prev</button>
                                                            <button type="button" class="btn btn-default btn-xs btn-next" data-last="Finish">Next</button>
                                                        </div>
                                                    </div>
                                                    <div class="step-content">
                                                        <div class="step-pane active" id="pre_test">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label>Pre Assessment Name</label>
                                                                    <asp:TextBox runat="server" ID="preTestName" CssClass="form-control" placeholder="Pre Assessment Name" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Description</label>
                                                                    <asp:TextBox runat="server" ID="preTestDescription" TextMode="MultiLine" CssClass="form-control" placeholder="Describe the Pre Assessment..." data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>PassMark</label>
                                                                    <asp:TextBox runat="server" ID="preTestPassMark" CssClass="form-control" placeholder="Pass Mark in %" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Duration</label>
                                                                    <asp:TextBox runat="server" ID="preTestDuration" CssClass="form-control" placeholder="Duration in Minutes" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Content</label>
                                                                    <asp:FileUpload ID="preTestContent" runat="server" CssClass="file-input" />
                                                                </div>
                                                                <div class="form-group">
                                                                    <a class="btn btn-info" href="#" id="preTestDownload" runat="server">Download Content</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="step-pane" id="module_test">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label>Course Name</label>
                                                                    <asp:TextBox runat="server" ID="modTestName" CssClass="form-control" placeholder="Course Name" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Description</label>
                                                                    <asp:TextBox runat="server" ID="modTestDescription" TextMode="MultiLine" CssClass="form-control" placeholder="Describe the Course module..." data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>PassMark</label>
                                                                    <asp:TextBox runat="server" ID="modTestPassMark" CssClass="form-control" placeholder="Pass Mark in %" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Duration</label>
                                                                    <asp:TextBox runat="server" ID="modTestDuration" CssClass="form-control" placeholder="Duration in Minutes" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Content</label>
                                                                    <asp:FileUpload ID="modTestContent" runat="server" CssClass="file-input" />
                                                                </div>
                                                                <div class="form-group">
                                                                    <a class="btn btn-info" href="#" id="moduleTestDownload" runat="server">Download Content</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="step-pane" id="post_test">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label>Post Assessment Name</label>
                                                                    <asp:TextBox runat="server" ID="postTestName" CssClass="form-control" placeholder="Post Assessment Name" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Description</label>
                                                                    <asp:TextBox runat="server" ID="postTestDescription" TextMode="MultiLine" CssClass="form-control" placeholder="Describe the Post Assessment..." data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>PassMark</label>
                                                                    <asp:TextBox runat="server" ID="postTestPassMark" CssClass="form-control" placeholder="Pass Mark in %" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Duration</label>
                                                                    <asp:TextBox runat="server" ID="postTestDuration" CssClass="form-control" placeholder="Duration in Minutes" data-validation-engine="validate[required]"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Content</label>
                                                                    <asp:FileUpload ID="postTestContent" runat="server" CssClass="file-input" />
                                                                </div>
                                                                <div class="form-group">
                                                                    <a class="btn btn-info" href="#" id="postTestDownload" runat="server">Download Content</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <p style="color:black;margin-left:5%;">Click &#34;Next&#34; to continue...</p>
                                                </section>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <asp:Button Text="< Back" UseSubmitBehavior="false" CssClass="btn btn-info" runat="server" ID="Back1" OnClick="GoBack" />
                                            <asp:Button Text="Create New" CssClass="btn btn-info" OnClick="Add_Course" runat="server" ID="SubmitButton" />
                                        </div>
                                    </section>
                                </div>

                                <div id="AssignCourseForm" runat="server">
                                    <header class="header bg-light dker bg-gradient">
                                        <p runat="server" id="assignTitle">Assign Course</p>
                                    </header>
                                    <section class="scrollable wrapper">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="panel-body">
                                                    <asp:GridView runat="server" ID="ModuleList" AutoGenerateColumns="false" CssClass="display">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Check" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <input type="checkbox" value='<%# Eval("Course_Id") %>' id="modulelistCheck" runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Module Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="courseNameLbl" Text='<%#Eval("Name") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="headerStyle" />
                                                        <RowStyle CssClass="rowStyle" />
                                                        <FooterStyle CssClass="footerStyle" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="panel-body">
                                                    <asp:GridView runat="server" ID="UserList" AutoGenerateColumns="false" CssClass="display">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Check" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <input type="checkbox" id="userlistCheck" runat="server" value='<%# Eval("User_Id") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="User Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="UserName" runat="server" Text='<%# Eval("First_Name") + " " + Eval("Last_Name") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="headerStyle" />
                                                        <RowStyle CssClass="rowStyle" />
                                                        <FooterStyle CssClass="footerStyle" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-3">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label>Course Completion Date</label>
                                                        <asp:TextBox runat="server" ID="completionDate" TextMode="Date" data-validation-engine="validate[required,funcCall[pastDate]]" CssClass="form-control" placeholder="YYYY-MM-DD"></asp:TextBox>
                                                    </div>
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" id="courseAssigntoUser" runat="server" checked="checked" />
                                                            Send Course assigned mail to user</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <asp:Button Text="< Back" UseSubmitBehavior="false" CssClass="btn btn-info" runat="server" ID="Back2" OnClick="GoBack" />
                                            <asp:Button Text="Assign" CssClass="btn btn-info" OnClick="Assign_Course" runat="server" ID="AssignCourse" />
                                        </div>
                                    </section>
                                </div>

                                <div id="AssignCoursetoGroup" runat="server">
                                    <header class="header bg-light dker bg-gradient">
                                        <p runat="server" id="P1">Assign Course to Group</p>
                                    </header>
                                    <section class="scrollable wrapper">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="panel-body">
                                                    <asp:GridView runat="server" ID="GModuleList" AutoGenerateColumns="false" CssClass="display">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Check" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <input type="checkbox" value='<%# Eval("Course_Id") %>' id="GmodulelistCheck" runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Module Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="GcourseNameLbl" Text='<%#Eval("Name") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="headerStyle" />
                                                        <RowStyle CssClass="rowStyle" />
                                                        <FooterStyle CssClass="footerStyle" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="panel-body">
                                                    <asp:GridView runat="server" ID="GDesignationList" AutoGenerateColumns="false" CssClass="display">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Check" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <input type="checkbox" id="GdesignationListCheck" runat="server" value='<%# Eval("Designation_Id") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="User Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="UserName" runat="server" Text='<%# Eval("Designation")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="headerStyle" />
                                                        <RowStyle CssClass="rowStyle" />
                                                        <FooterStyle CssClass="footerStyle" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-3">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label>Course Completion Date</label>
                                                        <asp:TextBox runat="server" ID="GcompletionDate" TextMode="Date" CssClass="form-control" placeholder="YYYY-MM-DD" data-validation-engine="validate[required,funcCall[pastDate]]"></asp:TextBox>
                                                    </div>
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" id="courseAssigntoGroup" runat="server" checked="checked" />
                                                            Send Course assigned mail to users in a group</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <asp:Button Text="< Back" UseSubmitBehavior="false" CssClass="btn btn-info" runat="server" ID="Back3" OnClick="GoBack" />
                                            <asp:Button Text="Assign" CssClass="btn btn-info" OnClick="Assign_Course_toGroup" runat="server" ID="AssigntoGroup" />
                                        </div>
                                    </section>
                                </div>

                            </form>
                        </section>
                    </section>
                </section>
                <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
            </section>
        </section>
    </section>

    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#courseManager").validationEngine();
        });
    </script>
    <script src="../js/fuelux/fuelux.js" cache="false"></script>
    <script type="text/javascript" charset="utf-8">
        $('#CourseList').GridviewFix();
        $('#ModuleList').GridviewFix();
        $('#UserList').GridviewFix();
        $('#GModuleList').GridviewFix();
        $('#GDesignationList').GridviewFix();

        $(document).ready(function () {
            try {
                $('#CourseList').dataTable({
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[1, "desc"]],
                }).columnFilter();
            } catch (e) { }
            try {
                $('#UserList').dataTable({
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[1, "asc"]],
                }).columnFilter();
            } catch (e) { }
            try {
                $('#ModuleList').dataTable({
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[1, "asc"]],
                }).columnFilter();
            } catch (e) { }
            try {
                $('#GModuleList').dataTable({
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[1, "asc"]],
                }).columnFilter();
            } catch (e) { }
            try {
                $('#GDesignationList').dataTable({
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[1, "asc"]],
                }).columnFilter();
            } catch (e) { }

        });
    </script>
</body>
</html>
