function ReportService() {
    this.URL = "../service/ReportService.aspx";
}

ReportService.prototype = new ServiceBase();

function ContentHeader(countryId, cityId) {
    this.countryId = countryId;
    this.cityId = cityId;
}

ReportService.prototype.GetDefaultCity = function (countryId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "GetDefaultCity";
    reqHeader.Data = countryId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetCityOfCountry = function (countryId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "GetCityOfCountry";
    reqHeader.Data = countryId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetRegistrationReport = function () {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "NewRegistration";
    reqHeader.Data = "";
    return this.Execute(reqHeader);
}

ReportService.prototype.GetUserDistributionByCountry = function () {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "UserDistributionByCountry";
    reqHeader.Data = "";
    return this.Execute(reqHeader);
}

ReportService.prototype.GetUserDistributionByCity = function (countryId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "UserDistributionByCity";
    reqHeader.Data = countryId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetNotYetStartedCourse = function (countryId, cityId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "NotYetStarted";
    reqHeader.Data = new ContentHeader(countryId, cityId);
    return this.Execute(reqHeader);
}

ReportService.prototype.GetInProgressCourse = function (countryId, cityId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "InProgress";
    reqHeader.Data = new ContentHeader(countryId, cityId);
    return this.Execute(reqHeader);
}

ReportService.prototype.GetCompletedCourse = function (countryId, cityId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "Completed";
    reqHeader.Data = new ContentHeader(countryId, cityId);
    return this.Execute(reqHeader);
}

ReportService.prototype.GetBestScorerInCountry = function (countryId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "BestScorerInCountry";
    reqHeader.Data = countryId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetBestScorerInCity = function (cityId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "BestScorerInCity";
    reqHeader.Data = cityId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetCourseScoreByCountry = function (countryId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "CourseScoreByCountry";
    reqHeader.Data = countryId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetCourseScoreByCity = function (cityId) {

    var reqHeader = new RequestHeader();

    reqHeader.Command = "CourseScoreByCity";
    reqHeader.Data = cityId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetSeatTimeByCountry = function (countryId) {
    var reqHeader = new RequestHeader();

    reqHeader.Command = "SeatTimeByCountry";
    reqHeader.Data = countryId;
    return this.Execute(reqHeader);
}

ReportService.prototype.GetSeatTimeByCity = function (cityId) {
    var reqHeader = new RequestHeader();

    reqHeader.Command = "SeatTimeByCity";
    reqHeader.Data = cityId;
    return this.Execute(reqHeader);
}

// Dashboard Graph
ReportService.prototype.GetCourseCompletedByLastMonth = function () {
    var reqHeader = new RequestHeader();

    reqHeader.Command = "GetCourseCompletedByLastMonth";
    reqHeader.Data = "";
    return this.Execute(reqHeader);
}