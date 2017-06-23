using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using score = LearningManagementSystem.Components.Course;
using LearningManagementSystem.UserManager;

public partial class Scores : System.Web.UI.Page
{

    protected static UserType defined = UserType.Normal;

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
            MyScoreGrid.DataSource = score.GetScores(Convert.ToInt64(us.UserID));
            MyScoreGrid.DataBind();
        }
    }
    protected void MyScoreGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                if ((e.Row.Cells[1].Text.Contains("Pre Assessment")))
                {
                    e.Row.Cells[0].Style.Add(HtmlTextWriterStyle.FontWeight, "bold");
                    e.Row.Cells[0].Style.Add("border", "none");
                    e.Row.Cells[0].Style.Add("border-left", "1px solid lightgray");
                }
                if ((e.Row.Cells[1].Text.Contains("Course")))
                {
                    if (e.Row.Cells[0].Text.ToLower().Contains("adcetris objection handler"))
                    {
                        e.Row.Cells[0].Style.Add(HtmlTextWriterStyle.FontWeight, "bold");
                        e.Row.Cells[2].Text = "N/A";
                    }
                    else
                        e.Row.Cells[0].Text = "";
                    e.Row.Cells[0].Style.Add("border", "none");
                    e.Row.Cells[0].Style.Add("border-left", "1px solid lightgray");
                }
                if ((e.Row.Cells[1].Text.Contains("Post Assessment")))
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[0].Style.Add("border-top", "none");

                    if ((e.Row.Cells[3].Text.Contains("Completed")) && (MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Text.Contains("Completed")) && (MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Text.Contains("Completed")))
                    {
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Text = "Completed";
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Style.Add("border-bottom-color", "white");
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Style.Add("border-bottom-color", "white");
                        e.Row.Cells[3].Text = "";
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Text = "";
                    }
                    else if ((e.Row.Cells[3].Text.Contains("Not Attempted")) && (MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Text.Contains("Not Attempted"))&& (MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Text.Contains("Not Attempted")))
                    {
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Text = "Not Attempted";
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Style.Add("border-bottom-color", "white");
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Style.Add("border-bottom-color", "white");
                        e.Row.Cells[3].Text = "";
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Text = "";
                    }
                    else 
                    {
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Text = "In Progress";
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Style.Add("border-bottom-color", "white");
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 1].Cells[3].Style.Add("border-bottom-color", "white");
                        e.Row.Cells[3].Text = "";
                        MyScoreGrid.Rows[e.Row.DataItemIndex - 2].Cells[3].Text = "";
                    }
                }

                if (e.Row.Cells[3].Text.Contains("Completed"))
                {

                }
                
            }
        }

    }
}