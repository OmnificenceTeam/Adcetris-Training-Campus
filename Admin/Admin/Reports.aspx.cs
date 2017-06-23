using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using LearningManagementSystem.UserManager;

public partial class Admin_Reports : System.Web.UI.Page
{
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
            DataTable dt = LearningManagementSystem.Components.User.GetRegisteredCountryList();

            CountryList.DataSource = dt;
            CountryList.DataTextField = "Country";
            CountryList.DataValueField = "Country_Id";
            CountryList.DataBind();

            CountryList1.DataSource = dt;
            CountryList1.DataTextField = "Country";
            CountryList1.DataValueField = "Country_Id";
            CountryList1.DataBind();

            CountryList2.DataSource = dt;
            CountryList2.DataTextField = "Country";
            CountryList2.DataValueField = "Country_Id";
            CountryList2.DataBind();

            CountryList3.DataSource = dt;
            CountryList3.DataTextField = "Country";
            CountryList3.DataValueField = "Country_Id";
            CountryList3.DataBind();

            CountryList4.DataSource = dt;
            CountryList4.DataTextField = "Country";
            CountryList4.DataValueField = "Country_Id";
            CountryList4.DataBind();

            CountryList5.DataSource = dt;
            CountryList5.DataTextField = "Country";
            CountryList5.DataValueField = "Country_Id";
            CountryList5.DataBind();

            CountryList6.DataSource = dt;
            CountryList6.DataTextField = "Country";
            CountryList6.DataValueField = "Country_Id";
            CountryList6.DataBind();
        }
    }

    protected void exportExcel_Click(object sender, EventArgs e)
    {
        DataTable dt = null;
        LinkButton linkButton = (LinkButton)sender;
        String CommandType = (sender as LinkButton).CommandArgument;
        Int64 countryId = 0;
        Int64 cityId = 0;

        if (CommandType.Equals("New_Registration"))
        {
            DataSet ds = LearningManagementSystem.Components.Reports.GetRegistrationReport();
            dt = ds.Tables[0];
        }
        else if (CommandType.Equals("User_Distribution_By_Country"))
        {
            dt = LearningManagementSystem.Components.Reports.GetUserDistributionByCountry();
        }
        else if (CommandType.Equals("User_Distribution_By_City"))
        {
            countryId = Convert.ToInt64(CountryList.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetUserDistributionByCity(countryId);
        }
        else if (CommandType.Equals("Course_Not_Taken_By_Country"))
        {
            countryId = Convert.ToInt64(CountryList1.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetUserCourseStatusReport(countryId, 0, LearningManagementSystem.Components.CourseStatus.NotYetStarted);
        }
        else if (CommandType.Equals("Course_Not_Taken_By_City"))
        {
            countryId = Convert.ToInt64(CountryList1.SelectedValue);
            cityId = Convert.ToInt64(NysCity.Value);
            dt = LearningManagementSystem.Components.Reports.GetUserCourseStatusReport(countryId, cityId, LearningManagementSystem.Components.CourseStatus.NotYetStarted);
        }
        else if (CommandType.Equals("Course_In_Progress_By_Country"))
        {
            countryId = Convert.ToInt64(CountryList2.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetUserCourseStatusReport(countryId, 0, LearningManagementSystem.Components.CourseStatus.InProgress);
        }
        else if (CommandType.Equals("Course_In_Progress_By_City"))
        {
            countryId = Convert.ToInt64(CountryList2.SelectedValue);
            cityId = Convert.ToInt64(IpCity.Value);
            dt = LearningManagementSystem.Components.Reports.GetUserCourseStatusReport(countryId, cityId, LearningManagementSystem.Components.CourseStatus.InProgress);
        }
        else if (CommandType.Equals("Course_Completed_By_Country"))
        {
            countryId = Convert.ToInt64(CountryList3.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetUserCourseStatusReport(countryId, 0, LearningManagementSystem.Components.CourseStatus.Completed);
        }
        else if (CommandType.Equals("Course_Completed_By_City"))
        {
            countryId = Convert.ToInt64(CountryList3.SelectedValue);
            cityId = Convert.ToInt64(CCity.Value);
            dt = LearningManagementSystem.Components.Reports.GetUserCourseStatusReport(countryId, cityId, LearningManagementSystem.Components.CourseStatus.Completed);
        }
        else if (CommandType.Equals("Best_Scorer_In_Country"))
        {
            countryId = Convert.ToInt64(CountryList4.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetBestScorerInCountry(countryId);
            try
            {
                if (dt != null)
                {
                    dt.Columns[3].ColumnName = "Aggregate Scores of all 7 modules and Pre-test & Post-Test";
                    dt.AcceptChanges();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                }
            }
            catch (Exception ex)
            {
                ErrMessage.InnerHtml = "There is an error while exporting the report.";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                Omnificence.Trace.Logger.Log("Error at: Export Aggregate Score by Country. Message: " + ex.Message.ToString());
            }
        }
        else if (CommandType.Equals("Best_Scorer_In_City"))
        {
            cityId = Convert.ToInt64(BstScrCity.Value);
            dt = LearningManagementSystem.Components.Reports.GetBestScorerInCity(cityId);
            try
            {
                if (dt != null)
                {
                    dt.Columns[3].ColumnName = "Aggregate Scores of all 7 modules and Pre-test & Post-Test";
                    dt.AcceptChanges();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                }
            }
            catch (Exception ex)
            {
                ErrMessage.InnerHtml = "There is an error while exporting the report.";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                Omnificence.Trace.Logger.Log("Error at: Export Aggregate Score by City. Message: " + ex.Message.ToString());
            }
        }
        else if (CommandType.Equals("Course_Score_By_Country"))
        {
            countryId = Convert.ToInt64(CountryList5.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetCourseScoreByCountry(countryId);
            try
            {
                if (dt != null)
                {
                    dt.Columns[0].ColumnName = "0 - 20 %";
                    dt.Columns[1].ColumnName = "21 - 40 %";
                    dt.Columns[2].ColumnName = "41 - 60 %";
                    dt.Columns[3].ColumnName = "61 - 80 %";
                    dt.Columns[4].ColumnName = "81 - 100 %";
                    dt.Columns[6].ColumnName = "Course Name";
                    dt.AcceptChanges();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                }
            }
            catch (Exception ex)
            {
                ErrMessage.InnerHtml = "There is an error while exporting the report.";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                Omnificence.Trace.Logger.Log("Error at: Export Course Score by City. Message: " + ex.Message.ToString());
            }
        }
        else if (CommandType.Equals("Course_Score_By_City"))
        {
            cityId = Convert.ToInt64(CrsScrCity.Value);
            dt = LearningManagementSystem.Components.Reports.GetCourseScoreByCity(cityId);
            try
            {
                if (dt != null)
                {
                    dt.Columns[0].ColumnName = "0 - 20 %";
                    dt.Columns[1].ColumnName = "21 - 40 %";
                    dt.Columns[2].ColumnName = "41 - 60 %";
                    dt.Columns[3].ColumnName = "61 - 80 %";
                    dt.Columns[4].ColumnName = "81 - 100 %";
                    dt.Columns[6].ColumnName = "Course Name";
                    dt.AcceptChanges();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                }
            }
            catch (Exception ex)
            {
                ErrMessage.InnerHtml = "There is an error while exporting the report.";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                Omnificence.Trace.Logger.Log("Error at: Export Course Score by City. Message: " + ex.Message.ToString());
            }
        }
        else if (CommandType.Equals("Seat_Time_By_Country"))
        {
            countryId = Convert.ToInt64(CountryList6.SelectedValue);
            dt = LearningManagementSystem.Components.Reports.GetSeatTimeByCountry(countryId);
            try
            {
                if (dt != null)
                {
                    dt.Columns[0].ColumnName = "0 - 10 min";
                    dt.Columns[1].ColumnName = "10 - 20 min";
                    dt.Columns[2].ColumnName = "20 - 30 min";
                    dt.Columns[3].ColumnName = "30 - 40 min";
                    dt.Columns[5].ColumnName = "Course Name";
                    dt.AcceptChanges();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                }
            }
            catch (Exception ex)
            {
                ErrMessage.InnerHtml = "There is an error while exporting the report.";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                Omnificence.Trace.Logger.Log("Error at: Export Seat Time by Country. Message: " + ex.Message.ToString());
            }
        }
        else if (CommandType.Equals("Seat_Time_By_City"))
        {
            cityId = Convert.ToInt64(SeatCity.Value);
            dt = LearningManagementSystem.Components.Reports.GetSeatTimeByCity(cityId);
            try
            {
                if (dt != null)
                {
                    dt.Columns[0].ColumnName = "0 - 10 min";
                    dt.Columns[1].ColumnName = "10 - 20 min";
                    dt.Columns[2].ColumnName = "20 - 30 min";
                    dt.Columns[3].ColumnName = "30 - 40 min";
                    dt.Columns[5].ColumnName = "Course Name";
                    dt.AcceptChanges();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                }
            }
            catch (Exception ex)
            {
                ErrMessage.InnerHtml = "There is an error while exporting the report.";
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openPopupModal();", true);
                Omnificence.Trace.Logger.Log("Error at: Export Seat Time by City. Message: " + ex.Message.ToString());
            }
        }
        try
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                MemoryStream ms = LearningManagementSystem.Utility.Convertor.DataTableToExcel(dt);
                Response.ContentType = "application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + CommandType + ".xlsx");
                Response.AppendHeader("Content-Length", ms.Length.ToString());
                byte[] buf = new byte[ms.Length];
                ms.Read(buf, 0, (int)ms.Length);
                Response.BinaryWrite(buf);
                Response.End();
            }
        }
        catch (Exception ex)
        {
            Omnificence.Trace.Logger.Log(ex.Message.ToString());
        }
    }
}