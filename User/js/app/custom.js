﻿function GetEmailID(){var e=document.getElementById("TextAccessToken").value,t=g_UserService.GetEmailID(e);null!=t&&1==t?(document.getElementById("getDetails").style.display="none",$("#TextAccessToken").prop("readonly",!0),defaultSelect(),ShowRegDetails()):(alert("Invalid access code"),HideRegDetails())}function GetEmailIDIE(){var e=document.getElementById("TextAccessTokenIE").value,t=g_UserService.GetEmailID(e);null!=t&&1==t?($("#TextAccessTokenIE").prop("readonly",!0),document.getElementById("accessToken").style.display="none",document.getElementById("registerDetails").style.display="block",document.getElementById("activate").style.display="block",document.getElementById("regMsg").style.display="block",document.getElementById("getAccessDetails").style.display="none",document.getElementById("redirect").style.display="none",defaultSelect()):(alert("Invalid access code"),document.getElementById("accessToken").style.display="block",document.getElementById("registerDetails").style.display="none",document.getElementById("activate").style.display="none",document.getElementById("regMsg").style.display="none",document.getElementById("getAccessDetails").style.display="block",document.getElementById("redirect").style.display="block")}function HideRegDetails(){document.getElementById("regDetails").style.display="none",document.getElementById("loginMsg").style.display="none",document.getElementById("accessContent").style.display="block",document.getElementById("registerContent").style.display="none"}function ShowRegDetails(){document.getElementById("regDetails").style.display="block",document.getElementById("accessContent").style.display="none",document.getElementById("registerContent").style.display="block",document.getElementById("modalTitle").innerHTML="Activate your account"}function LoadPlayer(){/ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase()),/android/i.test(navigator.userAgent.toLowerCase()),/blackberry/i.test(navigator.userAgent.toLowerCase()),/windows/i.test(navigator.userAgent.toLowerCase())}function ShowPlayer(e){var t="width="+screen.width;t+=", height="+screen.height,t+=", top=0, left=0",t+=", status=no",t+=", fullscreen=yes",t+=", resizable=no",window.open(e,"newWindow",t)}function ShowHome(){document.getElementById("homeTabs").style.display="block",document.getElementById("BackButton").style.display="none",document.getElementById("newUpdates").style.display="none",document.getElementById("welcome").style.display="block",document.getElementById("titles").style.display="none",document.getElementById("texts").style.display="none"}function ShowUpdates(){document.getElementById("homeTabs").style.display="none",document.getElementById("BackButton").style.display="block",document.getElementById("newUpdates").style.display="block",document.getElementById("welcome").style.display="none",document.getElementById("titles").style.display="block",document.getElementById("texts").style.display="block"}function AuthenticateUser(){var e,t,n=window.navigator.userAgent,i=n.indexOf("MSIE "),o=n.indexOf("Trident/");i>0&&(e=document.getElementById("LoginIEUsername").value,t=document.getElementById("LoginIEPassword").value),o>0?(e=document.getElementById("LoginIEUsername").value,t=document.getElementById("LoginIEPassword").value):(e=document.getElementById("LoginUsername").value,t=document.getElementById("LoginPassword").value);var s=g_UserService.AuthenticateUser(e,t);return parseInt(s.UserID)>0?!0:(document.getElementById("loginMsg").style.display="block",document.getElementById("InvalidMsg").style.display="block",!1)}function IsUsernameExist(e){var t=g_UserService.IsUsernameExist(e.val());return t?"Username already taken by someone":void 0}function PopulateStatesOfCountry(e){var t=document.getElementById("DDRegion");t.options.length=0,regionList=g_UserService.GetStatesOfCountry(parseInt(e));for(var n=0;n<regionList.length;n++)if("Others"!=regionList[n].State){var i=document.createElement("option");i.innerHTML=regionList[n].State,i.value=regionList[n].State_Id,t.appendChild(i)}var i=document.createElement("option");i.innerHTML="Others",i.value=1,t.appendChild(i)}function PopulateCityOfStates(e){var t=$(e).val(),n=document.getElementById("DDCity");if(n.options.length=0,cityList=g_UserService.GetCityofState(parseInt(t)),cityList.length>0){$("#StateID").val(parseInt(t)),$("#CityID").val(parseInt(cityList[0].City_Id));for(var i=0;i<cityList.length;i++)if("Others"!=cityList[i].City){var o=document.createElement("option");o.innerHTML=cityList[i].City,o.value=cityList[i].City_Id,n.appendChild(o)}}var o=document.createElement("option");o.innerHTML=$("#"+e.id+" option:selected").html(),o.value=$(e).val(),n.appendChild(o)}function PopulateStatesOfCountryIE(e){var t=document.getElementById("DDRegionIE");t.options.length=0,regionList=g_UserService.GetStatesOfCountry(parseInt(e));for(var n=0;n<regionList.length;n++)if("Others"!=regionList[n].State){var i=document.createElement("option");i.innerHTML=regionList[n].State,i.value=regionList[n].State_Id,t.appendChild(i)}var i=document.createElement("option");i.innerHTML="Others",i.value=1,t.appendChild(i)}function PopulateCityOfStatesIE(e){var t=$(e).val(),n=document.getElementById("DDCityIE");if(n.options.length=0,cityList=g_UserService.GetCityofState(parseInt(t)),cityList.length>0){$("#StateID").val(parseInt(t)),$("#CityID").val(parseInt(cityList[0].City_Id));for(var i=0;i<cityList.length;i++)if("Others"!=cityList[i].City){var o=document.createElement("option");o.innerHTML=cityList[i].City,o.value=cityList[i].City_Id,n.appendChild(o)}}var o=document.createElement("option");o.innerHTML=$("#"+e.id+" option:selected").html(),o.value=$(e).val(),n.appendChild(o)}function preLoadImages(){loadImages("img/menu/menu0001.jpg","img/menu/menu0002.jpg","img/menu/menu0003.jpg","img/menu/menu0004.jpg","img/menu/menu0005.jpg","img/menu/menu0006.jpg","img/menu/menu0007.jpg","img/menu/menu0008.jpg","img/menu/menu0009.jpg","img/menu/menu0010.jpg","img/menu/menu0011.jpg","img/menu/menu0012.jpg","img/menu/menu0013.jpg","img/menu/menu0014.jpg","img/menu/menu0014.jpg","img/welcome/ADCetris_Welcome_00000.jpg","img/welcome/ADCetris_Welcome_00001.jpg","img/welcome/ADCetris_Welcome_00002.jpg","img/welcome/ADCetris_Welcome_00003.jpg","img/welcome/ADCetris_Welcome_00004.jpg","img/welcome/ADCetris_Welcome_00005.jpg","img/welcome/ADCetris_Welcome_00006.jpg","img/welcome/ADCetris_Welcome_00007.jpg","img/welcome/ADCetris_Welcome_00008.jpg","img/welcome/ADCetris_Welcome_00009.jpg","img/welcome/ADCetris_Welcome_00010.jpg","img/welcome/ADCetris_Welcome_00011.jpg","img/welcome/ADCetris_Welcome_00012.jpg","img/welcome/ADCetris_Welcome_00013.jpg","img/welcome/ADCetris_Welcome_00014.jpg","img/accesscode/ADCetris_AccessCode_00000.jpg","img/accesscode/ADCetris_AccessCode_00001.jpg","img/accesscode/ADCetris_AccessCode_00002.jpg","img/accesscode/ADCetris_AccessCode_00003.jpg","img/accesscode/ADCetris_AccessCode_00004.jpg","img/accesscode/ADCetris_AccessCode_00005.jpg","img/accesscode/ADCetris_AccessCode_00006.jpg","img/accesscode/ADCetris_AccessCode_00007.jpg","img/accesscode/ADCetris_AccessCode_00008.jpg","img/accesscode/ADCetris_AccessCode_00009.jpg","img/accesscode/ADCetris_AccessCode_00010.jpg","img/accesscode/ADCetris_AccessCode_00011.jpg","img/accesscode/ADCetris_AccessCode_00012.jpg","img/accesscode/ADCetris_AccessCode_00013.jpg","img/accesscode/ADCetris_AccessCode_00014.jpg","img/signin/ADCetris_SignIn_00000.jpg","img/signin/ADCetris_SignIn_00001.jpg","img/signin/ADCetris_SignIn_00002.jpg","img/signin/ADCetris_SignIn_00003.jpg","img/signin/ADCetris_SignIn_00004.jpg","img/signin/ADCetris_SignIn_00005.jpg","img/signin/ADCetris_SignIn_00006.jpg","img/signin/ADCetris_SignIn_00007.jpg","img/signin/ADCetris_SignIn_00008.jpg","img/signin/ADCetris_SignIn_00009.jpg","img/signin/ADCetris_SignIn_00010.jpg","img/signin/ADCetris_SignIn_00011.jpg","img/signin/ADCetris_SignIn_00012.jpg","img/signin/ADCetris_SignIn_00013.jpg","img/signin/ADCetris_SignIn_00014.jpg","img/support/ADCetris_TechSupport_00000.jpg","img/support/ADCetris_TechSupport_00001.jpg","img/support/ADCetris_TechSupport_00002.jpg","img/support/ADCetris_TechSupport_00003.jpg","img/support/ADCetris_TechSupport_00004.jpg","img/support/ADCetris_TechSupport_00005.jpg","img/support/ADCetris_TechSupport_00006.jpg","img/support/ADCetris_TechSupport_00007.jpg","img/support/ADCetris_TechSupport_00008.jpg","img/support/ADCetris_TechSupport_00009.jpg","img/support/ADCetris_TechSupport_00010.jpg","img/support/ADCetris_TechSupport_00011.jpg","img/support/ADCetris_TechSupport_00012.jpg","img/support/ADCetris_TechSupport_00013.jpg","img/support/ADCetris_TechSupport_00014.jpg")}function loadImages(){for(var e=new Array,t=0;t<loadImages.arguments.length;t++)e[t]=new Image,e[t].src=loadImages.arguments[t]}function Loading(){document.getElementById("loading").style.display="block",HideRegDetails(),animateMenu(),document.getElementById("loading").style.display="none",document.getElementById("screen").style.display="block"}function InsertCountries(){for(var e=document.getElementById("country"),t=0;t<e.length;t++)g_UserService.InsertCountries(e.options[t].value,e.options[t].text);alert("All were inserted")}function InsertStates(){for(var e=document.getElementById("province"),t=document.getElementById("country"),n=t.options[t.selectedIndex].value,i=0;i<e.length;i++)g_UserService.InsertStates(e.options[i].value,n,e.options[i].text);alert("All were inserted")}function InsertCities(){for(var e=document.getElementById("region"),t=document.getElementById("country"),n=document.getElementById("province"),i=t.options[t.selectedIndex].value,o=n.options[n.selectedIndex].value,s=0;s<e.length;s++)g_UserService.InsertCities(e.options[s].value,e.options[s].text,o,i);alert("All were inserted")}function ShowRegIE(){document.getElementById("forIELogin").style.display="none",document.getElementById("forIEReg").style.display="block",document.getElementById("forIEPwd").style.display="none",document.getElementById("forIETech").style.display="none"}function ShowSupportIE(){document.getElementById("forIELogin").style.display="none",document.getElementById("forIEReg").style.display="none",document.getElementById("forIEPwd").style.display="none",document.getElementById("forIETech").style.display="block"}function ForgotPassword(){document.getElementById("forIELogin").style.display="none",document.getElementById("forIEReg").style.display="none",document.getElementById("forIEPwd").style.display="block",document.getElementById("forIETech").style.display="none"}function CheckMailAndCode(){var e=$("#TextAccessToken").val(),t=$("#TextEMailID").val(),n=g_UserService.CheckMailAndCode(e,t);return null!=n&&0==n[0].Column1?!0:(document.getElementById("registerMessage").style.display="block",!1)}function CheckMailAndCodeIE(){var e=$("#TextAccessTokenIE").val(),t=$("#TextEMailIDIE").val(),n=g_UserService.CheckMailAndCode(e,t);return null!=n&&0==n[0].Column1?!0:(document.getElementById("registerMessageIE").style.display="block",!1)}function ShowWelcomeMsgIE(){$("#welcome-form").modal("show")}function IsEmailExist(e){var t;t="IE"==e?$("#TextFpwd").val():$("#TextEmail").val();var n=g_UserService.IsEmailExist(t);return n?!0:("IE"==e?(document.getElementById("notExistIE").style.display="block",document.getElementById("notExistIE").innerHTML="Mail Id doesn't exist"):(document.getElementById("notExist").style.display="block",document.getElementById("notExist").innerHTML="Mail Id doesn't exist"),!1)}function defaultSelect(){$("#DDCountry").prepend("<option value='' selected>--Select Country--</option>"),$("#DDRegion").prepend("<option value='' selected>--Select State--</option>"),$("#DDCity").prepend("<option value='' selected>--Select City--</option>"),$("#DDCountryIE").prepend("<option value='' selected>--Select Country--</option>"),$("#DDRegionIE").prepend("<option value='' selected>--Select State--</option>"),$("#DDCityIE").prepend("<option value='' selected>--Select City--</option>")}function SetCityID(e){var t;if("IE"==e){var n=document.getElementById("DDCityIE");t=n.options[n.selectedIndex].value}else{var n=document.getElementById("DDCity");t=n.options[n.selectedIndex].value}$("#CityID").val(parseInt(t))}var g_UserService=new UserService;preLoadImages();