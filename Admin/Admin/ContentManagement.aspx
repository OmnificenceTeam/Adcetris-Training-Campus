<%@ page language="C#" autoeventwireup="true" inherits="Admin_ContentManagement, App_Web_ggucirnq" validaterequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="app">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Content Manager</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <LMS:CommonStyles ID="CommonStyles" runat="server" />
    <link rel="stylesheet" href="../css/demo_page.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery.dataTables_themeroller.css" type="text/css" cache="false" />
    <link rel="stylesheet" href="../css/jquery-ui-1.8.4.custom.css" type="text/css" cache="false" />
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->

    <link rel="stylesheet" type="text/css" href="../plugins/ckeditor/skins/moono/editor.css?t=DBAA" />
    <style type="text/css">
        .header
        {
            font-family: 'Trebuchet MS';
            font-size: small;
            font-weight: 800;
            padding:0px 0px;
            
        }
        table.display,table.display tr {
            border-color:#ffffff;
            border:0;
        }
        table.display td {
            padding:5px 5px;
            border-color:#ffffff;
        }
        table.ContentTable {
            border: 1px solid lightgray;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px 10px 10px 10px;
        }
        table.ContentTable th {
            border-bottom:1px solid gray;
            background-color: #b1d3dd;
        }
        .headerStyle {
            display:none;
        }
        .headerdata
        {
            font-family: 'Trebuchet MS';
            font-size: small;
            font-weight: 500;
            font-style: italic;
        }

        .fontstyle
        {
            font-family: 'Trebuchet MS';
            font-size: small;
        }
    </style>
    <script src="../plugins/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            // Listen to the double click event.
            if (window.addEventListener)
                document.body.addEventListener('dblclick', onDoubleClick, false);
            else if (window.attachEvent)
                document.body.attachEvent('ondblclick', onDoubleClick);

        };
        function onDoubleClick(ev) {
            // Get the element which fired the event. This is not necessarily the
            // element to which the event has been attached.
            var element = ev.target || ev.srcElement;

            // Find out the div that holds this element.
            var name;

            do {
                element = element.parentNode;
            }
            while (element && (name = element.nodeName.toLowerCase()) &&
				(name != 'div' || element.className.indexOf('editable') == -1) && name != 'body');

            if (name == 'div' && element.className.indexOf('editable') != -1)
                replaceDiv(element);
        }

        var editor;
        var editingDiv;
        function replaceDiv(div) {
            if (editor)
                editor.destroy();
            editingDiv = div;
            editor = CKEDITOR.replace(div);
        }

        function ValidateEditor() {
            var content = CKEDITOR.instances.NewPostContent.document.getBody().getChild(0).getText();
            if (content == '') {
                alert('Content cannot be empty!');
                return false;
            }

            return true;
        }
    </script>
</head>
<body>

    <section class="vbox">
       <LMS:CommonHeader ID="CommonHeader" runat="server" />
        <section style="border-top:1px solid lightgray;">
            <section class="hbox stretch">
                <!-- .aside -->
                <LMS:Menu ID="Menu" runat="server" ActiveItem="content" />
                <!-- /.aside -->
                <section id="content">
                    <section class="vbox">

                        <section class="scrollable padder">
                            <form id="contentManager" runat="server">
                                <div class="m-b-md">
                                    <h3 class="m-b-none">Content Manager</h3>
                                    <h5 class="m-b-none">To edit the document double click on the content.</h5>
                                </div>
                                <section class="panel panel-default">
                                    <header class="panel-heading" style="height:50px">
                                            <!--DataTables-->
                                            Post training updates for users.
                                        <div style="float:right">
                                            <a class="btn btn-sm btn-dark btn-icon" title="New post" href="#new-post"  data-toggle="modal"><i class="fa fa-plus" style="font-size:19px"></i></a>
                                            &nbsp;&nbsp;&nbsp;<i class="fa fa-info-sign text-muted" data-toggle="tooltip" data-placement="bottom" data-title="ajax to load the data."></i>
                                        </div>
                                    </header>
                                    <div class="table-responsive">

                                        <asp:GridView ID="ContentList" CssClass="display" Width="100%" AutoGenerateColumns="false" runat="server">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <table width="100%" class="ContentTable">
                                                            <tr style="min-height:50px">
                                                                <td style="background-color:#f0f8ff;border: #cee1ef 1px solid;width:150px">
                                                                    <span class="header">Modified </span><br />
                                                                    <span class="headerdata"><%# Admin_ContentManagement.GetTimeAgo((DateTime)Eval ("Content_Modified_Date") )%></span>
                                                                    <br />
                                                                    <span class="header">
                                                                    <input type="checkbox" id="IsPublished" <%#Eval ("Published").ToString() == "True" ? "checked" : ""%> onchange="javascript: OnPostingChange(this);" contentid='<%#Eval("Content_id") %>'>&nbsp;&nbsp;Post It!</input></span>
                                                                </td>
                                                                <td><div class="editable" contentid='<%#Eval("Content_id") %>'>
                                                                        <%#Eval("Content") %>
                                                                    </div>
                                                                </td>
                                                            </tr>                                                            
                                                        </table>
                                                        <br />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="rowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <FooterStyle CssClass="footerStyle" />
                                        </asp:GridView>
                                    </div>

                                </section>
                                <!-- New Content Form -->
                                <div class="modal fade" id="new-post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">New post</h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <textarea class="ckeditor" id="NewPostContent" runat="server" rows="5" cols="80"></textarea>
                                                </div>
                                                <asp:Label ID="sentMsg" Visible="false" ForeColor="Green" Text="Msg" runat="server"></asp:Label>
                                            </div>
                                            <div class="modal-footer">
                                                <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                                                <asp:Button ID="NewUser" runat="server" Text="Add" OnClientClick="return ValidateEditor()" OnClick="NewPost_Click"  CssClass="btn btn-primary" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- New Content Form end -->
                            </form>
                        </section>
                    </section>
                    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
                </section>
            </section>
        </section>
    </section>

    <LMS:CommonScripts ID="CommonScripts" runat="server" />

    <script type="text/javascript" src="../plugins/ckeditor/config.js?t=DBAA"></script>
    <script type="text/javascript" src="../plugins/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="../plugins/ckeditor/adapters/jquery.js"></script>

    <script type="text/javascript" charset="utf-8">

        //$('#ContentList').GridviewFix();
        $(document).ready(function () {
            try {
                $('#editor').ckeditor();
                /*$('#ContentList').dataTable({
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "aoColumns": [{ "bSortable": false }],
                    "bLengthChange": false,
                    "iDisplayLength": 5,
                }).columnFilter();*/
            } catch (e) { }

            CKEDITOR.plugins.registered['save'] =
              {
                  init: function (editor) {
                      var command = editor.addCommand('save',
                         {
                             modes: { wysiwyg: 1, source: 1 },
                             exec: function (editor) {
                                 var fo = editor.element.$.form;
                                 editor.updateElement();
                                 editor.destroy();
                                 //alert(editingDiv.getAttribute("contentid"));
                                 //rxsubmit(fo);
                                 if (editor.getData() == '') {
                                     alert('Content cannot be empty!');
                                 }
                                 else {
                                     UpdateContent(editingDiv.getAttribute("contentid"), editor.getData());
                                 }
                             }
                         }
                      );
                      editor.ui.addButton('Save', { label: 'Save Content', command: 'save' });
                  }
              }
        });
    </script>
</body>
</html>
