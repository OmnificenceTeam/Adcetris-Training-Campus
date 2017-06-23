using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

using LearningManagementSystem.UserManager;
using LearningManagementSystem.Components;

public partial class Player : System.Web.UI.Page
{

    protected static UserType defined = UserType.Normal;

    protected void Page_Load(object sender, EventArgs e)
    {

        UserSession us = Session["User"] as UserSession;

        try
        {
            //UserSession.IsAuthorized(defined, Session["User"] as UserSession);
        }
        catch (UnauthorizedAccessException)
        {
            Response.Redirect(UserManager.GetDefaultPage(UserType.Invalid));
            return;
        }

        if (!IsPostBack)
        {
            String CourseId = Request.QueryString["cid"];
            String SubCourseId = Request.QueryString["sid"];
            String UserID = Request.QueryString["uid"];

            if ((CourseId != null) && (SubCourseId != null) && (UserID != null))
            {
                HttpCookie userid = new HttpCookie("UserID", UserID.ToString());
                HttpCookie SubCourseID = new HttpCookie("SubCourseID", SubCourseId.ToString());
                Response.Cookies.Add(userid);
                Response.Cookies.Add(SubCourseID);

                DataSet ds = LearningManagementSystem.Components.User.GetLastSlide(Convert.ToUInt64(UserID), Convert.ToUInt64(SubCourseId));
                DataTable dt = ds.Tables[0];
                string slideID = dt.Rows[0]["LastSlideID"].ToString();
                 
                if ((SubCourseId == "1"))
                    Response.Redirect("emodule1/pretest/index.html#slideID="+ slideID);
                if ((SubCourseId == "3"))
                    Response.Redirect("emodule1/posttest/index.html#slideID=" + slideID);

                if ((SubCourseId == "4"))
                    Response.Redirect("emodule2/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "6"))
                    Response.Redirect("emodule2/posttest/index.html#slideID=" + slideID);

                if ((SubCourseId == "7"))
                    Response.Redirect("emodule3/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "9"))
                    Response.Redirect("emodule3/posttest/index.html#slideID=" + slideID);


                if ((SubCourseId == "10"))
                    Response.Redirect("emodule4/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "12"))
                    Response.Redirect("emodule4/posttest/index.html#slideID=" + slideID);

                if ((SubCourseId == "13"))
                    Response.Redirect("emodule6/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "15"))
                    Response.Redirect("emodule6/posttest/index.html#slideID=" + slideID);
                
                if ((SubCourseId == "22"))
                    Response.Redirect("emodule8/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "24"))
                    Response.Redirect("emodule8/posttest/index.html#slideID=" + slideID);

                if ((SubCourseId == "16"))
                    Response.Redirect("emodule6/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "18"))
                    Response.Redirect("emodule6/posttest/index.html#slideID=" + slideID);

                if ((SubCourseId == "19"))
                    Response.Redirect("emodule7/pretest/index.html#slideID=" + slideID);
                if ((SubCourseId == "21"))
                    Response.Redirect("emodule7/posttest/index.html#slideID=" + slideID);



                if ((SubCourseId == "2"))
                    Response.Redirect("emodule1/Disease_State_Overview_HL_Module.html#slideID=" + slideID);

                if ((SubCourseId == "5"))
                    Response.Redirect("emodule2/Clinical_and_pathological_features_of_the_sALCL_subgroups_and_primary_cutaneous_ALCL.html#slideID=" + slideID);
                if ((SubCourseId == "8"))
                    Response.Redirect("emodule3/Brentuximab_Vedotin_for_Relapsed_or_Refractory_Hodgkin_Lymphoma.html#slideID=" + slideID);

                if ((SubCourseId == "11"))
                    Response.Redirect("emodule4/Adcetris_Module_4_WSB_Ver_4.01.html#slideID=" + slideID);

                if ((SubCourseId == "14"))
                    Response.Redirect("emodule6/Adcetris_Module_6_WSB_Ver_4.02.html#slideID=" + slideID);

                if ((SubCourseId == "23"))
                    Response.Redirect("emodule8/Adcetris_Module_6_WSB_Ver_4.02.html#slideID=" + slideID);


                if ((SubCourseId == "17"))
                    Response.Redirect("emodule6/Takeda_Adcetris_DigVisAid_WSB-HL_Ver_6.01.html#slideID=" + slideID);
              

                if ((SubCourseId == "20"))
                    Response.Redirect("emodule7/Takeda_Adcetris_DigVisAid_WSB-ALCL_Ver_6.01.html#slideID=" + slideID);
                
                
                
                if ((SubCourseId == "25"))
                    Response.Redirect("emodule9/Emodule7.html#slideID=" + slideID);



                ////Get URL from the DB
                //String url = "http://www.omnificence.in/"; //Replace with the url from DB
                //String scriptText = "window.open('" + url + "', 'newWindow', 'width=1024,height=768,left=100,top=100,resizable=yes');";
                //ClientScript.RegisterStartupScript(this.GetType(), "script", scriptText, true); 
            }
        }
    }
}