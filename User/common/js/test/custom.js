
var QuestionNumber = 1;
var NumberofQ = 5;
var CorrectAnswer = 0;
var totalScore = 0;
var transcriptState = true;
/* to hide tooltip when click on document */



//$(document).ready(function () {
//    $(document).click(function (event) {
//        var target = event.target;
//        if(target.id != "showHelp")
//            $('img').tooltip('hide');
//    });
//});


///* show tooptip when clicked help icon */
//function ShowHelp() {
//    $('img').tooltip('show');
//}

///* hide tooltip on icon hover */
//function HideToolTip(ele) {
//    $(ele).tooltip('hide');
//}


///* hide transcript */
//function onclickHideTranscription(ele) {
//    transcriptState = false;
//    var transcript = $(ele).parent().parent().parent().find('#transcript-hide');
//    // $('#transcript-hide').attr('class', 'box a_normal').addClass("rotateInRight");

//    $(transcript).hide("drop", { direction: "right" }, "slow", function () {
//        $(ele).parent().parent().parent().find('.slidecontent').css("width", "100%");
//        $(ele).parent().parent().parent().find('#stickyContent').show();
//    });

//    //window.setTimeout(function () {
//    //    $('#transcript-hide').attr('class', 'box a_normal');
//    // }, 1000);

//}


///* show transcript */
//function onclickShowTranscription(ele) {
//    $(ele).hide();
//    transcriptState = true;
//    var transcript = $(ele).parent().find('#transcript-hide');
//    $(transcript).show();
//    $(transcript).attr('class', 'box a_normal').addClass("flipInRight");
//    window.setTimeout(function () {
//        $(transcript).attr('class', 'box a_normal');
//    }, 1000);
//    $(ele).parent().find('.slidecontent').css("width", "70%");
//}


///* to play slide according to playlist click*/
//function onClickPlayList(slideIndex, ele) {
//    $('#PlayListDiv').hide("scale", 1000);
//    onclickClosePlaylist();
//    coursePlayer.LoadbySlide(slideIndex);
//    var elements = $(ele).parent().find('div');
//    for (var index = 0; index < elements.length; index++) {
//        elements[index].className = "list-items";
//    }
//    $(ele).attr('class', 'list-items active');
//}

///* show playlist */
//function onclickPlaylistImg() {
//    if (disableAll)
//        return;

//    coursePlayer.pause();
//    $('#curslide').hide("drop", { direction: "left" }, "slow", function () {
//        $('#PlayListDiv').show();
//        $('#PlayListDiv').attr('class', 'box a_normal').addClass("zoomInRight");
//        window.setTimeout(function () {
//            $('#PlayListDiv').attr('class', 'box a_normal');
//        }, 1000);
//    });

//}

///* hide playlist */
//function onclickClosePlaylist() {
//    $('#PlayListDiv').hide("scale", 1000, function () {
//        $('#GlossaryDiv').hide();
//        $('#curslide').show();

//    });
//}


//function onclickCloseglossary() {

//    $('#GlossaryDiv').hide("scale", 1000, function () {
//        $('#PlayListDiv').hide();
//        $('#curslide').show();
//    });
//}

//function onclickGlossaryImg()
//{
//    if (disableAll)
//        return;

//    coursePlayer.pause();
//    if ($('#PlayListDiv').is(":visible")) {
//        $('#PlayListDiv').hide("drop", { direction: "left" }, "slow", function () {
//            $('#GlossaryDiv').show();
//            $('#GlossaryDiv').attr('class', 'box a_normal').addClass("zoomInRight");
//            window.setTimeout(function () {
//                $('#GlossaryDiv').attr('class', 'box a_normal');
//            }, 1000);
//        });
//    }
//    else {
//        $('#curslide').hide("drop", { direction: "left" }, "slow", function () {
//            $('#GlossaryDiv').show();
//            $('#GlossaryDiv').attr('class', 'box a_normal').addClass("zoomInRight");
//            window.setTimeout(function () {
//                $('#GlossaryDiv').attr('class', 'box a_normal');
//            }, 1000);
//        });
//    }
//}

//onclick answer

var startTime = new Date();
var firstEverStart;
var attemptId;
var score;

function Init(iPadCall) {
    if (isIpad && iPadCall == undefined)
        return;
    startTime = new Date();

    var initDetails = new CourseAttemptData();

    firstEverStart = new Date();
    score = 0;

    initDetails.UserID = getCookieValueByName("UserID");
    initDetails.SubCourseID = getCookieValueByName("SubCourseID");
    initDetails.TimeStamp = firstEverStart;
    initDetails.Score = 0;
    initDetails.Status = 2;
    initDetails.EndTime = new Date();
    //initDetails.SlideID = parseInt(data.slideID);

    var result = g_tracker.AddAttempt(initDetails);


 if (result != undefined && result.LastSlideID != undefined) {
       QuestionNumber = result.LastSlideID;
 }

   else {
     QuestionNumber = 0;
     result = {};
   }


   // var questionData = $('#question' + QuestionNumber).html();
   // $('#questionPlayer').html(questionData);

    attemptId = result.AttemptId;
    score = result.Score;

    if (result.Score != undefined)
        totalScore = score;
    else
        totalScore = 0;

    var slideIndex = parseInt(QuestionNumber) + 1;
    QuestionNumber = slideIndex;

    var start = document.getElementById("start");

    if (slideIndex > 1) {
        var questionData = $('#question' + slideIndex).html();
        $('#questionPlayer').html(questionData);
    }
    else if (start != undefined) {
        var questionData = $('#start').html();
        $('#questionPlayer').html(questionData);
    }
    else {
        var questionData = $('#question' + slideIndex).html();
        $('#questionPlayer').html(questionData);
    }

    $('#qqNumber').html(slideIndex + ' of ' + NumberofQ)


}

function onclickStart(id) {
    var questionData = $('#question'+id).html();
    $('#questionPlayer').html(questionData);

    QuestionNumber = parseInt(id);
    $('#qqNumber').html(id + ' of ' + NumberofQ)
}


function onclickAnswer(ele) {

    var CorrectHtml = '   <h3>Congrats ! <i><img src="../../common/img/right.png" style="color:#00718e; width:24px; height:24px; margin-top:-6px;" /></i></h3> ' +
                    '<h3>Correct answer</h3>' +
                    '<div>Please click <strong>Continue</strong> to proceed</div>' +
                    ' <br /><br /> <div><input id="Button1"  onclick="onclickContinue()" type="button" class="btn btn-primary" value="Continue" style="width: 100px; bottom: 10px; position: absolute;margin-left: 10%; " /></div>';
    disableAll = false;
    var status = false;
    var answer = new Array();
    var answerText = "";
    var userAnswer = "";
    var Node = $(ele).parent().parent();
    var elements = $(Node).find('input');
    for (var i = 0; i < elements.length ; i++) {
        if (elements[i].type == 'radio' || elements[i].type == 'checkbox') {
            if (elements[i].checked) {
                answer.push(elements[i].value);
                status = true;
            }
        }
    }
    var data = new QuizTrackerData();
    data.UserID = getCookieValueByName("UserID");
    data.SubCourseID = getCookieValueByName("SubCourseID");

    var attemptData = new CourseAttemptData();
    attemptData.UserID = getCookieValueByName("UserID");
    attemptData.SubCourseID = getCookieValueByName("SubCourseID");
    attemptData.Timestamp = firstEverStart;
    attemptData.AttemptID = attemptId;


    if(answer.length == 1)
        answerText = $(Node).find('#radio' + $(Node).find('#Answer').val()).find('p').html();
    else if (answer.length > 1) {
        var ans = $(Node).find('#Answer').val();
        var ansList = ans.split(',');
        for(var index = 0; index < ansList.length; index++)
        {
            if(index != ansList.length - 1)
                answerText += $(Node).find('#radio' + ansList[index]).find('p').html() + " and ";
            else
                answerText += $(Node).find('#radio' + ansList[index]).find('p').html();
        }
        for (var index = 0; index < answer.length; index++) {
            if (index != answer.length - 1)
                userAnswer += $(Node).find('#radio' + answer[index]).find('p').html() + " and ";
            else
                userAnswer += $(Node).find('#radio' + answer[index]).find('p').html();
        }

    }


    

    if (!status)
        alert("select an option");
    else {
        $(ele).attr('disabled', 'disabled');

        if (answer.length == 1 && parseInt(answer) == parseInt($(Node).find('#Answer').val()) || answer.length > 1 && answerText == userAnswer) {
            CorrectAnswer += 1;

            data.QuizID =parseInt($(Node).find('#QuestionID').val());
            data.Percentage = parseInt((1 * (100 / NumberofQ)));
            data.AnswerRating = parseInt((1 * (100 / NumberofQ)));
            data.TimeStamp = firstEverStart;

            score = score + (data.AnswerRating);

            g_tracker.setQuizResult(data);

            $(Node).find('#AnswerDisp').show();
            $(Node).find('#AnswerDisp').html(CorrectHtml);

            if (QuestionNumber == NumberofQ) {
                attemptData.Score = score;
                attemptData.Status = 3;
                attemptData.EndTime = new Date();
                g_tracker.UpdateAttempt(attemptData);
            }

            else {
                attemptData.Score = score;
                attemptData.Status = 2;
                attemptData.EndTime = new Date();
                attemptData.SlideID = QuestionNumber;
                g_tracker.UpdateAttempt(attemptData);
            }
        }
        else {
            var WrongHtml = '   <h3>Sorry ! <i><img src="../../common/img/wrong.png" style="color:#00718e; width:24px; height:24px; margin-top:-6px;" /></i></h3> ' +
                   '<h3>Incorrect answer</h3><br />' +
                   '<p>The Correct answer is <strong>"' + answerText + '"</strong> </p><br />' +
                   '<div>Please click <strong>Continue</strong> to proceed</div>' +
                   ' <br /><br /> <div><input id="Button1"  onclick="onclickContinue()" type="button" class="btn btn-primary" value="Continue" style="width: 100px; bottom: 10px; position: absolute;margin-left: 10%; " /></div>';
            data.QuizID = parseInt($(Node).find('#QuestionID').val());
            data.Percentage = 0;
            data.AnswerRating = 0;
            data.TimeStamp = firstEverStart;


            g_tracker.setQuizResult(data);

            $(Node).find('#AnswerDisp').show();
            $(Node).find('#AnswerDisp').html(WrongHtml);

            if (QuestionNumber == NumberofQ) {
                attemptData.Score = score;
                attemptData.Status = 3;
                attemptData.EndTime = new Date();

                g_tracker.UpdateAttempt(attemptData);
            }

            else {
                attemptData.Score = score;
                attemptData.Status = 2;
                attemptData.EndTime = new Date();
                attemptData.SlideID = QuestionNumber;
                g_tracker.UpdateAttempt(attemptData);
            }

            

        }
    }
}

function onclickContinue() {

    var durationData = new SeatTimeData();
    durationData.SlideId = QuestionNumber;
    durationData.Timestamp = new Date();
    durationData.UserID = getCookieValueByName("UserID");
    durationData.SubCourseID = getCookieValueByName("SubCourseID");
    durationData.EndTime = new Date();
    durationData.StartTime = startTime;

    g_tracker.seatTime(durationData);

    startTime = new Date();

    if (QuestionNumber == NumberofQ) {

        $('#questionPlayer').html($('#Success').html());
        $('.easypiechart').data("percent", ((CorrectAnswer * (100 / NumberofQ)) + parseInt(totalScore)));
        $('.easypiechart').html('<span class="h2 step">' + ((CorrectAnswer * (100 / NumberofQ)) + parseInt(totalScore)) + '</span>%');

        $('.easypiechart').easyPieChart({
            animate: 2000
        });

        return;
    }
    if (QuestionNumber == (NumberofQ / 2)) {
        var MiddleSlide = document.getElementById("SecondFrame");
        if (MiddleSlide != undefined) {
            var questionData = $('#SecondFrame').html();
            $('#questionPlayer').html(questionData);
            return;
        }
    }
    QuestionNumber += 1;
    var questionData = $('#question' + QuestionNumber).html();
    $('#questionPlayer').html(questionData);
    $('#qqNumber').html(QuestionNumber + ' of ' + NumberofQ)
}


function SetInfo(userID, subCourceID) {
    _gUserID = userID;
    _gSubCourseID = subCourceID;
    Init(true);
}

var isIpad = /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());
var _gUserID = 0;
var _gSubCourseID = 0;
function getCookieValueByName(name) {
    if (!isIpad) {
        var start = document.cookie.indexOf(name + "=");
        var len = start + name.length + 1;
        if ((!start) && (name != document.cookie.substring(0, name.length)))
            return null;

        if (start == -1) return null;
        var end = document.cookie.indexOf(";", len);
        if (end == -1) end = document.cookie.length;
        return unescape(document.cookie.substring(len, end));
    }
    else {
        if (name == "UserID")
            return _gUserID
        else if (name = "SubCourseID")
            return _gSubCourseID;
    }

}

$(window).load(function () {
    $(".loader").fadeOut("slow");
    if(!isIpad)
        alert("It is recommended to view the module in \"Full Screen.\" Press F11 (or Fn + F11) for a full screen view");
    setTimeout(function () { reDirect() }, 2000);

    if ($("#NofQ").val() != undefined && parseInt($("#NofQ").val()) != 0)
        NumberofQ = parseInt($("#NofQ").val());
});

function reDirect() {
    //if (getCookieValueByName("UserID") == undefined || getCookieValueByName("UserID") == "")
    //    window.location.href = "http://omnificence.in/lmsuser/";
}

function GetUTCTime(now) {
    //var utc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());
	var utc = now.toUTCString();
    return utc;
}
