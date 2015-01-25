<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controllers.Parent_Controller"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Parent_Controller pc=new Parent_Controller();
    boolean foundCookie = false;
    foundCookie=pc.checklogin(request);
    if(foundCookie)
    {
        response.sendRedirect("dashboard");
        //request.getRequestDispatcher("dashboard").forward(request, response);
    }
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Pollican</title>
        <link rel="icon" href="pages/resources/img/logo.png" type="image/png" sizes="16x16">
         <link href="pages/resources/select2/select2.css" rel="stylesheet"/>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui-timepicker-addon.css" >
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/select2/select2.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui.js"></script>
        <!--<script type="text/javascript" src="pages/resources/js/jquery-ui-timepicker-addon.js"></script>-->
        <script src="pages/resources/template/js/bootstrap.min.js"></script>
        
        <link href="pages/resources/template/css/bootstrap.css" rel="stylesheet">
        <link href="pages/resources/template/font-awesome-4.1.0/css/font-awesome.css" rel="stylesheet">
        <link href="pages/resources/template/css/social-buttons.css" rel="stylesheet">
        <script type="text/javascript">
var name;
var username;
var userid;
var email;
var link; 
var birthdate;
var profile_pic;
var gender;
 var cat_json="";
 var fb;
 var cat_list=new Array();// maintains list for categories
 var red_url=window.location.search.replace("?", "").toString();
 var cat_list=new Array();
   var array2 = new Array();
            var array3 = new Object();
    $(document).ready(function(){
        
        $("#alert_box").hide();
    });//555702664544677
    // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
       Alerts('alert-warning','Please log into APP');;
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      Alerts('alert-warning','Please log into fb');
     
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '555702664544677',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.1' // use version 2.1
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  /* uncomment when redirecting a user without login
   * FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });*/

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      console.log(response)
      Alerts('alert-success"',response.name);
      
    });
  }
function Login()
	{
            FB.login(function(response) {
               if (response.status === 'connected') {
            
            getUserInfo(response);
           
               
             } else if (response.status === 'not_authorized') {
               alert(2)
             } else {
               // The person is not logged into Facebook, so we're not sure if
               // they are logged into this app or not.
             }
            }, {scope: 'public_profile,email,user_location,user_hometown,user_birthday,user_friends,user_interests'});
        }	
     
  function getUserInfo(response1) {
        var auth_response=response1;
	FB.api('/me', function(response) {
                
                    console.log('response');
                     console.log(auth_response);
                      console.log(response);

                        console.log('responseend');
                   name = response.name;
                   username=response.username;
                   userid = response.id;
                   email = response.email;
                   link = response.link; 
                   birthdate = response.birthday;
                   gender=response.gender;
                   fb=username;
                   var fb_response=response;
                   //profile_pic=response.data.url;
                   FB.api('/me/picture?type=normal', function(response) {
                       
                                    profile_pic=response.data.url;
                                    
                                var auth1=auth_response.authResponse.accessToken;
                                console.log(profile_pic);
                                console.log(auth1);
                                        $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "loginFB",
                                data: {username:username, password:email,fb_response:JSON.stringify(fb_response),auth_token:auth1,profile_pic:profile_pic},
                                success: function(data){//alert(data);
                                        if(data==1)
                                        {
                                            if(red_url!=="" && red_url.indexOf("red_url")!==-1)
                                                {

                                                    var tmp=red_url.split("=");
                                                   window.location.assign(tmp[1]);
                                                }
                                            else
                                                {
                                                    window.location.assign("dashboard");
                                                }
                                           
                                           
                                        }
                                       
                                     
                                        else
                                        {
                                          
                                           
                                          if(red_url!=="" && red_url.indexOf("red_url")!==-1)
                                                {

                                                    var tmp=red_url.split("=");
                                                    document.getElementById("resred_url").value=tmp[1];
                                                   
                                                }
                                          else
                                                {
                                                    document.getElementById("resred_url").value="";
                                                }
                                          
                                           // $("#f1").append("<input type='hidden' name='response' value='"+response+"'");
                                           document.getElementById("resp").value=JSON.stringify(response);
                                            document.f1.submit();
                                        }
                                        
                                }
                        });
          
                      });
              
    });
    }
  function Alerts(alert_type,alert_mesg)
  {
       $("#alert_box").empty().append("<div class='bs-example' ><div class='alert "+alert_type+"'><a href='#' class='close' data-dismiss='alert'>&times;</a>"+alert_mesg+"</div></div>").show();
  }
 // document.getElementById()
 function directLogin(lid)
 {
     
     var direct_username=$("#login_username"+lid).val();
     var direct_pwd=$("#login_pwd"+lid).val();
        
     $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "directLogin",
                                data: {username:direct_username, password:direct_pwd},
                                success: function(data){//alert(data);
                                    console.log(data);
                                        if(data==1)
                                        {
                                            if(red_url!=="" && red_url.indexOf("red_url")!==-1)
                                                {

                                                    var tmp=red_url.split("=");
                                                   window.location.assign(tmp[1]);
                                                }
                                            else
                                                {
                                                    window.location.assign("dashboard");
                                                }
                                           return true;
                                           
                                        }
                                        else
                                        {
                                            Alerts('alert-danger',"Your handle/email OR Password is incorrect. If you have forgotten your handle OR password, please login through Facebook");
                                            return false;
                                        }
                                    }
                                });
                                       
 }
 
</script>
        <style>
             #accordion-resizer {
    padding: 10px;
    width: 150px;
    height: 120px;
  }
  .slide1, .slide2, .slide3 {
	min-height: 560px; /* Must have a height or min-height set due to use of background images */
	background-size: cover;
	background-position: center center;
}
.slide1 {
	background-image: url(${delimiter}pages/resources/img/slide1.png);
}
.slide2 {
        background-image: url(${delimiter}pages/resources/img/slide2.png);
}
.slide3 {
	background-image: url(${delimiter}pages/resources/img/slide3.png);
}
/* Carousel Fade Effect */
.carousel.carousel-fade .item {
	-webkit-transition: opacity 1s linear;
	-moz-transition: opacity 1s linear;
	-ms-transition: opacity 1s linear;
	-o-transition: opacity 1s linear;
	transition: opacity 1s linear;
	opacity: .5;
}
.carousel.carousel-fade .active.item {
	opacity: 1;
}
.carousel.carousel-fade .active.left,
.carousel.carousel-fade .active.right {
	left: 0;
	z-index: 2;
	opacity: 0;
	filter: alpha(opacity=0);
}
/* Carousel Overlay */
.carousel-overlay {
	position: absolute;
	bottom: 200px;
	right: 0;
	left: 0;
}

        </style>
        
    </head>

    <body>
        
        <div id='alert_box'>
        
        </div>
        <nav class="navbar navbar-inverse">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>                        
          </button>
         <img src="pages/resources/img/logo.png" style="width: 45px;height: 45px;margin-left: 35px;padding-top: 5px;"/>
                <a class="navbar-brand" href="index"  style="width:50px; height:50px;">Pollican</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
         
          <ul class="nav navbar-nav navbar-right">
              <!--<li>
                 
                   <img src="pages/resources/img/fbconnect.png" style="cursor:pointer; width: 130px;height: 40px;margin-top: 5px;" onclick="Login()" id='fb_login_btn'/>
              </li>-->
              <li>
                  
                  <form class="navbar-form navbar-right" role="form" action="#" onsubmit="return directLogin(1)">
            <div class="form-group">
              <!--<button class="btn btn-facebook" onclick="Login()" id='fb_login_btn'><i class="fa fa-facebook"></i> | Connect with Facebook</button>-->
            </div>
            <div class="form-group">
              <input type="text" class="form-control" id="login_username1" placeholder="Handle/e-mail id">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" id="login_pwd1" placeholder="Password">
            </div>
            <button type="submit" class="btn btn-success">Sign in</button>
          </form>
              </li>
            <!--  
              <li>
                    <button type="button" class="btn btn-primary" style="margin-top: 9px;" onclick="SignUp()">Sign-up</button>
              </li>
            -->  
          </ul>
        </div>
      </div>
    </nav>
    <!--<div class="jumbotron">
      <div class="container">
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><button class="btn btn-facebook" onclick="Login()" id='fb_login_btn'><i class="fa fa-facebook"></i> | Connect with Facebook</button></p>
      </div>
    </div>-->
    <!--begin bg-carousel-->
<div id="bg-fade-carousel" class="carousel slide carousel-fade" data-ride="carousel">
<!-- Wrapper for slides -->
    <div class="carousel-inner">
        <div class="item active">
            <div class="slide1"></div>
        </div>
        <div class="item">
            <div class="slide2"></div>
        </div>
        <div class="item">
            <div class="slide3"></div>
        </div>
    </div><!-- .carousel-inner --> 
    <div class="container carousel-overlay text-center">
        <h1 style="color: #1c1b1e;">Create Polls/Surveys, Get Answers, Take the Right Decisions</h1>
        <h2 style="color: #1c1b1e;">It's Absolutely Free!</h2>
        <button class="btn btn-facebook btn-lg" onclick="Login()" id='fb_login_btn2'><i class="fa fa-facebook"></i> | Connect with Facebook</button>
        
     
    </div>
</div><!-- .carousel --> 
<!--end bg-carousel-->

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
            <h2>Login/Sign-in</h2>
           <form role="form" action="#" onsubmit="return directLogin(0)">
            <div id="loginForm" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-5" for="name">Handle/email-ID:</label>
                    <div class="col-sm-7">
                    <input type="text" class="form-control" id="login_username0" placeholder="Enter your Handle or e-mail id">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="pwd">Password:</label>
                    <div class="col-sm-7">
                    <input type="password" class="form-control" id="login_pwd0" placeholder="Enter Your password">
                    </div>
                </div>
                <div class="form-group">
                   
                    <div class="col-sm-12">
                        <button type="submit" class="btn btn-success  pull-right">Sign in</button>
                    </div>
                </div>
                
            </div>
             </form> 
        </div>
       
      </div>

      <hr>
    </div>
   
   
<form name="f1" style="visibility: hidden" method="post" action="register1" id="f1">
    <input type="hidden" id="resp" name="resp" >
            <input type="text" id="resname" name="response_name" >
            <input type="text" id="resusername" name="response_username" >
            <input type="text" id="resuserid" name="response_userid" >
               <input type="text" id="resdp" name="response_dp" >
               <input type="text" id="resred_url" name="response_red_url" >
         
            <input type="text" id="resemail" name="response_email" >
            <input type="text" id="reslink" name="response_link" >
            <input type="text" id="resbirthdate" name="response_birthdate" >
            <input type="text" id="resgender" name="response_gender" >-->
            <input type="submit" value="submit"  style="font-size:18px; " />
        </form>
    </body>
</html>
