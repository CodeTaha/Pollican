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
        
      
       
    //    $("#SignUp").hide();
        $("#alert_box").hide();
        /*$("#dob").datepicker({
          
           dateFormat:"mm/dd/yy" 
                   });*/
   
      //  $('#dob').datepicker();
          
                                                     
    
    });
     window.fbAsyncInit = function() {
    FB.init({
      appId      : '555702664544677', // App ID
       status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });
    
    
	FB.Event.subscribe('auth.authResponseChange', function(response) 
	{
 	 if (response.status === 'connected') 
  	{
  		//getUserInfo();
  		
  	}	 
	else if (response.status === 'not_authorized') 
    {
    	//document.getElementById("message").innerHTML +=  "<br>Failed to Connect";

		//FAILED
    } else 
    {
    	//document.getElementById("message").innerHTML +=  "<br>Logged Out";

    	//UNKNOWN ERROR
    }
	});	
	
    };
    
   	function Login()
	{
	
		FB.login(function(response) {
		   if (response.authResponse) 
		   {
		    	getUserInfo();
  			} else 
  			{
  	    	 console.log('User cancelled login or did not fully authorize.');
   			}
		 },{scope: 'email,user_location,user_hometown,user_birthday,user_friends,user_interests'});
	}
function Logout()
	{
		FB.logout(function(){document.location.reload();});
	}

  // Load the SDK asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
  
    
    function getUserInfo() {
	    FB.api('/me', function(response) {
  
 
  console.log('response');
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
 //profile_pic=response.data.url;
 
 FB.api('/me/picture?type=normal', function(response) {
                  profile_pic=response.data.url;
               
               //   $("#dp").empty().append("<img src='"+profile_pic+"'/>");
    });

  	$.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "loginFB",
                                data: {username:username, password:email},
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
                                           // $("#SignUp").show();
                                          //  cat_json=JSON.parse(data);
                                            /*document.getElementById("email").value =email;
                                            document.getElementById("email").readOnly = true;
                                            document.getElementById("dob").value =birthdate;
                                            document.getElementById("dob").readOnly = true;  */
                                           // document.getElementById("name").value=name; 
                                          //  document.getElementById("name").readOnly=true;
                                          /*  if(gender=='female')
                                            {
                                                $("#sex_f").attr('checked', 'checked');
                                                
                                                
                                            }
                                            else
                                            {
                                                $("#sex_m").attr('checked', 'checked');
                                                
                                            }
                                           // document.getElementById("gender").readOnly=true;
                                            $("#sex_f").attr('disabled', 'disabled');
                                            $("#sex_m").attr('disabled', 'disabled'); */
                                            //console.log(cat_json);
                                           
                                          /*    for(var i=0; i<cat_json.length; i++)
                                                        {
                                                            cat_list.push({id:cat_json[i]['cid'], text:cat_json[i]['category_name']});
                                                            $("#category").append("<option value="+cat_json[i]['cid']+">"+cat_json[i]['category_name']+"</option>");
                                                        }
                                                       
                                           */
                                            // get_accordion();
                                          //     window.location.assign("signUp1");      
                                          document.getElementById("resname").value=response.name;
                                          document.getElementById("resusername").value=response.username;
                                          document.getElementById("resuserid").value=response.id;
                                          document.getElementById("resemail").value=response.email;
                                          document.getElementById("reslink").value=response.link;
                                          document.getElementById("resbirthdate").value=response.birthday;
                                          document.getElementById("resgender").value=response.gender;
                                          document.getElementById("resdp").value=profile_pic;
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
    }
	function get_accordion()
     {  for(var i=0; i<cat_json.length;i++)
        { if( array2.indexOf(cat_json[i]['group'])===-1)
            {
                array2.push(cat_json[i]['group']);
                array3[cat_json[i]['group']]=new Array();
                array3[cat_json[i]['group']].push(cat_json[i]);
            }
          else
          {
               array3[cat_json[i]['group']].push(cat_json[i]);   
          }  
        }
        console.log('arrays');
        console.log(array2);
        console.log(array3);
    $("#accordion").empty();
        for(var i=0;i<array2.length;i++)
       { $("#accordion").append("<h3>"+array2[i]+"</h3><div id='cat_"+i+"'></div>");
        
        for(var j=0;j<array3[array2[i]].length;j++)
        {
            $("#cat_"+i).append("<input class='cat_checkbox' type='checkbox' id='"+array3[array2[i]][j].cid +" 'value='"+array3[array2[i]][j].cid+"'>"+array3[array2[i]][j].category_name+"&nbsp;&nbsp;");
        }
          
       }
        $("#accordion").accordion({
      heightStyle: "fill"
    });
    $( "#accordion-resizer" ).resizable({
      minHeight: 70,
      minWidth: 200,
      maxHeight:130,
      resize: function() {
        $( "#accordion" ).accordion( "refresh" );
      }
    });
    $('.cat_checkbox').click(function() {//for checkbox
       
    var mcCbxCheck = $(this);
    //console.log(mcCbxCheck.val())
    if(mcCbxCheck.is(':checked')) {
        if(cat_list.length<20)
        {
        addRemoveList(mcCbxCheck.val(),1);
        }
        else
        { Alerts('alert-danger',"You can select maximum of 20 categories");
            return false;}
    
    }
    else{
       addRemoveList(mcCbxCheck.val(),0);
        
    }
        });
       $( "#accordion_div" ).hide(); 
     }
     
     
    
    function addRemoveList(cat_id,addRemove)
    {
        if(addRemove==1)
        {
           cat_list.push(parseInt(cat_id));
        }
        else
        {
             cat_list.splice(cat_list.indexOf(cat_id), 1);
        }
        
    }
    
    function select_categories()
    {
       handle=$("#handle").val();
       name=$("#name").val();
       email_i=$("#email").val();;
       country="";//$("#country").val();
       state="";//$("#state").val();
       city="";//$("#city").val();
       zip="";//$("#zip").val();
       religion="";
       sex=$('input[name=sex]:checked').val();
       dob=$("#dob").val();
       phone=$("#phone").val();
        if(handle==null || handle==''|| name==null||name=='')
      {alert();
          return;
      }
        
        $("#signUpForm").hide();
        $("#accordion_div").show();
    }
   
   function validate()
  {
      
      //var profile_pic=$("#profile_pic").val();
      var category;//$("#category").val();
      for(var i=0; i<cat_list.length; i++)
      {if(i==0)
          {category="["+cat_list[i];}
       else
       {
          category=category+","+cat_list[i];
      }
      }
      fb=username;// Enter fb username here//it was testfb earlier
      
      category=JSON.stringify(category+"]");
      category=JSON.stringify(cat_list);
      console.log(category);
      var tmp1;
      if(red_url!=="" && red_url.indexOf("red_url")!==-1)
                                                {

                                                    var tmp=red_url.split("=");
                                                   tmp1=tmp[1];
                                                }
                                            else
                                                {
                                                    tmp1='dashboard';
                                                }
      
     $("body").append("<form id='final_form' action='SignUpReg' method='POST'>\n\
                        <input type='hidden' name='handle' value='"+handle+"'/>\n\\n\
        <input type='hidden' name='name' value='"+name+"'/>\n\\n\
        <input type='hidden' name='email' value='"+email_i+"'/>\n\\n\
        <input type='hidden' name='country' value='"+country+"'/>\n\\n\
        <input type='hidden' name='state' value='"+state+"'/>\n\\n\
        <input type='hidden' name='city' value='"+city+"'/>\n\\n\
        <input type='hidden' name='zip' value='"+zip+"'/>\n\\n\
        <input type='hidden' name='religion' value='"+religion+"'/>\n\\n\
        <input type='hidden' name='sex' value='"+sex+"'/>\n\
        <input type='hidden' name='dob' value='"+dob+"'/>\n\
        <input type='hidden' name='phone' value='0'/>\n\
        <input type='hidden' name='category' value='"+category+"'/>\n\
        <input type='hidden' name='profile_pic' value='"+profile_pic+"'/>\n\\n\
        <input type='hidden' name='fb' value='"+fb+"'/>\n\\n\\n\
        <input type='hidden' name='red' value='"+tmp1+"'/>\n\
        <input type='submit' id='final_submit'/>\n\
                        </form>");
        $("#final_form").hide();
        $("#final_submit").click();
      /*$.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "SignUpReg",
                                data: {handle:handle,name:name,email:email_i,country:country,state:state,city:city,zip:zip,religion:religion,sex:sex,dob:dob,phone:phone,category:category,profile_pic:profile_pic , fb:fb},
                                success: function(data){
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
                        });*/
  }
  function SignUp()
  {
      fb="";
      profile_pic="pages/profile_pics/egg.jpg";
    $("#SignUp").show();
      $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "getCategories",
                                data: {},
                                success: function(data){
                                    console.log(data);
                                    cat_json=JSON.parse(data);
                                    get_accordion();
                                }});
                                          
                                
      //Alerts('alert-warning','<strong>Sorry for the inconvenience!</strong>As we are currently developing our system and we want to keep scamters away. Please use <strong>Facebook login</strong>');
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
              <button class="btn btn-facebook" onclick="Login()" id='fb_login_btn'><i class="fa fa-facebook"></i> | Connect with Facebook</button>
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
