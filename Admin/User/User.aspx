<%@ page language="C#" autoeventwireup="true" inherits="User_User, App_Web_ekv2pfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>User</title>
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/site.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" />
	<link href="../css/bootstrap-responsive-theme.css" rel="stylesheet" />
</head>
<body class="BgCover">
   <div class="container">
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
          <!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
          <!--<a class="navbar-brand" href="index.html">Modern Business</a> -->
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
			  <ul class="nav navbar-nav navbar-right">
				<li><a class="block" href="#">Home</a></li>
				<li><a class="block" href="#">My Learning</a></li>
				<li><a class="block" href="#">My Score</a></li>
				<li><a class="block" href="#">Tech Support</a></li>
				<li><a class="block" href="#">Log out</a></li>            
			  </ul>
			</div><!-- /.navbar-collapse -->
		</nav>
	</div><!-- /.container -->
    <div class="container" style="margin-top: 15%;">
		<div class="row" style="background-color: rgba(201, 225, 229, 0.5); border-radius: 30px;padding-right:0.5%;">
			<div class="row text-center">
				<div class="col-lg-3 col-md-6 hero-feature">
					<div class="container">
						<div class="row-fluid">
							<div class="span3 thumb-list learnBox"> 
								<img src="../img/learning.jpg" style="height:96px;width:80px;" alt="" />
								<br />
								<h4 style="margin-top:16px;padding-right:20px;;">MY LEARNING</h4>
							</div>
						</div>
					</div>
					<div class="thumbnail" style="border-right:1px dashed black;">
						<div class="caption">
							<p>
								Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
									euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
							</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 hero-feature">
					<div class="container">
						<div class="row-fluid">
							<div class="span3 thumb-list learnBox"> 
								<img src="../img/score.jpg" style="height:96px;width:80px;" alt="" />
								<br />
								<h4 style="margin-top:16px;padding-right:20px;;">MY SCORE</h4>
							</div>
						</div>
					</div>
					<div class="thumbnail">
						<div class="caption">
							<p>
								Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
									euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
							</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 hero-feature">
					<div class="container">
						<div class="row-fluid">
							<div class="span3 thumb-list learnBox"> 
								<img src="../img/links.jpg" style="height:96px;width:80px;" alt="" />
								<br />
								<h4 style="margin-top:16px;padding-right:20px;;">QUICK LINKS</h4>
							</div>
						</div>
					</div>
					<div class="thumbnail">
						<div class="caption">
							<p>
								Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
									euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
							</p>
						</div>
					</div>
				</div>
			   <div class="col-lg-3 col-md-6 hero-feature">
					<div class="container">
						<div class="row-fluid">
							<div class="span3 thumb-list learnBox"> 
								<img src="../img/board.jpg" style="height:96px;width:80px;" alt="" />
								<br />
								<h4 style="margin-top:16px;padding-right:20px;;">NOTICE BOARD</h4>
							</div>
						</div>
					</div>
					<div class="thumbnail">
						<div class="caption">
							<p>
								Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
									euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
							</p>
						</div>
					</div>
				</div>
			</div>
			<!-- /.row -->
		</div>
	</div>
    <div class="container">
        <hr />
        <footer>
        <div class="row">
          <div class="col-lg-12">
            <p></p>
          </div>
        </div>
      </footer>
    </div>
    <!-- /.container -->
    <!-- JavaScript -->

    <script src="../js/jquery-1.10.2.js"></script>

    <script src="../js/bootstrap.js"></script>

    <script src="../js/site.js"></script>

</body>
</html>
