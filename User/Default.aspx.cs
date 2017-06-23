using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using LearningManagementSystem.Components;
using LearningManagementSystem.UserManager;
using request = LearningManagementSystem.Components.SupportRequest;
using user = LearningManagementSystem.Components.User;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Text;

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //TextEMailID.Attributes.Add("readonly", "readonly");
        //TextFirstName.Attributes.Add("readonly", "readonly");
        //TextLastName.Attributes.Add("readonly", "readonly");

        //TextEMailIDIE.Attributes.Add("readonly", "readonly");
        //TextFirstNameIE.Attributes.Add("readonly", "readonly");
        //TextLastNameIE.Attributes.Add("readonly", "readonly");

        if (!IsPostBack)
        {
            DataTable designation = LearningManagementSystem.Components.User.GetDesignationList();
            DDDesignation.DataSource = designation;
            DDDesignation.DataTextField = "Designation";
            DDDesignation.DataValueField = "Designation_Id";
            DDDesignation.DataBind();

            DDDesignationIE.DataSource = designation;
            DDDesignationIE.DataTextField = "Designation";
            DDDesignationIE.DataValueField = "Designation_Id";
            DDDesignationIE.DataBind();

            DataTable country = LearningManagementSystem.Components.User.GetCountryList();
            DDCountry.DataSource = country;
            DDCountry.DataTextField = "Country";
            DDCountry.DataValueField = "Country_Id";
            DDCountry.DataBind();

            DDCountryIE.DataSource = country;
            DDCountryIE.DataTextField = "Country";
            DDCountryIE.DataValueField = "Country_Id";
            DDCountryIE.DataBind();

            //DDRegion.DataSource = LearningManagementSystem.Components.User.GetCountryStatesList(Convert.ToInt64(DDCountry.SelectedValue));
            //DDRegion.DataTextField = "State";
            //DDRegion.DataValueField = "State_Id";
            //DDRegion.DataBind();

            //DDRegionIE.DataSource = LearningManagementSystem.Components.User.GetCountryStatesList(Convert.ToInt64(DDCountryIE.SelectedValue));
            //DDRegionIE.DataTextField = "State";
            //DDRegionIE.DataValueField = "State_Id";
            //DDRegionIE.DataBind();

            //DDCity.DataSource = LearningManagementSystem.Components.User.GetStatesCityList(Convert.ToInt64(DDRegion.SelectedValue));
            //DDCity.DataTextField = "City";
            //DDCity.DataValueField = "City_Id";
            //DDCity.DataBind();

            //DDCityIE.DataSource = LearningManagementSystem.Components.User.GetStatesCityList(Convert.ToInt64(DDRegionIE.SelectedValue));
            //DDCityIE.DataTextField = "City";
            //DDCityIE.DataValueField = "City_Id";
            //DDCityIE.DataBind();

            DataTable support = request.GetIssueList();
            SupportDDCategory.DataSource = support;
            SupportDDCategory.DataTextField = "Issue";
            SupportDDCategory.DataValueField = "Issue_Id";
            SupportDDCategory.DataBind();

            SupportDDCategoryIE.DataSource = support;
            SupportDDCategoryIE.DataTextField = "Issue";
            SupportDDCategoryIE.DataValueField = "Issue_Id";
            SupportDDCategoryIE.DataBind();

            if (Request.QueryString["type"] == "logout")
            {
                Session.Abandon();
                HttpCookie sessionCookie = Request.Cookies["val"];

                if (sessionCookie != null)
                {
                    sessionCookie.Expires = DateTime.Now.AddDays(-14);

                    Response.Cookies.Add(sessionCookie);
                }
                return;
            }
            UserSession us = Session["User"] as UserSession;

            if (us == null)
            {
                HttpCookie val = new HttpCookie("val");
                val = Request.Cookies["val"];
                if (val != null && !string.IsNullOrEmpty(val.Value))
                {
                    string[] CookieValues = val.Value.Split(',');
                    us = new UserSession();
                    us.UserID = Convert.ToUInt64(CookieValues[1]);
                    us.UserType = (UserType)Enum.Parse(typeof(UserType), CookieValues[2], true);
                    Session["User"] = us;
                    Response.Redirect(UserManager.GetDefaultPage(us.UserType));
                }
                return;
            }
            Response.Redirect(UserManager.GetDefaultPage(us.UserType));
        }
    }
    protected void Login_Click(object sender, EventArgs e)
    {
        try
        {
            User user = LearningManagementSystem.Components.User.Authenticate(LoginUsername.Text.ToString(), LoginPassword.Text.ToString());

            if (user.Role == UserRole.Normal)
            {
                UserSession us = new UserSession();
                us.UserID = Convert.ToUInt64(user.UserID);
                us.UserType = (UserType)UserRole.Normal;

                if (KeepMe.Checked)
                {
                    HttpCookie val = new HttpCookie("val", LoginUsername.Text + "," + us.UserID.ToString() + "," + us.UserType.ToString());
                    val.Expires = DateTime.Now.AddDays(14);
                    Response.Cookies.Add(val);
                }

                Session["User"] = us;
                Response.Redirect(UserManager.GetDefaultPage(us.UserType));
            }
            else
            {
                Omnificence.Trace.Logger.Log("Invalid Credentials: UserID: " + user.UserID.ToString() + "Username: " + LoginUsername.Text.ToString() + "Pwd: " + LoginPassword.Text.ToString());
            }
        }
        catch (Exception ex)
        {

            Omnificence.Trace.Logger.Log(ex.Message.ToString());

        }
    }
    protected void SubmitEmailID_Click(object sender, EventArgs e)
    {
        try
        {
            if (UserManager.ForgotPassword(TextEmail.Text.ToString(), Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/") + 1)))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openFpModal();", true);
            }
            else
            {

                FpMessage.InnerHtml = "There is an internal error while sending your password.";
                loginInto.Visible = false;

                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openFpModal();", true);

                Omnificence.Trace.Logger.Log("Reset password mail failed to deliver for the mail: " + TextEmail.Text.ToString());
            }
        }
        catch (Exception ex)
        {
            FpMessage.InnerHtml = "There is an internal error while sending your password.";
            loginInto.Visible = false;

            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openFpModal();", true);

            Omnificence.Trace.Logger.Log(ex.Message.ToString());
        }
    }
    protected void RegisterUser_Click(object sender, EventArgs e)
    {
        LearningManagementSystem.Components.User _user = new LearningManagementSystem.Components.User();
        _user.AccessToken = TextAccessToken.Text.ToString();
        _user.FirstName = TextFirstName.Text.ToString();
        _user.LastName = TextLastName.Text.ToString();
        _user.Title = DDTextTitle.SelectedItem.Text.ToString();
        _user.Designation = DDDesignation.SelectedItem.Text.ToString();
        _user.Address = TextAddress.Text.ToString();
        _user.Country = Convert.ToInt64(DDCountry.SelectedValue);
        _user.State = Convert.ToInt64(StateID.Value);
        _user.City = Convert.ToInt64(CityID.Value);
        _user.EMailID = TextEMailID.Text.ToString();
        _user.Username = TextEMailID.Text.ToString();  //TextName.Text.ToString();
        _user.Password = TextPassword.Text.ToString();
        if (_user.UpdateUser())
        {
            //if (_user.Activate())
            AssignCourses(_user);

            AcMessage.InnerHtml = "Your account has been activated successfully.";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openActivateModal();", true);
        }
        else
        {
            AcMessage.InnerHtml = "There is an error while activating your account. Try again!";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openActivateModal();", true);
        }
    }
    public static void AssignCourses(LearningManagementSystem.Components.User _user)
    {
        try
        {
            Omnificence.Trace.Logger.Log("Assigning courses...");

            DateTime cDate = DateTime.Now.AddDays(90);
            DataTable course = LearningManagementSystem.Components.Course.GetActiveCourses();

            Int64 courseId = 0;

            for (Int32 Index = 0; Index < course.Rows.Count; Index++)
            {

                courseId = Convert.ToInt64(course.Rows[Index]["Course_Id"]);
                Omnificence.Trace.Logger.Log("Assigning course id..." + courseId.ToString());
                LearningManagementSystem.Components.Course.AssignCoursetoUser(courseId, _user.UserID, cDate, CourseStatus.NotYetStarted);

                // Get SubCourses

                DataTable subCourse = LearningManagementSystem.Components.Course.GetSubCourses(courseId);
                for (int sub = 0; sub < subCourse.Rows.Count; sub++)
                {
                    Omnificence.Trace.Logger.Log("Assigning subcourse id..." + subCourse.Rows[sub]["Sub_Course_Id"].ToString());
                    LearningManagementSystem.Components.User.MapCoursetoUser(Convert.ToInt64(_user.UserID), Convert.ToInt64(subCourse.Rows[sub]["Sub_Course_Id"].ToString()), subCourse.Rows[sub]["Pass_Percentage"].ToString(), UserCourseStatus.NotYetStarted);
                }

                //courseString.AppendLine(course.Rows[Index]["Name"].ToString() + " " + Environment.NewLine);
            }
        }
        catch (Exception assign)
        {
            Omnificence.Trace.Logger.Log("Error in course assignment : " + assign.StackTrace);
        }
    }
    protected void IssueQuery_Click(object sender, EventArgs e)
    {
        if (request.Create(Convert.ToInt32(SupportDDCategory.SelectedValue), SupportTextEmail.Text.ToString(), SupportTextDescription.Text.ToString(), SupportTextSubject.Text.ToString()))
        {
            // Send Mail to Current User
            request.SendSupportMail(SupportTextEmail.Text.ToString(), "Guest");

            //Send Mail to Admins
            DataTable dt = user.GetAdmin(0, 0);

            for (Int32 Index = 0; Index < dt.Rows.Count; Index++)
            {
                request.SendSupportMailtoAdmin(dt.Rows[Index]["Email_ID"].ToString(), dt.Rows[Index]["First_Name"].ToString(), SupportTextEmail.Text.ToString(), SupportTextSubject.Text.ToString(), SupportDDCategory.SelectedItem.Text.ToString(), SupportTextDescription.Text.ToString());
            }

            supMessage.InnerHtml = "Your query has been submitted";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openSupportModal();", true);
        }
        else
        {
            supMessage.InnerHtml = "There is an error while receiving your query";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openSupportModal();", true);
        }
    }
    protected void RegIE_Click(object sender, EventArgs e)
    {
        LearningManagementSystem.Components.User _user = new LearningManagementSystem.Components.User();
        _user.AccessToken = TextAccessTokenIE.Text.ToString();
        _user.FirstName = TextFirstNameIE.Text.ToString();
        _user.LastName = TextLastNameIE.Text.ToString();
        _user.Title = DDTextTitleIE.SelectedItem.Text.ToString();
        _user.Designation = DDDesignationIE.SelectedItem.Text.ToString();
        _user.Address = TextAddressIE.Text.ToString();
        _user.Country = Convert.ToInt64(DDCountryIE.SelectedValue);
        _user.State = Convert.ToInt64(StateID.Value);
        _user.City = Convert.ToInt64(CityID.Value);
        _user.EMailID = TextEMailIDIE.Text.ToString();
        _user.Username = TextEMailIDIE.Text.ToString();  //TextNameIE.Text.ToString();
        _user.Password = TextPasswordIE.Text.ToString();
        if (_user.UpdateUser())
        {
            AssignCourses(_user);

            AcMessage.InnerHtml = "Your account has been activated successfully";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openActivateModal();", true);
        }
        else
        {
            AcMessage.InnerHtml = "There is an error while activating your account. Try again!";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openActivateModal();", true);
        }
    }
    protected void LoginIE_Click(object sender, EventArgs e)
    {
        try
        {
            User user = LearningManagementSystem.Components.User.Authenticate(LoginIEUsername.Text.ToString(), LoginIEPassword.Text.ToString());

            if (user.Role == UserRole.Normal)
            {
                UserSession us = new UserSession();
                us.UserID = Convert.ToUInt64(user.UserID);
                us.UserType = (UserType)UserRole.Normal;

                if (KeepMeIE.Checked)
                {
                    HttpCookie val = new HttpCookie("val", LoginIEUsername.Text + "," + us.UserID.ToString() + "," + us.UserType.ToString());
                    val.Expires = DateTime.Now.AddDays(14);
                    Response.Cookies.Add(val);
                }

                Session["User"] = us;
                Response.Redirect(UserManager.GetDefaultPage(us.UserType));
            }
            else
            {
                InvalidMsg.Visible = true;
            }
        }
        catch (Exception)
        {
            InvalidMsg.Visible = true;
        }
    }
    protected void FogotPasswordIE_Click(object sender, EventArgs e)
    {
        try
        {
            if (UserManager.ForgotPassword(TextFpwd.Text.ToString(), Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/") + 1)))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openFpModal();", true);
            }
            else
            {

                FpMessage.InnerHtml = "There is an internal error while sending your password.";
                loginInto.Visible = false;
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openFpModal();", true);

                Omnificence.Trace.Logger.Log("Reset password mail failed to deliver for the mail: " + TextFpwd.Text.ToString());
            }
        }
        catch (Exception ex)
        {
            FpMessage.InnerHtml = "There is an internal error while sending your password.";
            loginInto.Visible = false;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openFpModal();", true);

            Omnificence.Trace.Logger.Log(ex.Message.ToString());
        }
    }
    protected void IssueQueryIE_Click(object sender, EventArgs e)
    {
        if (request.Create(Convert.ToInt32(SupportDDCategoryIE.SelectedValue), SupportTextEmailIE.Text.ToString(), SupportTextDescriptionIE.Text.ToString(), SupportTextSubjectIE.Text.ToString()))
        {
            // Send Mail to Current User
            request.SendSupportMail(SupportTextEmailIE.Text.ToString(), "Guest");

            //Send Mail to Admins
            DataTable dt = user.GetAdmin(0, 0);

            for (Int32 Index = 0; Index < dt.Rows.Count; Index++)
            {
                request.SendSupportMailtoAdmin(dt.Rows[Index]["Email_ID"].ToString(), dt.Rows[Index]["First_Name"].ToString(), SupportTextEmailIE.Text.ToString(), SupportTextSubjectIE.Text.ToString(), SupportDDCategoryIE.SelectedItem.Text.ToString(), SupportTextDescriptionIE.Text.ToString());
            }

            supMessage.InnerHtml = "Your query has been submitted";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openSupportModal();", true);
        }
        else
        {
            supMessage.InnerHtml = "There is an error while receiving your query";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openSupportModal();", true);
        }
    }
}