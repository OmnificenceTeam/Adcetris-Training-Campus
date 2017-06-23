using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearningManagementSystem.Components;
using System.Text;

using System.Data;
using LearningManagementSystem.UserManager;
using System.Web.UI.HtmlControls;
using OfficeOpenXml;

public partial class Admin_UserManagement : System.Web.UI.Page
{
    protected String _JSFunction = String.Empty;
    protected static UserType defined = UserType.Admin;

    protected void Page_Load(object sender, EventArgs e)
    {
        UserSession us = Session["User"] as UserSession;

        try
        {
            UserSession.IsAuthorized(defined, Session["User"] as UserSession);
        }
        catch (UnauthorizedAccessException)
        {
            Response.Redirect(UserManager.GetDefaultPage(UserType.Invalid));
            return;
        }

        if (!IsPostBack)
        {
            BindData();
        }
        
    }

    private void BindData()
    {
        try
        {
            UserList.DataSource = LearningManagementSystem.Components.User.GetUserList();
            UserList.DataBind();
        }
        catch (Exception ex)
        {
            Omnificence.Trace.Logger.Log(ex.Message.ToString());
        }
    }



    protected void Add_BulkUser(object sender, EventArgs e)
    {
        if (csvFileUpload.HasFile)
        {
            if (!System.IO.Path.GetExtension(csvFileUpload.FileName.ToLower()).Contains(".xls"))
            {
                importUserMsg.Text = "Invalid Excel file.";
                importUserMsg.Visible = true;
                importUserMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }
            try
            {
                System.IO.StreamReader sr = new System.IO.StreamReader(csvFileUpload.FileContent);
                StringBuilder sb = new StringBuilder();
                StringBuilder notSent = new StringBuilder();
                StringBuilder courseString = new StringBuilder();
                Int64 userId = 0;
                using (ExcelPackage xlFile = new ExcelPackage(sr.BaseStream))
                {
                    ExcelWorksheet sheet = xlFile.Workbook.Worksheets[1];
                    int row = 2, col = 1;
                    while (sheet.Cells[row, col].Value != null && !String.IsNullOrEmpty(sheet.Cells[row, col].Value.ToString()))
                    {
                        if (LearningManagementSystem.Components.User.IsMailExists(sheet.Cells[row, 1].Value.ToString()))
                        {
                            notSent.AppendLine(sheet.Cells[row, 1].Value.ToString() + " is already registered");
                        }
                        else
                        {
                            userId = LearningManagementSystem.Components.User.CreateUser(
                                sheet.Cells[row, 1].Value.ToString(),
                                sheet.Cells[row, 2].Value.ToString(),
                                sheet.Cells[row, 3].Value.ToString());
                            if (userId != 0)
                            {
                                sb.AppendLine("User with e-Mail ID " + sheet.Cells[row, 1].Value.ToString() + " created.");
                                if (multipleInvite.Checked && LearningManagementSystem.Components.User.SendInvite(sheet.Cells[row, 1].Value.ToString(),
                                    sheet.Cells[row, 2].Value.ToString(),
                                    sheet.Cells[row, 3].Value.ToString()))
                                {
                                    sb.AppendLine("Invitation sent to " + sheet.Cells[row, 1].Value.ToString() + ".");
                                    //comMsg.Text = sb.ToString().Replace(Environment.NewLine, "<br />");
                                }

                                // Assign Course to User

                                if (multipleAssignCourse.Checked)
                                {
                                    try
                                    {
                                        DateTime cDate = Convert.ToDateTime(completionAt.Text.ToString());
                                        DataTable course = LearningManagementSystem.Components.Course.GetActiveCourses();

                                        Int64 courseId = 0;

                                        for (Int32 Index = 0; Index < course.Rows.Count; Index++)
                                        {
                                            courseId = Convert.ToInt64(course.Rows[Index]["Course_Id"]);

                                            LearningManagementSystem.Components.Course.AssignCoursetoUser(courseId, userId, cDate, CourseStatus.NotYetStarted);

                                            // Get SubCourses

                                            DataTable subCourse = LearningManagementSystem.Components.Course.GetSubCourses(courseId);
                                            for (int sub = 0; sub < subCourse.Rows.Count; sub++)
                                            {
                                                LearningManagementSystem.Components.User.MapCoursetoUser(Convert.ToInt64(userId), Convert.ToInt64(subCourse.Rows[sub]["Sub_Course_Id"].ToString()), subCourse.Rows[sub]["Pass_Percentage"].ToString(), UserCourseStatus.NotYetStarted);
                                            }

                                            courseString.AppendLine(course.Rows[Index]["Name"].ToString() + " " + Environment.NewLine);
                                        }

                                        if (multipleSendAssignMail.Checked)
                                        {
                                            try
                                            {
                                                LearningManagementSystem.Components.Course.SendCourseAssignMail(sheet.Cells[row, 1].Value.ToString(), sheet.Cells[row, 2].Value.ToString() + " " + sheet.Cells[row, 3].Value.ToString(), courseString.ToString());
                                            }
                                            catch (Exception mail)
                                            {
                                                Omnificence.Trace.Logger.Log(mail.Message.ToString());
                                            }
                                        }

                                        multipleSentMsg.Text = course.Rows.Count + " were assigned to all users";
                                        multipleSentMsg.Visible = true;
                                    }
                                    catch (Exception assign)
                                    {
                                        Omnificence.Trace.Logger.Log(assign.Message.ToString());
                                    }

                                }
                            }
                            row++;
                        }
                    }
                }
                BindData();
            }
            catch (Exception ex)
            {
                Omnificence.Trace.Logger.Log("Error : " + ex.Message);
            }

        }
    }

    protected void UserList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Int64 invitationStatus = 0;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {          
            Int64 userId = Convert.ToInt64(UserList.DataKeys[e.Row.RowIndex].Value);
            DataRowView drv = e.Row.DataItem as DataRowView;
            DropDownList RoleList = e.Row.FindControl("UserRoleList") as DropDownList;
            Label alreadySent = e.Row.FindControl("alreadySent") as Label;
            LinkButton sendInvite = e.Row.FindControl("sendInvite") as LinkButton;

            RoleList.SelectedValue = drv["Role"].ToString();
            HtmlInputCheckBox chkStatus = e.Row.FindControl("checkBoxStatus") as HtmlInputCheckBox;

            chkStatus.Attributes.Add("ctrlid", RoleList.ClientID);
            RoleList.Attributes.Add("ctrlid", chkStatus.ClientID);

            DataTable dt = LearningManagementSystem.Components.User.GetInvitationStatus(userId);
            invitationStatus = Convert.ToInt64(dt.Rows[0]["Invites_Sent"]);
            if (invitationStatus == 1)
            {
                alreadySent.Visible = true;
                sendInvite.Visible = false;
            }
            else if(invitationStatus == 0)
            {
                alreadySent.Visible = false;
                sendInvite.Visible = true;
                sendInvite.CommandArgument = dt.Rows[0]["EMail_Id"].ToString() + "?" + dt.Rows[0]["First_Name"].ToString() + "?" + dt.Rows[0]["Last_Name"].ToString();
            }
        }
    }

    protected void Add_User(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        String userMail = TextUserMail.Text.ToString();
        Int64 userId = LearningManagementSystem.Components.User.CreateUser(userMail, Firstname.Text, Lastname.Text);
        if (userId != 0)
        {
            try
            {
                if (sendInvitation.Checked && LearningManagementSystem.Components.User.SendInvite(userMail, Firstname.Text, Lastname.Text))
                {
                    sentMsg.Text = "Invitation Sent";
                    sentMsg.Visible = true;
                }
            }
            catch (Exception mail)
            {
                Omnificence.Trace.Logger.Log(mail.Message.ToString());
            }

            // Assign Course to User

            if (AssignCourse.Checked)
            {
                try
                {
                    DateTime cDate = Convert.ToDateTime(CompletionDate.Text.ToString());
                    DataTable course = LearningManagementSystem.Components.Course.GetActiveCourses();

                    Int64 courseId = 0;

                    for(Int32 Index = 0; Index < course.Rows.Count; Index++)
                    {
                        courseId = Convert.ToInt64(course.Rows[Index]["Course_Id"]);

                        LearningManagementSystem.Components.Course.AssignCoursetoUser(courseId, userId, cDate, CourseStatus.NotYetStarted);

                        // Get SubCourses

                        DataTable subCourse = LearningManagementSystem.Components.Course.GetSubCourses(courseId);
                        for (int sub = 0; sub < subCourse.Rows.Count; sub++)
                        {
                            LearningManagementSystem.Components.User.MapCoursetoUser(Convert.ToInt64(userId), Convert.ToInt64(subCourse.Rows[sub]["Sub_Course_Id"].ToString()), subCourse.Rows[sub]["Pass_Percentage"].ToString(), UserCourseStatus.NotYetStarted);
                        }

                        sb.AppendLine(course.Rows[Index]["Name"].ToString() + " " + Environment.NewLine);
                    }

                    if (SendAssignMail.Checked)
                    {
                        try
                        {
                            LearningManagementSystem.Components.Course.SendCourseAssignMail(TextUserMail.Text.ToString(), Firstname.Text.ToString() + " " + Lastname.Text.ToString(), sb.ToString());
                        }
                        catch (Exception ex)
                        {
                            Omnificence.Trace.Logger.Log(ex.Message.ToString());
                        }
                    }

                    assignMsg.Text = course.Rows.Count + " were assigned";
                    assignMsg.Visible = true;
                }
                catch (Exception assign)
                {
                    Omnificence.Trace.Logger.Log(assign.Message.ToString());
                }
            }

            TextUserMail.Text = "";
            BindData();
        }
    }
    protected void ExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = LearningManagementSystem.Components.User.GetUserList();
            //dt.Columns.Remove("Password");
            //dt.Columns.Remove("Access_Token");
            //dt.Columns.Remove("Access_Token_Expiry");
            dt.Columns.Remove("Role");
            MemoryStream ms = LearningManagementSystem.Utility.Convertor.DataTableToExcel(dt);
            Response.ContentType = "application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AppendHeader("Content-Disposition", "attachment; filename=LMS_Users.xlsx");
            Response.AppendHeader("Content-Length", ms.Length.ToString());
            byte[] buf = new byte[ms.Length];
            ms.Read(buf, 0, (int)ms.Length);
            Response.BinaryWrite(buf);
            Response.End();
        }
        catch (Exception ex)
        {
            Omnificence.Trace.Logger.Log(ex.Message.ToString());
        }
    }
    protected void sendInvite_Click(object sender, EventArgs e)
    {
        LinkButton linkButton = (LinkButton)sender;
        String userDetails = linkButton.CommandArgument;
        String[] words = userDetails.Split('?');
        String userMail = words[0].ToString();
        String FirstName = words[1].ToString();
        String LastName = words[2].ToString();
        if (LearningManagementSystem.Components.User.SendInvite(userMail, FirstName, LastName))
        {
            BindData();
        }
    }
}