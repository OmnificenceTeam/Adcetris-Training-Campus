var g_UserSettings = {};
var g_CourseSettings = {};
var g_SupportStatus = {};

var g_AdminService = new AdminService();
var g_CourseService = new CourseService();
var g_ReportService = new ReportService();


//--------- User Settings --------------

function User(UserID, Role, Active) {
    this.Role = Role;
    this.UserID = UserID;
    this.Active = Active;
}

function OnSettingsChange(obj) {
    var UserId = parseInt(obj.getAttribute("userid"));
    var role, active;
    if (obj.type == "select-one") {
        role = obj.value;
        active = document.getElementById(obj.getAttribute("ctrlid")).checked;
    }
    else {
        active = obj.checked;
        role = document.getElementById(obj.getAttribute("ctrlid")).value;
    }
    g_UserSettings[UserId] = new User(UserId, role, active);
}

function onUserSettingsSave() {
    g_AdminService.ChangeUserSettings(g_UserSettings);
}

//------------Course Settings-----------

function Course(CourseID, Active) {
    this.CourseID = CourseID;
    this.Active = Active;
}

function OnCourseSettingsChange(course) {
    var CourseId = parseInt(course.getAttribute("courseid"));
    var active = course.checked;
    g_CourseSettings[CourseId] = new Course(CourseId, active);
    g_CourseService.ChangeCourseSettings(g_CourseSettings);

}

// Content Manager

function OnPostingChange(checkBox) {
    var postIt = checkBox.checked;
    var contentId = checkBox.getAttribute("contentid");
    g_AdminService.ChangePostingStatus(contentId, postIt);
}

function UpdateContent(ContentID, Content) {
    g_AdminService.UpdateContent(ContentID, Content);
}

// Check Email Entry

function IsEmailExist(field, rules, i, options) {

    var result = g_AdminService.IsEmailExist(field.val());
    if (result) {
        return "E-Mail ID already exists.";
    }
}


// Tech Support Status Change

function Support(Request, Status) {
    this.RequestID = Request;
    this.Status = Status;
}

function OnIssueStatusChange(status) {
    var RequestId = parseInt(status.getAttribute("requestid"));
    var IssueStaus;
    if (status.type == "select-one") {
        IssueStaus = status.value;
    }
    g_SupportStatus[RequestId] = new Support(RequestId, IssueStaus);
}

function onSupportStatusSave() {
    g_AdminService.StatusChange(g_SupportStatus);
}


// Reports
// Default Country - Afganistan
function GetReports() {

    // Registration Report
    GetRegistrationReport();
    
    // Distribution of Users by Country
    GetUserDistributionByCountry();

    // Distribution of Users by City
    GetUserDistributionByCity("1149361");

    // Not yet started Courses by the Users In Country / City
    GetNotYetStartedCourseInCountry("1149361");

    // In Progress Courses by the Users In Country / City
    GetInProgressCourseInCountry("1149361");

    // Completed Courses by the Users In Country / City
    GetCompletedCourseInCountry("1149361");

    // Best Scorer in Country / City
    GetBestScorerInCountry("1149361");

    // Course Score by Country / City
    GetCourseScoreByCountry("1149361");

    // Seat Time by Country / City
    GetSeatTimeByCountry("1149361");
}

// Registration Report
function GetRegistrationReport() {

    var result = g_ReportService.GetRegistrationReport();

    var myCanvas = document.getElementById("newReg");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {

            var myDate = new Date(parseInt(result[index].RegisteredDate.substr(6)));
            var output = myDate.getDate() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getFullYear();
            Datax.push(output);
            Datay.push((parseInt(result[index].Hits)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Date', 'Total Registrations', yMax);
    }
}

// Distribution of Users by Country

function GetUserDistributionByCountry() {

    var result = g_ReportService.GetUserDistributionByCountry();
    
    var myCanvas = document.getElementById("byCountry");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].Country);
            Datay.push((parseInt(result[index].Registered)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Country', 'Users', yMax);
    }
}

// Distribution of Users by City

function GetUserDistributionByCity(countryId) {

    var result = g_ReportService.GetUserDistributionByCity(parseInt(countryId));

    var myCanvas = document.getElementById("byCity");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].City);
            Datay.push((parseInt(result[index].Registered)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'City', 'Users', yMax);
    }

    else {
        //alert("Distribution of users in this country were none");
    }
}

function UsersfromCityReport(eVal) {
    GetUserDistributionByCity(parseInt(eVal));
}
//------------Not Yet Started--------------------//
// Not yet started Courses by the Users In Country

function GetNotYetStartedCourseInCountry(countryId) {

    var cityId = 0;
    var city = g_ReportService.GetDefaultCity(parseInt(countryId));

    if ((city == null) || (city.length == 0)) {
        cityId = 0;
    }

    else {
        cityId = parseInt(city[0].City_Id);
        document.getElementById('NysCity').value = cityId;
    }

    // Populate City Dropdown list
    var id = document.getElementById('CityList');
    PopulateCityDropdown(id,countryId);

    if (cityId == 0) {
        id.options.length = 0;
    }

    var result = g_ReportService.GetNotYetStartedCourse(parseInt(countryId), 0);

    var myCanvas = document.getElementById("NotStartedCountry");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].CourseName);
            Datay.push((parseInt(result[index].Users)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Course', 'Users', yMax);

        GetNotYetStartedCourseInCity(countryId, cityId);
    }

    else {
        //alert("No Courses were mapped to this country or all courses were already started.");
    }
}

function OnChangeNotYetStartedInCountry(eVal) {
    GetNotYetStartedCourseInCountry(parseInt(eVal));
}


// Not yet started Courses by the Users In City

function GetNotYetStartedCourseInCity(countryId, cityId) {

    var result = g_ReportService.GetNotYetStartedCourse(parseInt(countryId), parseInt(cityId));

    var myCanvas = document.getElementById("NotStartedCity");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].CourseName);
            Datay.push((parseInt(result[index].Users)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Course', 'Users', yMax);
    }

    else {
        //alert("No Courses were mapped to this city or all courses were already started.");
    }
}

function OnChangeNotYetStartedInCity(eVal) {
    var e = document.getElementById('CountryList1');
    var countryId = e.options[e.selectedIndex].value;
    document.getElementById('NysCity').value = parseInt(eVal);
    GetNotYetStartedCourseInCity(parseInt(countryId), parseInt(eVal));
}

//------------In Progress--------------------//
// In Progress Courses by the Users In Country

function GetInProgressCourseInCountry(countryId) {

    var cityId = 0;
    var city = g_ReportService.GetDefaultCity(parseInt(countryId));

    if ((city == null) || (city.length == 0)) {
        cityId = 0;

    }

    else {
        cityId = parseInt(city[0].City_Id);
        document.getElementById('IpCity').value = cityId;
    }

    // Populate City Dropdown list
    var id = document.getElementById('CityList1');
    PopulateCityDropdown(id, countryId);

    if (cityId == 0) {
        id.options.length = 0;
    }

    var result = g_ReportService.GetInProgressCourse(parseInt(countryId), 0);

    var myCanvas = document.getElementById("InProgressCountry");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].CourseName);
            Datay.push((parseInt(result[index].Users)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Course', 'Users', yMax);

        GetInProgressCourseInCity(countryId, cityId);
    }

    else {
        
    }
}

function OnChangeInProgressInCountry(eVal) {
    GetInProgressCourseInCountry(parseInt(eVal));
}


// InProgress Courses by the Users In City

function GetInProgressCourseInCity(countryId, cityId) {

    var result = g_ReportService.GetInProgressCourse(parseInt(countryId), parseInt(cityId));

    var myCanvas = document.getElementById("InProgressCity");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].CourseName);
            Datay.push((parseInt(result[index].Users)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Course', 'Users', yMax);
    }

    else {
        
    }
}

function OnChangeInProgressInCity(eVal) {
    var e = document.getElementById('CountryList2');
    var countryId = e.options[e.selectedIndex].value;
    document.getElementById('IpCity').value = parseInt(eVal);
    GetInProgressCourseInCity(parseInt(countryId), parseInt(eVal));
}

//------------Completed--------------------//
// Completed Courses by the Users In Country

function GetCompletedCourseInCountry(countryId) {

    var cityId = 0;
    var city = g_ReportService.GetDefaultCity(parseInt(countryId));

    if ((city == null) || (city.length == 0)) {
        cityId = 0;
    }

    else {
        cityId = parseInt(city[0].City_Id);
        document.getElementById('CCity').value = cityId;
    }

    // Populate City Dropdown list
    var id = document.getElementById('CityList2');
    PopulateCityDropdown(id, countryId);

    if (cityId == 0) {
        id.options.length = 0;
    }

    var result = g_ReportService.GetCompletedCourse(parseInt(countryId), 0);

    var myCanvas = document.getElementById("CompletedCountry");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].CourseName);
            Datay.push((parseInt(result[index].Users)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay , 'Course', 'Users', yMax);

        GetCompletedCourseInCity(countryId, cityId);
    }

    else {

    }
}

function OnChangeCompletedInCountry(eVal) {
    GetCompletedCourseInCountry(parseInt(eVal));
}


// Completed Courses by the Users In City

function GetCompletedCourseInCity(countryId, cityId) {

    var result = g_ReportService.GetCompletedCourse(parseInt(countryId), parseInt(cityId));

    var myCanvas = document.getElementById("CompletedCity");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].CourseName);
            Datay.push((parseInt(result[index].Users)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'Course', 'Users', yMax);
    }

    else {

    }
}

function OnChangeCompletedInCity(eVal) {
    var e = document.getElementById('CountryList3');
    var countryId = e.options[e.selectedIndex].value;
    document.getElementById('CCity').value = parseInt(eVal);
    GetCompletedCourseInCity(parseInt(countryId), parseInt(eVal));
}

/* ---------------Best Scorer -------------------*/
// Best Scorer in Country

function GetBestScorerInCountry(countryId) {

    var cityId = 0;
    var city = g_ReportService.GetDefaultCity(parseInt(countryId));

    if ((city == null) || (city.length == 0)) {
        cityId = 0;
    }

    else {
        cityId = parseInt(city[0].City_Id);
        document.getElementById('BstScrCity').value = cityId;
    }

    // Populate City Dropdown list
    var id = document.getElementById('CityList3');
    PopulateCityDropdown(id, countryId);

    if (cityId == 0) {
        id.options.length = 0;
    }

    var result = g_ReportService.GetBestScorerInCountry(parseInt(countryId));

    var myCanvas = document.getElementById("BestScorerCountry");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].Username);
            Datay.push((parseInt(result[index].Score)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'User', 'Score', yMax);

        GetBestScorerInCity(cityId);
    }
}

function OnChangeBestScorerInCountry(eVal){
    GetBestScorerInCountry(parseInt(eVal));
}

// Best Scorer in City

function GetBestScorerInCity(cityId) {

    var result = g_ReportService.GetBestScorerInCity(parseInt(cityId));

    var myCanvas = document.getElementById("BestScorerCity");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            Datax.push(result[index].Username);
            Datay.push((parseInt(result[index].Score)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawGraph(myCanvas, Datax, Datay, 'User', 'Score', yMax);
    }
}

function OnChangeBestScorerInCity(eVal) {
    document.getElementById('BstScrCity').value = parseInt(eVal);
    GetBestScorerInCity(parseInt(eVal));
}


/*--------------Course Score Report --------------*/
// Course Score by Country

function GetCourseScoreByCountry(countryId) {

    var cityId = 0;
    var city = g_ReportService.GetDefaultCity(parseInt(countryId));

    if ((city == null) || (city.length == 0)) {
        cityId = 0;
    }

    else {
        cityId = parseInt(city[0].City_Id);
        document.getElementById('CrsScrCity').value = cityId;
    }

    // Populate City Dropdown list
    var id = document.getElementById('CityList4');
    PopulateCityDropdown(id, countryId);

    if (cityId == 0) {
        id.options.length = 0;
    }

    var result = g_ReportService.GetCourseScoreByCountry(parseInt(countryId));

    var myCanvas = document.getElementById("CourseScoreCountry");

    var Datax = new Array();
    var DataY = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            var Datay = new Array();
            Datay.push(result[index].First); //  0 - 20
            Datay.push(result[index].Second);// 21 - 40
            Datay.push(result[index].Third); // 41 - 60
            Datay.push(result[index].Fourth); // 61 - 80
            Datay.push(result[index].Fifth); // 81 - 100
            DataY.push(Datay);
            Datax.push((result[index].Name));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawCourseScoreGraph(myCanvas, Datax, DataY, 'Course', 'Users', yMax);

        GetCourseScoreByCity(cityId);
    }

}

function OnChangeCourseScoreByCountry(eVal) {
    GetCourseScoreByCountry(parseInt(eVal));
}

// Course Score by City
function GetCourseScoreByCity(cityId) {

    var result = g_ReportService.GetCourseScoreByCity(parseInt(cityId));

    var myCanvas = document.getElementById("CourseScoreCity");

    var Datax = new Array();
    var DataY = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            var Datay = new Array();
            Datay.push(result[index].First); //  0 - 20
            Datay.push(result[index].Second); // 21 - 40
            Datay.push(result[index].Third); // 41 - 60
            Datay.push(result[index].Fourth); // 61 -80
            Datay.push(result[index].Fifth); // 81 - 100
            DataY.push(Datay);
            Datax.push((result[index].Name));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawCourseScoreGraph(myCanvas, Datax, DataY, 'Course', 'Users', yMax);
    }
}

function OnChangeCourseScoreByCity(eVal) {
    document.getElementById('CrsScrCity').value = parseInt(eVal);
    GetCourseScoreByCity(parseInt(eVal));
}

/*---------------Seat Time Report by Country / City ------------*/

// Seat Time Report by Country

function GetSeatTimeByCountry(countryId) {
    var cityId = 0;
    var city = g_ReportService.GetDefaultCity(parseInt(countryId));

    if ((city == null) || (city.length == 0)) {
        cityId = 0;
    }

    else {
        cityId = parseInt(city[0].City_Id);
        document.getElementById('SeatCity').value = cityId;
    }

    // Populate City Dropdown list
    var id = document.getElementById('CityList5');
    PopulateCityDropdown(id, countryId);

    if (cityId == 0) {
        id.options.length = 0;
    }

    var result = g_ReportService.GetSeatTimeByCountry(parseInt(countryId));

    var myCanvas = document.getElementById("SeatTimeCountry");

    var Datax = new Array();
    var DataY = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            var Datay = new Array();
            Datay.push(result[index].First); //  0 - 10
            Datay.push(result[index].Second);// 10 - 20
            Datay.push(result[index].Third); // 20 - 30
            Datay.push(result[index].Fourth); // 30 - 40
            DataY.push(Datay);
            Datax.push((result[index].Name));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawSeatTimeGraph(myCanvas, Datax, DataY, 'Course', 'Users', yMax);

        GetSeatTimeByCity(cityId);
    }
}

function OnChangeSeatTimeByCountry(eVal) {
    GetSeatTimeByCountry(parseInt(eVal));
}

// Seat Time Report by City

function GetSeatTimeByCity(cityId) {
    var result = g_ReportService.GetSeatTimeByCity(parseInt(cityId));

    var myCanvas = document.getElementById("SeatTimeCity");

    var Datax = new Array();
    var DataY = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            var Datay = new Array();
            Datay.push(result[index].First); //  0 - 10
            Datay.push(result[index].Second); // 10 - 20
            Datay.push(result[index].Third); // 20 - 30
            Datay.push(result[index].Fourth); // 30 - 40
            DataY.push(Datay);
            Datax.push((result[index].Name));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawSeatTimeGraph(myCanvas, Datax, DataY, 'Course', 'Users', yMax);
    }
}

function OnChangeSeatTimeByCity(eVal) {
    document.getElementById('SeatCity').value = parseInt(eVal);
    GetSeatTimeByCity(parseInt(eVal));
}


// Populate Dropdown
function PopulateCityDropdown(id, countryId) {
    id.options.length = 0;
    cityList = g_ReportService.GetCityOfCountry(parseInt(countryId));
    for (var i = 0; i < cityList.length; i++) {
        var opt = document.createElement('option');
        opt.innerHTML = cityList[i].City;
        opt.value = cityList[i].City_Id;
        id.appendChild(opt);
    }
}

// Draw Graph
function DrawGraph(myCanvas, Datax, Datay, xTitle, yTitle, yMax) {

    var bar4 = new RGraph.Bar(myCanvas, Datay)
        .Set('colors', ['Gradient(#94f776:#50B332:#B1E59F)'])
        .Set('labels', Datax)
        .Set('chart.text.angle',45)
        .Set('numyticks', yMax)
        .Set('ylabels.count', yMax)
        .Set('hmargin', 20)
        .Set('gutter.left', 35)
        .Set('chart.gutter.bottom', 120)
        .Set('hmargin.grouped', 0)
        .Set('scale.round', true)
        .Set('strokestyle', 'white')
        .Set('linewidth', 1)
        .Set('shadow', true)
        .Set('shadow.color', '#ccc')
        .Set('shadow.offsetx', 0)
        .Set('shadow.offsety', 0)
        .Set('shadow.blur', 10)
        .Set('background.grid.dotted', false)
        .Set('background.grid', false)
        .Set('title.xaxis', xTitle)
        .Set('title.yaxis', yTitle)
        .Set('title.yaxis.size', 10)
        .Set('title.xaxis.size', 10)
        .Set('title.xaxis.y',375)
    RGraph.Effects.Bar.Grow(bar4);
}

// Draw Course Score Graph
function DrawCourseScoreGraph(myCanvas, Datax, Datay, xTitle, yTitle, yMax) {

    var bar4 = new RGraph.Bar(myCanvas, Datay)
        .Set('chart.key', ['0 - 20 %', '21 - 40 %', '41 - 60 %', '61 - 80 %', '81 - 100 %'])
        .Set('chart.key.interactive', true)
        .Set('labels', Datax)
        .Set('colors', ['Gradient(red)', 'Gradient(orange)', 'Gradient(yellow)', 'Gradient(lightgreen)', 'Gradient(gray)'])
        .Set('chart.text.angle', 45)
        .Set('numyticks', yMax)
        .Set('ylabels.count', yMax)
        .Set('hmargin', 20)
        .Set('gutter.left', 35)
        .Set('chart.gutter.bottom', 120)
        .Set('hmargin.grouped', 0)
        .Set('scale.round', true)
        .Set('strokestyle', 'white')
        .Set('linewidth', 1)
        .Set('shadow', true)
        .Set('shadow.color', '#ccc')
        .Set('shadow.offsetx', 0)
        .Set('shadow.offsety', 0)
        .Set('shadow.blur', 10)
        .Set('background.grid.dotted', false)
        .Set('background.grid', false)
        .Set('title.xaxis', xTitle)
        .Set('title.yaxis', yTitle)
        .Set('title.yaxis.size', 10)
        .Set('title.xaxis.size', 10)
        .Set('title.xaxis.y', 375)
    RGraph.Effects.Bar.Grow(bar4);
}

// Draw Seat Time Graph
function DrawSeatTimeGraph(myCanvas, Datax, Datay, xTitle, yTitle, yMax) {

    var bar4 = new RGraph.Bar(myCanvas, Datay)
        .Set('chart.key', ['0 - 10 min', '10 - 20 min', '20 - 30 min', '30 - 40 min'])
        .Set('chart.key.interactive', true)
        .Set('labels', Datax)
        .Set('colors', ['Gradient(lightgreen)', 'Gradient(yellow)', 'Gradient(orange)', 'Gradient(red)'])
        .Set('chart.text.angle', 45)
        .Set('numyticks', yMax)
        .Set('ylabels.count', yMax)
        .Set('hmargin', 20)
        .Set('gutter.left', 35)
        .Set('chart.gutter.bottom', 120)
        .Set('hmargin.grouped', 0)
        .Set('scale.round', true)
        .Set('strokestyle', 'white')
        .Set('linewidth', 1)
        .Set('shadow', true)
        .Set('shadow.color', '#ccc')
        .Set('shadow.offsetx', 0)
        .Set('shadow.offsety', 0)
        .Set('shadow.blur', 10)
        .Set('background.grid.dotted', false)
        .Set('background.grid', false)
        .Set('title.xaxis', xTitle)
        .Set('title.yaxis', yTitle)
        .Set('title.yaxis.size', 10)
        .Set('title.xaxis.size', 10)
        .Set('title.xaxis.y', 375)
    RGraph.Effects.Bar.Grow(bar4);
}

/* ----------------DashBoard Graph ----------------------*/

// Dashboard Graph
function DashboardGraph() {
    var result = g_ReportService.GetCourseCompletedByLastMonth();

    var myCanvas = document.getElementById("CourseCompleted");

    var Datax = new Array();
    var Datay = new Array();
    var yMax = 2;
    if ((result != null) && (result.length > 0)) {
        for (var index = 0; index < result.length; index++) {
            var myDate = new Date(parseInt(result[index].CompletionDate.substr(6)));
            var output = myDate.getDate() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getFullYear();
            Datax.push(output);
            Datay.push((parseInt(result[index].Courses)));
        }
        yMax = parseInt(result.length);
        RGraph.ObjectRegistry.Clear(myCanvas);
        DrawDashboardGraph(myCanvas, Datax, Datay, 'Date', 'Completed Courses', yMax);
    }
}

function DrawDashboardGraph(myCanvas, Datax, Datay, xTitle, yTitle, yMax) {
    var line = new RGraph.Line(myCanvas, Datay)
        .Set('tooltips', Datay)
        .Set('spline', true)
        .Set('chart.text.angle', 90)
        .Set('labels', Datax)
        .Set('numxticks', 0)
        .Set('numyticks', yMax)
        .Set('ylabels.count', yMax)
        .Set('hmargin', 10)
        .Set('background.grid.autofit.numvlines', 11)
        .Set('colors', ['lightgreen'])
        .Set('linewidth', 3)
        .Set('gutter.left', 35)
        .Set('gutter.right', 15)
        .Set('title.xaxis', xTitle)
        .Set('title.yaxis', yTitle)
        .Set('title.yaxis.size', 10)
        .Set('title.xaxis.size', 10)
        .Set('title.xaxis.y', 470)
        .Set('shadow', true)
        .Set('shadow.color', '#aaa')
        .Set('shadow.blur', 5)
        .Set('chart.gutter.bottom', 120)
        .Set('filled', true)
        .Set('fillstyle', ['Gradient(white:lightgreen)'])
        .Draw();
}

function pastDate(field, rules, i, options) {
    var date = new Date();
    var now = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);

    if (field.val() < now) {
        return "Date must after the Current Date";
    }
}

function ShowCompletionDate(chkbox)
{
    var status = chkbox.checked;
    if (status) {
        document.getElementById('courseCompletion1').style.display = "block";
        document.getElementById('courseCompletion2').style.display = "block";
    }
    else {
        document.getElementById('courseCompletion1').style.display = "none";
        document.getElementById('courseCompletion2').style.display = "none";
    }
}