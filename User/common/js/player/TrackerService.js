// JScript File

var isIpad = /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());

//document.domain = "adcetristrainingcampus.com";


function ServiceBase() {
    this.XmlHttp = new XMLHttpRequest();
    this.URL = "";
}

// Ajax data request post to server
ServiceBase.prototype.Execute = function(PostData)
{
    try {
        if (navigator.onLine) {
            this.XmlHttp.open("POST", this.URL, false);
            this.XmlHttp.send(JSON.stringify(PostData));
            var Header = JSON.parse(this.XmlHttp.responseText);
            if (Header.isError) {
                //throw new ServiceException(Header.ErrorCode, Header.ErrorMessage);
            }
            return Header.Result;
        }
        else {
            if (isIpad){
                SavePacket(PostData);
        }}
    }
    catch (e) {
		if (isIpad)
			SavePacket(PostData);
    }


}
var g_Packets = [];
function SavePacket(obj)
{
	g_Packets.push(obj);
	if(g_Packets.length == 1)
		setTimeout(function(){PacketSaved();}, 1000);
		
}

function PacketSaved()
{
	try { 
		if (isIpad){
			var data = g_Packets.pop();
			if(data == null)
				return;
				
			var iframe = document.createElement("IFRAME");
			iframe.setAttribute("src", "app://"+JSON.stringify(data));
			document.documentElement.appendChild(iframe);
		}
    }catch(exce){}
}

function ServiceException(errorCode, errorMessage) {
    this.errorCode = errorCode;
    this.errorMessage = errorMessage;
}

function RequestHeader(Command, DataPacket) {
    this.Command = Command;
    this.Data = DataPacket;
}

window.onError = function () {

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
    this.Total = 0.0;
}

QuizTrackerData.prototype = new TrackerData();

function SeatTimeData() {
    this.SlideId = 0;
    this.StartTime = new Date();
    this.EndTime = new Date();
}

SeatTimeData.prototype = new TrackerData();

function CourseAttemptData() {
    this.AttemptID = null;
    this.Score = 0;
    this.Status = 1;
    this.SlideID = 0;
    this.EndTime = new Date();
}

CourseAttemptData.prototype = new TrackerData();

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
    this.URL = "http://www.adcetristrainingcampus.com/user/service/Tracker.aspx";
    this.cmdStatus = "Status";
    this.cmdQuiz = "Quiz";
    this.cmdProgress = "Progress";
    this.cmdDuration = "Duration";
    this.cmdCount = "SlideCount";
    this.cmdAddAttempt = "AddAttemptEntry";
    this.cmdGetAttemptId = "GetAttemptID";
    this.cmdUpdateAttempt = "UpdateAttemptEntry";
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

Tracker.prototype.GetSlideCount = function (subCourseId) {
    var reqHeader = new RequestHeader(this.cmdCount, parseInt(subCourseId));
    return this.Execute(reqHeader);
}

Tracker.prototype.AddAttempt = function (AttemptEntry) {
    var reqHeader = new RequestHeader(this.cmdAddAttempt, AttemptEntry);
    return this.Execute(reqHeader);
}

Tracker.prototype.GetAttemptID = function (data) {
    var reqHeader = new RequestHeader(this.cmdGetAttemptId, data);
    return this.Execute(reqHeader);
}

Tracker.prototype.UpdateAttempt = function (AttemptDetails) {
    var reqHeader = new RequestHeader(this.cmdUpdateAttempt, AttemptDetails);
    return this.Execute(reqHeader);
}

var g_tracker = new Tracker();


function getQueryParams() {
    var qs = document.location.hash;
    qs = qs.split("+").join(" ");

    var params = {}, tokens,
        re = /[#&]?([^=]+)=([^&]*)/g;

    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])]
            = decodeURIComponent(tokens[2]);
    }

    return params;
}

function GetUTCTime(now) {
    //var utc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());
	var utc = now.toUTCString();
    return utc;
}


