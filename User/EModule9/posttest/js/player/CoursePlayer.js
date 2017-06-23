var disableAll = false;


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
    updatePlaybutton(!this.audioPlayer.paused);
    $('#progress-bar').simpleSlider("setValue", 0);
    Next();
}

CoursePlayer.prototype.SetCurrentTime = function (time) {
    this.audioPlayer.currentTime = time * this.audioPlayer.duration;
}


CoursePlayer.prototype.onProgress = function (e) {
    //document.getElementById("pro").innerText = e.currentTarget.currentTime;
    var minutes = parseInt(Math.floor(e.currentTarget.currentTime / 60));
    var seconds = parseInt(e.currentTarget.currentTime - minutes * 60);
    $('#timeduration').html((minutes < 10 ? '0' : '') + minutes + ":" + (seconds < 10 ? '0' : '') + seconds);

    var slideCount = this.slideIndex;
    var slideTotalsec = this.currentSlide.getAttribute("duration");
    $('#slideduration').html(slideTotalsec);
    var progressbarValue = e.currentTarget.currentTime / e.currentTarget.duration;
    $('#progress-bar').simpleSlider("setValue", progressbarValue);
    $('#slideCount').html('Slides ' + (slideCount + 1) + ' of ' + this.Slides.length);
    var elements = this.elementArray;

    if (e.currentTarget.currentTime == 0)
        return;


    for (var i = 0; i < elements.length; i++) {

        if (parseInt(elements[i].time) < parseInt(e.currentTarget.currentTime)) {
            if (elements[i].type == "text") {
                var index = elements.indexOf(elements[i]);
                var ani = $('#' + this.currentView.id).find('#' + elements[i].id);
                ani.show();
                var effectName = ani.data('class');
                $(ani).textillate({ in: { sync: true, effect: effectName }, autostart: false });
                $(ani).textillate("start");
                elements.splice(index, 1);
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
                elements.splice(index, 1);
            }
            else if (elements[i].type == "disable") {
                disableAll = true;
            }
            else if (elements[i].type == "question") {
                this.pause();
               
                $('#curslide').find('input').show();
            }
            else if (elements[i].type == "graph") {
                document.getElementById(elements[i].id).src = document.getElementById(elements[i].id).src;
                var index = elements.indexOf(elements[i]);
                $("#" + elements[i].id).show();
                elements.splice(index, 1);
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
    if (this.slideIndex < (this.Slides.length - 1)) {
        this.currentSlide = this.Slides[++this.slideIndex];

        this.loadCurrentSlide();

        this.audioPlayer.src = this.currentSlide.getElementsByTagName("audio")[0].getAttribute("src");
        return true;
    }
    return false;
}

CoursePlayer.prototype.loadCurrentSlide = function () {
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
        this.elementArray.push(elementData);
    }
    //onclickShowTranscription($("#"+this.currentView.id).find('#stickyContent'));


}

CoursePlayer.prototype.prevSlide = function () {
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
        document.getElementById("toggelbutton").src = "img/pauseBtn.png";
    }
    else {
        document.getElementById("toggelbutton").src = "img/playBtn.png";
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