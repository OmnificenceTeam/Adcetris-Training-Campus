using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using LearningManagementSystem.Components;

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DDDesignation.DataSource = LearningManagementSystem.Components.User.GetDesignationList();
            DDDesignation.DataTextField = "Designation";
            DDDesignation.DataValueField = "Designation_Id";
            DDDesignation.DataBind();

            DDCountry.DataSource = LearningManagementSystem.Components.User.GetCountryList();
            DDCountry.DataTextField = "Country";
            DDCountry.DataValueField = "Country_Id";
            DDCountry.DataBind();

            //DDRegion.DataSource = LearningManagementSystem.Components.User.GetCountryStatesList(Convert.ToInt64(DDCountry.SelectedValue));
            //DDRegion.DataTextField = "State";
            //DDRegion.DataValueField = "State_Id";
            //DDRegion.DataBind();

            //DDCity.DataSource = LearningManagementSystem.Components.User.GetStatesCityList(Convert.ToInt64(DDRegion.SelectedValue));
            //DDCity.DataTextField = "City";
            //DDCity.DataValueField = "City_Id";
            //DDCity.DataBind();
        }

        //TextEMailID.Attributes.Add("readonly", "readonly");
        //TextFirstName.Attributes.Add("readonly","readonly");
        //TextLastName.Attributes.Add("readonly", "readonly");
    }

    protected void RegisterUser_Click(object sender, EventArgs e)
    {
        LearningManagementSystem.Components.User _user = new LearningManagementSystem.Components.User();
        _user.AccessToken = TextAccessToken.Text.ToString();
        _user.FirstName = TextFirstName.Text.ToString();
        _user.LastName = TextLastName.Text.ToString();
        _user.Title = DDTextTitle.SelectedItem.Text.ToString();
        _user.Designation = DDDesignation.SelectedItem.Text.ToString();
        _user.Address =  TextAddress.Text.ToString();
        _user.Country = Convert.ToInt64(DDCountry.SelectedValue);
        _user.State = Convert.ToInt64(StateID.Value);
        _user.City = Convert.ToInt64(CityID.Value);
        _user.EMailID = TextEMailID.Text.ToString();
        _user.Username = TextEMailID.Text.ToString(); //TextName.Text.ToString();
        _user.Password = TextPassword.Text.ToString();
        if (_user.UpdateUser())
        {
            Default.AssignCourses(_user);

            AcMessage.InnerHtml = "Your account has been activated successfully.";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openActivateModal();", true);
        }
        else
        {
            AcMessage.InnerHtml = "There is an error while registering your account. Try again!";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "openActivateModal();", true);
        }
    }
}