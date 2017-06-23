var disableAll = false;

var startTime = new Date();

var count = 1;

var firstEverStart;
var score;
var attemptId;

window.requestAnimationFrame = (function () {
    return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            function (callback) {
                window.setTimeout(callback, 1000 / 60);
            };
})();


function BarAnimation(Element) {
    this.Element = Element;
    this.Element.style.display = "";
    this.Index = 0;
}

BarAnimation.prototype.animate = function () {
    this.Index += 1;
    var bPass = false;
    var bars = this.Element.children;
    for (var j = 0; j < bars.length; j++) {

        var canvas = bars[j];
        if (canvas.nodeName == "DIV") {
            if (parseInt(canvas.getAttribute("len")) < this.Index)
                continue;
            canvas.style.width = this.Index + "%";
            bPass = true;
        }
    }
    if (bPass) {
        var me = this;
        requestAnimationFrame(function () { me.animate(); });
    }
}



function CoursePlayer(audioID, sinkObject) {
    this.currentSlide = null;
    this.currentView = null;
    this.sinkObject = sinkObject;
    this.audioPlayer = document.getElementById(audioID);
    var me = this;
    this.audioPlayer.addEventListener("error", function (e) { me.onAudioError(e); });
    this.audioPlayer.addEventListener("ended", function (e) { me.OnAudioComplete(e); });
    //this.audioPlayer.addEventListener("loadedmetadata", this.onMetaData);
    this.audioPlayer.addEventListener("timeupdate", function (e) { me.onProgress(e); });


}

CoursePlayer.prototype.onAudioError = function (e) {
    try {
        sinkObject.AudioFailed(this.currentSlide.getElementsByTagName("audio")[0].src);
    }
    catch (error) { }
}

CoursePlayer.prototype.OnAudioComplete = function (e) {
    updatePlaybutton(false);
    if(this.slideIndex < (this.Slides.length - 1))
    {
        $('#NxtImg').tooltip('show');
    }
    this.playStatus = false;
   
    
}

CoursePlayer.prototype.SetCurrentTime = function (time) {
    this.audioPlayer.currentTime = time * this.audioPlayer.duration;
}

var ProcessedElements = new Array();

CoursePlayer.prototype.onProgress = function (e) {
    $('#NxtImg').removeClass('nextbuttonglow');
    //document.getElementById("pro").innerText = e.currentTarget.currentTime;
    var minutes = parseInt(Math.floor(e.currentTarget.currentTime / 60));
    var seconds = parseInt(e.currentTarget.currentTime - minutes * 60);
    $('#timeduration').html((minutes < 10 ? '0' : '') + minutes + ":" + (seconds < 10 ? '0' : '') + seconds);

    var slideCount = this.slideIndex;
    var slideTotalsec = this.currentSlide.getAttribute("duration");
    $('#slideduration').html(slideTotalsec);
    var progressbarValue = e.currentTarget.currentTime / e.currentTarget.duration;
    $('#progress-bar').simpleSlider("setValue", progressbarValue);
    $('#slideCount').html('Frames ' + (parseInt(slideCount) + 1) + ' of ' + this.Slides.length);
    var elements = this.elementArray;


    if (e.currentTarget.currentTime == 0)
        return;


    for (var i = 0; i < elements.length; i++) {

        if (parseInt(e.currentTarget.currentTime) == 0) {
            startTime = GetUTCTime(new Date());
        }

        if (parseInt(elements[i].time) < parseInt(e.currentTarget.currentTime)) {
            if (elements[i].type == "text") {
                var index = elements.indexOf(elements[i]);
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                ani.show();
                var effectName = ani.data('class');
                $(ani).textillate({ in: { sync: true, effect: effectName }, autostart: false });
                $(ani).textillate("start");

            }
            else if (elements[i].type == "image") {
                var index = elements.indexOf(elements[i]);
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                ani.show();
                var effectName = ani.data('class');
                $(ani).addClass('box a_normal').addClass(effectName);
                window.setTimeout(function () {
                    $(ani).addClass('box a_normal');
                }, 1000);
            }
            else if (elements[i].type == "zoomImage") {
                var index = elements.indexOf(elements[i]);
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                var src = ani.attr("src");
                var zm = $('#' + this.currentView.id).find('#zoomShowImg');
                $(zm).show();
                $(zm).attr("src", src);
                
                $(zm).addClass('box a_normal').addClass("zoomIn");
                window.setTimeout(function () {
                    $(zm).removeClass('zoomIn');
                }, 1000);
                elements.splice(index, 1);
            }
            else if (elements[i].type == "Title")
            {
                $("#slideTitle").html(elements[i].id);
            }
            else if (elements[i].type == "zoomimg") {
                var index = elements.indexOf(elements[i]);
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                var percent = parseInt(elements[i].percent)/100;
                var x = parseInt(elements[i].x) * percent;
                var y = parseInt(elements[i].y) * percent;
                var item = ani[0];
                if (percent != 0) {
                    item.style.width = (parseInt(item.getAttribute("imgwidth")) * percent) + "px";
                    item.style.height = (parseInt(item.getAttribute("imgheight")) * percent) + "px";
                    item.parentNode.style.width = "600px";
                    item.parentNode.style.height = "530px";
                        //$(item).addClass('box a_normal');
                        item.style.left = x + "px";
                        item.style.top = y + "px";
                }
                else {
                    item.parentNode.style.width = "382px";
                    item.parentNode.style.height = "530px";
                    item.style.width = "100%";
                    item.style.height = "100%";
                }
                item.style.position = "relative";
                
                ani[0].style.display = "";
                
            }

            else if (elements[i].type == "zoomOut") {
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);

                $(ani).animate({ height: "500px",opacity:"0"});

            }
           

            else if (elements[i].type == "disable") {
                disableAll = true;
            }
            else if (elements[i].type == "popup") {
                var index = elements.indexOf(elements[i]);
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                ani.show();
            }

            else if (elements[i].type == "zoom") {

                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);

                $(ani).attr("class", "zoom");
                $(ani).find(".helper").html("click to zoom in");
                $(ani).zoom({
                    on: 'click', onZoomIn: function () {
                        $(ani).find(".helper").html("click to zoom out");
                        $(ani).css("cursor", " -webkit-zoom-out");
                        $(ani).css("cursor", " -moz-zoom-out;");
                    }, onZoomOut: function () {
                        $(ani).find(".helper").html("click to zoom in");
                        $(ani).css("cursor", " -webkit-zoom-in");
                        $(ani).css("cursor", " -moz-zoom-in;");
                    }
                });

            }


            else if (elements[i].type == "question") {
                this.pause();
                $('#curslide').find('input').show();
            }
            else if (elements[i].type == "graph") {
                document.getElementById(elements[i].id).src = document.getElementById(elements[i].id).src;
                var index = elements.indexOf(elements[i]);
                $("#" + elements[i].id).show();
            }
            else if (elements[i].type == "hidden") {
               
                document.getElementById(elements[i].id).style.display = "none";
                
                ProcessedElements.push(elements[i].id);
            }


        }
        else {
            if (elements[i].type == "hidden" && (parseInt(elements[i].time) < parseInt(e.currentTarget.currentTime))) {
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                for (var index = 0; index < ProcessedElements.length; index++) {
                    if (elements[i].id == ProcessedElements[index].id && $(ani).css("display") == "none")
                        ani.show();

                }
            }
            else if (elements[i].type != "hidden" && elements[i].type != "zoom" && elements[i].type != "zoomimg" && elements[i].type != "zoomImage" && elements[i].type != "zoomOut") {
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                ani.hide();
            }
	
	 else if (elements[i].type == "zoomimg") {
	     var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
	     var percent = parseInt(elements[i].percent) / 100;
	             if (percent == 0) {
	         ani[0].style.width = "";
	         ani[0].style.height = "100%";
	         ani[0].style.left = "0px";
	         ani[0].style.top = "0px";
	            }

            }

        }



    }

 

}

CoursePlayer.prototype.initialize = function (xmlFilePath) {

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
        this.ModuleContent = xhttp.responseXML;
        this.loadSlides();
        this.loadPlayList();
        return;
    }
    this.ModuleContent = null;

	count = 1;
}

CoursePlayer.prototype.loadSlides = function () {

    this.slideIndex = -1;
    this.Slides = this.ModuleContent.getElementsByTagName("slide");
    if (this.Slides.length > 0) {
        this.slideIndex = 0;
        this.currentSlide = this.Slides[this.slideIndex];
        this.loadCurrentSlide();
        this.audioPlayer.autoplay = false;
        this.audioPlayer.src = this.currentSlide.getElementsByTagName("audio")[0].getAttribute("src");

    }
    //var data = getQueryParams();
    if (_gLastSlideID != undefined)
        this.LoadbySlide(_gLastSlideID);
}

CoursePlayer.prototype.loadPlayList = function () {
    this.Slides = this.ModuleContent.getElementsByTagName("slide");
    this.Module = this.ModuleContent.getElementsByTagName("module")[0];

    var html = "";
    for (var slideIndex = 0; slideIndex < this.Slides.length ; slideIndex++) {
        var slide = this.Slides[slideIndex];
        var slideName = slide.getAttribute("name");
        var slideDuration = slide.getAttribute("duration");
        html += '<div class="list-items" id="listitem' + slideIndex + '" onclick="onClickPlayList(' + slideIndex + ',this);" >' + (slideIndex + 1) + ". " + slideName + '<span>' + slideDuration + '</span></div>';
    }
    $('#playlist').html(html);
    $('#totalDuration').html(this.Module.getAttribute("totalduration"));
}


CoursePlayer.prototype.LoadbySlide = function (slideIndex) {
    this.currentSlide = this.Slides[slideIndex];
    this.slideIndex = slideIndex;
    this.loadCurrentSlide();

    this.audioPlayer.src = this.currentSlide.getElementsByTagName("audio")[0].getAttribute("src");
    this.play();
    return true;
}

CoursePlayer.prototype.nextSlide = function () {
	count = count + 1;
	$('#progress-bar').simpleSlider("setValue", 0);
    var durationData = new SeatTimeData();
    var attemptData = new CourseAttemptData();
    if (this.slideIndex < (this.Slides.length - 1)) {

        attemptData.AttemptID = attemptId;
        attemptData.UserID = parseInt(getCookieValueByName("UserID"));
        attemptData.SubCourseID = parseInt(getCookieValueByName("SubCourseID"));
        attemptData.TimeStamp = firstEverStart;
        attemptData.Score = score;
        attemptData.SlideID = parseInt(this.slideIndex) + 1;
        

        durationData.UserID = parseInt(getCookieValueByName("UserID"));
        durationData.SubCourseID = parseInt(getCookieValueByName("SubCourseID"));
        durationData.TimeStamp = new Date();
        durationData.SlideId = this.slideIndex;
        durationData.EndTime = new Date();
        durationData.StartTime = startTime;

        g_tracker.seatTime(durationData);

        if (parseInt(this.slideIndex) >= (this.Slides.length - 2)) {
            var result = this.Slides.length - 1;
            if (count >= result) {

                attemptData.Status = 3;
                attemptData.EndTime = new Date();
                attemptData.SlideID = 0;

                g_tracker.UpdateAttempt(attemptData);
            }
			else {
                attemptData.Status = 2;
                attemptData.EndTime = new Date();
                attemptData.SlideID = 0;

                g_tracker.UpdateAttempt(attemptData);
            }
        }

        else {
            attemptData.Status = 2;
            attemptData.EndTime = new Date();

            g_tracker.UpdateAttempt(attemptData);
        }
        
        this.currentSlide = this.Slides[++this.slideIndex];

        this.loadCurrentSlide();

        this.audioPlayer.src = this.currentSlide.getElementsByTagName("audio")[0].getAttribute("src");
        return true;
    }
    return false;
}

CoursePlayer.prototype.loadCurrentSlide = function () {
    $('.dropdown-panel').html("");
    if (this.currentView != null)
        this.currentView.parentNode.removeChild(this.currentView);
    var masterSlide = document.getElementById(this.currentSlide.getAttribute("id"));
    this.currentView = masterSlide.cloneNode(true);
    this.currentView.id = "curslide";
    masterSlide.parentNode.insertBefore(this.currentView, masterSlide);
    this.currentView.style.display = "";

    $('.dropdown-panel').html($('#' + this.currentSlide.getAttribute("refid")).html());
    $('#slideTitle').html(this.currentSlide.getAttribute("title"));
    LoadTranscript(this.currentView);
    // element array list to animate
    this.elementArray = new Array();
    var elements = this.currentSlide.getElementsByTagName("element");

    for (var i = 0; i < elements.length; i++) {
        var elementData = new ElementData();
        elementData.time = elements[i].getAttribute("time");
        elementData.id = elements[i].getAttribute("id");
        elementData.type = elements[i].getAttribute("type");
        elementData.x = elements[i].getAttribute("x");
        elementData.y = elements[i].getAttribute("y");
        elementData.percent = elements[i].getAttribute("percent");
        this.elementArray.push(elementData);
    }
    //onclickShowTranscription($("#"+this.currentView.id).find('#stickyContent'));


}

CoursePlayer.prototype.prevSlide = function () {
	count = count - 1;
	$('#progress-bar').simpleSlider("setValue", 0);
    if (this.slideIndex > 0) {
        this.currentSlide = this.Slides[--this.slideIndex];
        this.loadCurrentSlide();

        this.audioPlayer.src = this.currentSlide.getElementsByTagName("audio")[0].getAttribute("src");
        return true;
    }
    return false;
}

CoursePlayer.prototype.play = function () {

    UpdatePlayListItem(this.slideIndex);

    this.audioPlayer.play();
    this.playStatus = !this.audioPlayer.paused;
    updatePlaybutton(this.playStatus);
}
CoursePlayer.prototype.pause = function () {
    this.audioPlayer.pause();
    this.playStatus = !this.audioPlayer.paused;
    updatePlaybutton(this.playStatus);
}

CoursePlayer.prototype.getPlayerStatus = function () {
    return this.playStatus;
}


function UpdatePlayListItem(id) {
    var elements = $('#listitem' + id).parent().find('div');
    for (var index = 0; index < elements.length; index++) {
        elements[index].className = "list-items";
    }
    $('#listitem' + id).attr('class', 'list-items active');
}


function updatePlaybutton(status) {
    if (status) {
        document.getElementById("toggelbutton").src = "../common/img/pauseBtn.png";
    }
    else {
        document.getElementById("toggelbutton").src = "../common/img/playBtn.png";
    }
}


function ElementData() {
    this.id = "";
    this.time = 0;
    this.type = "";
}


function LoadTranscript(slideView) {
    if (transcriptState) {
        $(slideView).find('#stickyContent').hide();
        $(slideView).find('#transcript-hide').show();
        $(slideView).find('.slidecontent').css("width", "70%");
    }
    else {
        $(slideView).find('#transcript-hide').hide();
        $(slideView).find('.slidecontent').css("width", "100%");
        $(slideView).find('#stickyContent').show();
    }

}

function SetInfo(userID, subCourceID) {
    _gUserID = userID;
    _gSubCourseID = subCourceID;
    createAttempt(true);
}

var isIpad = /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());
var _gUserID = 0;
var _gSubCourseID = 0;
var _gLastSlideID = 0;
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

});

function reDirect() {
    //if (getCookieValueByName("UserID") == undefined || getCookieValueByName("UserID") == "")
    //    window.location.href = "http://omnificence.in/lmsuser/";
}


function createAttempt(iPadCall) {
    if (isIpad && iPadCall == undefined)
        return ;
    var initDetails = new CourseAttemptData();

    firstEverStart = new Date();
    score = 0;
    //var data = getQueryParams();
    initDetails.UserID = parseInt(getCookieValueByName("UserID"));
    initDetails.SubCourseID = parseInt(getCookieValueByName("SubCourseID"));
    initDetails.TimeStamp = firstEverStart;
    initDetails.Score = 0;
    initDetails.Status = 2;
    //initDetails.SlideID = parseInt(data.slideID);
    initDetails.EndTime = new Date();
    var result = g_tracker.AddAttempt(initDetails);

    if (result != undefined) {
        _gLastSlideID = result.LastSlideID;
        attemptId = result.AttemptId;
        score = result.Score;
    }

    Init();
}



function setDetails() {
    var initDetails = new CourseAttemptData();

    firstEverStart = GetUTCTime(new Date());
    score = 0;
    var data = getQueryParams();
    initDetails.UserID = parseInt(getCookieValueByName("UserID"));
    initDetails.SubCourseID = parseInt(getCookieValueByName("SubCourseID"));
    initDetails.TimeStamp = firstEverStart;
    initDetails.Score = 0;
    initDetails.Status = 2;
    initDetails.SlideID = parseInt(data.slideID);
    initDetails.EndTime = GetUTCTime(new Date());

    attemptId = g_tracker.AddAttempt(initDetails);

    _gLastSlideID = attemptId.LastSlideID;
    this.LoadbySlide(_gLastSlideID);

}

function setScore(myScore) {
    score = score + parseInt(myScore);
}

function GetUTCTime(now) {
    var utc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());
    return utc;
}