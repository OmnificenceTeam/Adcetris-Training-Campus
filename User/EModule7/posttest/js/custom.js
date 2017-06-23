
var QuestionNumber = 1;
var NumberofQ = 5;
var CorrectAnswer = 0;

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

function Init()
{
    var questionData = $('#question' + QuestionNumber).html();
    $('#questionPlayer').html(questionData);

    startTime = new Date();
}


function onclickAnswer(ele) {
   
    var CorrectHtml ='   <h3>Congrats ! <i style="color:#00718e;" class="fa fa-check-circle"></i></h3> '+
                    '<h3>Correct answer</h3>'+
                    '<div>Please click <strong>Continue</strong> to proceed</div>' +
                    ' <br /><br /> <center><input id="Button1"  onclick="onclickContinue()" type="button" value="Continue" style="width: 100px; bottom: 50px; position: absolute;margin-left: 75px; " /></center>';
    disableAll = false;
    var status = false;
    var answer;
    var answerText;
    var Node = $(ele).parent().parent();
    var elements = $(Node).find('input');
    for (var i = 0; i < elements.length ; i++) {
        if (elements[i].type == 'radio') {
            if (elements[i].checked) {
                answer = elements[i].value;
                status = true;

            }

        }
        answerText = $(Node).find('#radio' + $(Node).find('#Answer').val()).find('p').html();

    }
    var data = new QuizTrackerData();
    data.UserID = getCookieValueByName("UserID");
    data.SubCourseID = getCookieValueByName("SubCourseID");


    if (!status)
        alert("select an option");
    else {
        $(ele).attr('disabled', 'disabled');
        if (parseInt(answer) == parseInt($(Node).find('#Answer').val())) {
            CorrectAnswer += 1;
            data.QuizID = QuestionNumber;
            data.Percentage = parseInt((1 * (100 / NumberofQ)));
            data.AnswerRating = parseInt((1 * (100 / NumberofQ)));
            g_tracker.setQuizResult(data);
            $(Node).find('#AnswerDisp').show();
            $(Node).find('#AnswerDisp').html(CorrectHtml);
        }
        else {
            var WrongHtml = '   <h3>Sorry ! <i style="color:#00718e;" class="fa fa-times-circle"></i></h3> ' +
                   '<h3>Incorrect answer</h3><br />' +
                   '<p>The Correct answer is <strong>"' + answerText + '"</strong> </p><br />' +
                   '<div>Please click <strong>Continue</strong> to proceed</div>' +
                   ' <br /><br /> <center><input id="Button1"  onclick="onclickContinue()" type="button" value="Continue" style="width: 100px; bottom: 50px; position: absolute;margin-left: 75px; " /></center>';
            $(Node).find('#AnswerDisp').show();
            $(Node).find('#AnswerDisp').html(WrongHtml);

        }
        
    }
}


function onclickContinue()
{
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
        $('.easypiechart').data("percent", CorrectAnswer * (100 / NumberofQ));
        $('.easypiechart').html('<span class="h2 step">' + CorrectAnswer * (100 / NumberofQ) + '</span>%');

        $('.easypiechart').easyPieChart({
            animate: 2000
        });

        return;
    }
    QuestionNumber += 1;
    var questionData = $('#question' + QuestionNumber).html();
    $('#questionPlayer').html(questionData);
    $('#qqNumber').html(QuestionNumber + ' of ' + NumberofQ)
}


function SetInfo(userID, subCourceID) {
    _gUserID = userID;
    _gSubCourseID = subCourceID;
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
    setTimeout(function () { reDirect() }, 2000);

});

function reDirect() {
    //if (getCookieValueByName("UserID") == undefined || getCookieValueByName("UserID") == "")
    //    window.location.href = "http://omnificence.in/lmsuser/";
}


