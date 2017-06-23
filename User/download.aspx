﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="download.aspx.cs" Inherits="download" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Download Page</title>
		<link rel="stylesheet" href="css/common.css" />
		<link rel="stylesheet" href="css/sliding.css" type="text/css" media="screen" />
		<style type="text/css">

			.myButton {
                border: none;
			-moz-box-shadow: 0px 10px 14px -7px #276873;
			-webkit-box-shadow: 0px 10px 14px -7px #276873;
			box-shadow: 0px 10px 14px -7px #276873;

			background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
			background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
			background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
			background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
			background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
			background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);

			background-color:#599bb3;

			-moz-border-radius:8px;
			-webkit-border-radius:8px;
			border-radius:8px;

			display:inline-block;
			color:#ffffff;
			font-family:arial;
			font-size:18px;
			font-weight:bold;
			padding:13px 32px;
			text-decoration:none;

			text-shadow:0px 1px 0px #3d768a;

			}
			.myButton:hover {

			background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
			background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
			background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
			background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
			background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
			background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);

			background-color:#408c99;
			}
			.myButton:active {
			position:relative;
			top:1px;
			}


		</style>
</head>
<body style=" padding: 0px; background: url(img/bg.png) no-repeat; width: 1024px;">
    <form id="form1" runat="server">
    <div align="center" style="  margin:0 auto; padding:50px;" >

		<h3>Download Adcetris Training App</h3>
				<br/>
        <asp:Button ID="Button1" runat="server" CssClass="myButton" Text="Download App" OnClick="Button1_Click" />

			</div>
    </form>
</body>
</html>