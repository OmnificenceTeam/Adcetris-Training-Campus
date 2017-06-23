<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserManagement.aspx.cs" Inherits="Admin_UserManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>User Manager</title>
    <meta name="description" content="lms, medtrix, omnificence, adcetris, training campus" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="../css/demo_page.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery.dataTables_themeroller.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery-ui-1.8.4.custom.css" type="text/css" cache="false" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->
</head>
<body>

    <section class="vbox">
        <LMS:CommonHeader ID="CommonHeader" runat="server" />
        <section style="border-top: 1px solid lightgray;">
            <section class="hbox stretch">
                <!-- .aside -->
                <LMS:Menu ID="Menu" runat="server" ActiveItem="user" />
                <!-- /.aside -->
                <section id="content">
                    <section class="vbox">

                        <section class="scrollable padder">
                            <form id="usersList" runat="server">
                                <div class="m-b-md">
                                    <h3 class="m-b-none">User Manager</h3>
                                </div>
                                <section class="panel panel-default">
                                    <header class="panel-heading" style="height: 50px">
                                        <!--DataTables-->
                                        List of users available in the system.
                                        <div style="float: right">
                                            <a href="#single-form" class="btn btn-sm btn-dark btn-icon" data-toggle="modal" title="Add User"><i class="fa fa-plus" style="font-size: 19px"></i></a>
                                            &nbsp;&nbsp;<a href="#CSV-form" class="btn btn-sm btn-dark btn-icon" data-toggle="modal" title="Import Multiple Users"><i class="fa fa-arrow-circle-down" style="font-size: 19px"></i></a>
                                            &nbsp;&nbsp;<asp:LinkButton ID="ExportToExcel" runat="server" CssClass="btn btn-sm btn-dark btn-icon" title="Export to Excel" OnClick="ExportToExcel_Click"><i class="fa fa-external-link" style="font-size:19px"></i></asp:LinkButton>
                                            &nbsp;&nbsp;<a href="#" class="btn btn-sm btn-dark btn-icon" title="Save" onclick="onUserSettingsSave()"><i class="fa fa-floppy-o" style="font-size: 19px"></i></a>
                                            <i class="fa fa-info-sign text-muted" data-toggle="tooltip" data-placement="bottom" data-title="ajax to load the data." style="font-size: 19px"></i>
                                        </div>
                                    </header>
                                    <div class="table-responsive">

                                        <asp:GridView ID="UserList" CssClass="display" Width="100%" AutoGenerateColumns="false" runat="server" OnRowDataBound="UserList_RowDataBound" DataKeyNames="User_Id">
                                            <Columns>
                                                <asp:BoundField HeaderText="User ID" DataField="User_ID" />
                                                <asp:BoundField HeaderText="EMail ID" DataField="EMail_ID" />
                                                <asp:BoundField HeaderText="First Name" DataField="First_Name" />
                                                <asp:BoundField HeaderText="Last Name" DataField="Last_Name" />
                                                <asp:BoundField HeaderText="Title" DataField="Title" />
                                                <asp:BoundField HeaderText="Designation" DataField="Designation" />
                                                <asp:TemplateField HeaderText="Role">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="UserRoleList" runat="server" onchange="javascript: OnSettingsChange(this);" userid='<%#Eval ("User_Id")%>'>
                                                            <asp:ListItem Value="1">Administrator</asp:ListItem>
                                                            <asp:ListItem Value="2">Trainee</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Active">
                                                    <ItemTemplate>
                                                        <input type="checkbox" id="checkBoxStatus" checked='<%#Eval ("Active")%>' runat="server" onchange="javascript: OnSettingsChange(this);" userid='<%#Eval ("User_Id")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Invitation" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="alreadySent" runat="server" Text="Invitation Sent"></asp:Label>
                                                        <asp:LinkButton ID="sendInvite" runat="server" CssClass="btn btn-primary" Text="Invite" OnClick="sendInvite_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="rowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <FooterStyle CssClass="footerStyle" />
                                        </asp:GridView>
                                    </div>
                                    <asp:Label ID="importUserMsg" Visible="false" ForeColor="Red" Text="Msg" runat="server"></asp:Label>
                                </section>
                                <!-- Add User Form -->
                                <div class="modal fade" id="single-form">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Invite User</h4>
                                            </div>
                                            <div class="modal-body">


                                                <div class="form-group">
                                                    <label class="control-label">EMail ID</label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="username@domain.com" ID="TextUserMail" data-validation-engine="validate[required,custom[email],funcCall[IsEmailExist]]"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">First Name</label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="User first name" ID="Firstname" data-validation-engine="validate[required]"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Last Name</label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="User last name" ID="Lastname" data-validation-engine="validate[required]"></asp:TextBox>
                                                </div>
                                                <div class="form-group" id="courseCompletion1" style="display:none;">
                                                    <label class="control-label">Course completion date</label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="YYYY-MM-DD" ID="CompletionDate" TextMode="Date" data-validation-engine="validate[required,funcCall[pastDate]]"></asp:TextBox>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" id="sendInvitation" runat="server" />
                                                        Send Invitation</label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" id="AssignCourse" runat="server" onchange="ShowCompletionDate(this)" />
                                                        Assign all courses</label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" id="SendAssignMail" runat="server" />
                                                        Invite to attend courses</label>
                                                </div>
                                                <asp:Label ID="sentMsg" Visible="false" ForeColor="Green" Text="Msg" runat="server"></asp:Label>
                                                <br />
                                                <asp:Label ID="assignMsg" Visible="false" ForeColor="Green" Text="Msg" runat="server"></asp:Label>
                                            </div>
                                            <div class="modal-footer">
                                                <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                                                <asp:Button ID="NewUser" runat="server" Text="Add" OnClick="Add_User" CssClass="btn btn-primary" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Add User Form End -->
                                <!-- Import CSV Form -->
                                <div class="modal fade" id="CSV-form">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Import Multiple Users</h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <asp:FileUpload ID="csvFileUpload" runat="server" class="filestyle" data-icon="false" data-classButton="btn btn-default" data-classInput="form-control inline input-s" data-validation-engine="validate[required]" />
                                                </div>
                                                <div class="form-group" id="courseCompletion2" style="display:none;">
                                                    <label class="control-label">Course completion date</label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-lg" placeholder="YYYY-MM-DD" ID="completionAt" TextMode="Date" data-validation-engine="validate[required,funcCall[pastDate]]"></asp:TextBox>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" id="multipleInvite" runat="server" />
                                                        Send Invitation</label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" id="multipleAssignCourse" runat="server" onchange="ShowCompletionDate(this)" />
                                                        Assign all courses</label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" id="multipleSendAssignMail" runat="server" />
                                                        Invite to attend courses</label>
                                                </div>
                                                <asp:Label ID="multipleSentMsg" Visible="false" ForeColor="Green" Text="Msg" runat="server"></asp:Label>
                                            </div>
                                            <div class="modal-footer">
                                                <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                                                <asp:Button ID="importBulkUser" runat="server" Text="Import Users" OnClick="Add_BulkUser" CssClass="btn btn-primary" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Import CSV Form End -->
                            </form>
                        </section>
                    </section>
                    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
                </section>
            </section>
        </section>
    </section>

    <LMS:CommonScripts ID="CommonScripts" runat="server" />
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#usersList").validationEngine();
        });
    </script>
    <script type="text/javascript" charset="utf-8">
        $('#UserList').GridviewFix();
        $(document).ready(function () {
            $('#UserList').dataTable({
                "bJQueryUI": true,
                "sPaginationType": "full_numbers",
                "aaSorting": [[0, "asc"]],
            }).columnFilter();
        });
    </script>
</body>
</html>
