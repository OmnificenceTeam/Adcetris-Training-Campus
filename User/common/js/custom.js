var QuestionNumber = 1;
var NumberofQ = 3;
var CorrectAnswer = 0;
var g_total = {};

var transcriptState = true;
/* to hide tooltip when click on document */

$(document).ready(function () {
    $(document).click(function (event) {
        var target = event.target;
        if(target.id != "showHelp")
            $('img').tooltip('hide');
    });
});


/* show tooptip when clicked help icon */
function ShowHelp() {
    $('img').tooltip('show');
}

/* hide tooltip on icon hover */
function HideToolTip(ele) {
    $(ele).tooltip('hide');
}


/* hide transcript */
function onclickHideTranscription(ele) {
    transcriptState = false;
    var transcript = $(ele).parent().parent().parent().find('#transcript-hide');
    // $('#transcript-hide').attr('class', 'box a_normal').addClass("rotateInRight");
   
    $(transcript).hide("drop", { direction: "right" }, "slow", function () {
        $(ele).parent().parent().parent().find('.slidecontent').css("width", "100%");
        $(ele).parent().parent().parent().find('#stickyContent').show();
    });
   
    //window.setTimeout(function () {
    //    $('#transcript-hide').attr('class', 'box a_normal');
    // }, 1000);
            
}


/* show transcript */
function onclickShowTranscription(ele) {
    $(ele).hide();
    transcriptState = true;
    var transcript = $(ele).parent().find('#transcript-hide');
    $(transcript).show();
    $(transcript).attr('class', 'box a_normal').addClass("flipInRight");
    window.setTimeout(function () {
        $(transcript).attr('class', 'box a_normal');
    }, 1000);
    $(ele).parent().find('.slidecontent').css("width", "70%");
}


/* to play slide according to playlist click*/
function onClickPlayList(slideIndex, ele) {
    $('#PlayListDiv').hide("scale", 1000);
    onclickClosePlaylist();
    coursePlayer.LoadbySlide(slideIndex);
    $('#curslide').hide();
    var elements = $(ele).parent().find('div');
    for (var index = 0; index < elements.length; index++) {
        elements[index].className = "list-items";
    }
    $(ele).attr('class', 'list-items active');
}

/* show playlist */
function onclickPlaylistImg() {
    if (disableAll)
        return;

    $('#slideLabel').hide();

    coursePlayer.pause();
    $('#curslide').hide("drop", { direction: "left" }, "slow", function () {

        $('#PlayListDiv').show();
        $('#GlossaryDiv').hide();
        $('#PlayListDiv').attr('class', 'box a_normal').addClass("zoomInRight");
        window.setTimeout(function () {
            $('#PlayListDiv').attr('class', 'box a_normal');
        }, 1000);
    });
    
}

/* hide playlist */
function onclickClosePlaylist() {
    $('#PlayListDiv').hide("scale", 1000, function () {
        $('#GlossaryDiv').hide();
        $('#curslide').show();
        $('#slideLabel').show();
       
    });
}


function onclickCloseglossary() {


    $('#GlossaryDiv').hide("scale", 1000, function () {
        $('#PlayListDiv').hide();
        $('#curslide').show();
        $('#slideLabel').show();
    });
}

function onclickGlossaryImg()
{
    if (disableAll)
        return;

    $('#slideLabel').hide();

    coursePlayer.pause();
    if ($('#PlayListDiv').is(":visible")) {
        $('#PlayListDiv').hide("drop", { direction: "left" }, "slow", function () {
            $('#GlossaryDiv').show();
            $('#GlossaryDiv').attr('class', 'box a_normal').addClass("zoomInRight");
            window.setTimeout(function () {
                $('#GlossaryDiv').attr('class', 'box a_normal');
            }, 1000);
        });
    }
    else {
        $('#curslide').hide("drop", { direction: "left" }, "slow", function () {
            $('#GlossaryDiv').show();
            $('#GlossaryDiv').attr('class', 'box a_normal').addClass("zoomInRight");
            window.setTimeout(function () {
                $('#GlossaryDiv').attr('class', 'box a_normal');
            }, 1000);
        });
    }
}

//onclick answer

function onclickAnswer(ele) {
   
    disableAll = false;
    var status = false;
    var answer;
    var answerText;
    var Node = $(ele).parent().parent().parent();
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
    data.UserID = parseInt(getCookieValueByName("UserID"));
    data.SubCourseID = parseInt(getCookieValueByName("SubCourseID"));

    if (!status)
        alert("select an option");
    else {
        $(ele).attr('disabled', 'disabled');
        $('#AnswerModal').modal('show');
        if (parseInt(answer) == parseInt($(Node).find('#Answer').val())) {
            CorrectAnswer += 1;
            setScore(data.AnswerRating);
            g_total[$(Node).find('#Answer').attr('qid')] = parseInt($(Node).find('#Percentage').val());
            data.QuizID = parseInt(QuestionNumber);
            data.Percentage = parseInt($(Node).find('#Percentage').val());
            data.AnswerRating = parseInt($(Node).find('#Percentage').val());
            var total = 0;
            for (var key in g_total) {
                if (g_total.hasOwnProperty(key)) {
                    total += parseInt(g_total[key]);
                }
            }
            data.Total = total;
            QuestionNumber += 1;
            g_tracker.setQuizResult(data);
            $('#AnswerModal').find('.modal-body').html("Correct answer, click <strong>continue</strong> to proceed");

           
        }
        else {
            $('#AnswerModal').find('.modal-body').html("Incorrect answer, the correct answer is '" + answerText + "'");
        }
        
    }
}


var glowing = false;
function onclickAnswerContinue()
{
	disableAll = false;
    $('#AnswerModal').modal('hide');
    Next();
}

function LoadGlossaryFRomXML(xmlFilePath) {
    try {
        if (window.XMLHttpRequest) {
            xhttp = new XMLHttpRequest();
        }
        else {
            xhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xhttp.open("GET", xmlFilePath, false);
        xhttp.send();
        if (window.DOMParser) {
            parser = new DOMParser();
            LoadXMLdataToHTML(xhttp.responseXML);

        }
    }
    catch (ex) {
        //_logData.log = ex;
        //g_tracker.log(_logData);
    }
}


function LoadXMLdataToHTML(data) {
    var elements = data.getElementsByTagName("content");
    var htmlTitle = "";
    var htmlData = "";
    for (var contentIndex = 0; contentIndex < elements.length ; contentIndex++) {
        var content = elements[contentIndex];
        var contentName = content.getAttribute("name");
        var contentData = content.getAttribute("content");
        if (contentIndex == 0) {
            htmlTitle += "<p data-value='" + contentIndex + "' class='active'>" + contentName + "</p>";
            htmlData += "<div id='data" + contentIndex + "' ><h3>" + contentName + "</h3>" + contentData + "</div>"
        }
        else {
            htmlTitle += "<p data-value='" + contentIndex + "'>" + contentName + "</p>";
            htmlData += "<div id='data" + contentIndex + "'  style='display:none;'> <h3>" + contentName + "</h3>" + contentData + "</div>"
        }

    }

    $('#GlossaryTitle').html(htmlTitle);

    $('#GlossaryData').html(htmlData);
}

$(document).ready(function () {
    LoadGlossaryFRomXML("../common/content/glossary.xml");

    $("#GlossaryTitle p").click(function () {
        var elements = $(this).parent().find("p");
        for (var index = 0; index < elements.length; index++) {
            elements[index].className = "";
        }
        $(this).attr('class', 'active');

        var Dataelement = $('#GlossaryData').find("div");
        for (var index = 0; index < Dataelement.length; index++) {
            Dataelement[index].style.display = "none";
        }
        document.getElementById("data" + $(this).data("value")).style.display = "";

    });



});

function callImageZoom(ele) {
    var img = $(ele).attr('src');
    var ImgTag = $(ele).parent().parent().parent().parent().parent().parent().parent();

    $(ImgTag).find('.zoomedDiv').show();
    $(ImgTag).find("#imgZoom").find('#zoomShowImg').attr("src", img);

    $(ImgTag).find('.zoomImg').attr("src", img);
    $(ImgTag).find('#imgZoom').attr("class", "zoom");

    $(ImgTag).find(".helper").html("click to zoom in");

    $(ImgTag).find('#imgZoom').zoom({
        on: 'click', onZoomIn: function () {
            $(ImgTag).find(".helper").html("click to zoom out");
            $(ImgTag).find('#imgZoom').css("cursor", " -webkit-zoom-out");
            $(ImgTag).find('#imgZoom').css("cursor", " -moz-zoom-out;");
        }, onZoomOut: function () {
            $(ImgTag).find(".helper").html("click to zoom in");
            $(ImgTag).find('#imgZoom').css("cursor", " -webkit-zoom-in");
            $(ImgTag).find('#imgZoom').css("cursor", " -moz-zoom-in;");
        }
    });
}
