// JScript File

function ServiceBase()
{
    this.XmlHttp = new XMLHttpRequest();
    this.URL = "";
}

// Ajax data request post to server
ServiceBase.prototype.Execute = function(PostData)
{
    this.XmlHttp.open("POST", this.URL , false);
    this.XmlHttp.send(JSON.stringify(PostData));
    var Header = JSON.parse(this.XmlHttp.responseText);
    if(Header.isError)
    {
        throw new ServiceException(Header.ErrorCode , Header.ErrorMessage);
    }
    return Header.Result;
}

function ServiceException(errorCode, errorMessage)
{
    this.errorCode = errorCode;
    this.errorMessage = errorMessage;
}

function RequestHeader(Command, DataPacket)
{
    this.Command = Command;
    this.Data = DataPacket;
}

window.onError = function()
{
    
}

function TrackerData() {
    this.UserID = 0;
    this.SubCourseID = 0;
    this.TimeStamp = new Date();
}

function QuizTrackerData() {
    this.QuizID = 0;
    this.Percentage = 0.0;
    this.AnswerRating = 0.0;
}

QuizTrackerData.prototype = new TrackerData();

function SeatTimeData() {
    this.SlideId = 0;
    this.StartTime = new Date();
    this.EndTime = new Date();
}

SeatTimeData.prototype = new TrackerData();

function CourseTrackerData() {
    this.Status = 1;
}

CourseTrackerData.prototype = new TrackerData();

function CourseProgressData() {
    this.Slide = 0;
}

CourseProgressData.prototype = new TrackerData();


function CourseStatus() {
    this.NotYetStarted = 1;
    this.InProgress = 2;
    this.Completed = 3;
}

function Tracker() {
    this.URL = "http://omnificence.in/lmsuser/service/Tracker.aspx";
    this.cmdStatus = "Status";
    this.cmdQuiz = "Quiz";
    this.cmdProgress = "Progress";
    this.cmdDuration = "Duration";
}

Tracker.prototype = new ServiceBase();

Tracker.prototype.setCourseStatus = function (courseTrackerData) {
    var reqHeader = new RequestHeader(this.cmdStatus, courseTrackerData);
    return this.Execute(reqHeader);
}

Tracker.prototype.setQuizResult = function (quizTrackerData) {
    var reqHeader = new RequestHeader(this.cmdQuiz, quizTrackerData);
    return this.Execute(reqHeader);
}

Tracker.prototype.setProgress = function (courseProgressData) {
    var reqHeader = new RequestHeader(this.cmdQuiz, courseProgressData);
    return this.Execute(reqHeader);
}

Tracker.prototype.seatTime = function (durationData) {
    var reqHeader = new RequestHeader(this.cmdDuration, durationData);
    return this.Execute(reqHeader);
}

var g_tracker = new Tracker();