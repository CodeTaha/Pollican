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
        <title>Welcome to PollingDuck project</title>
         <link href="pages/resources/select2/select2.css" rel="stylesheet"/>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui-timepicker-addon.css" >
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/select2/select2.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui.js"></script>
        <!--<script type="text/javascript" src="pages/resources/js/jquery-ui-timepicker-addon.js"></script>-->
        <script src="pages/resources/template/js/bootstrap.min.js"></script>
        <link href="pages/resources/template/css/bootstrap.css" rel="stylesheet">
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
       $("#alert_box").append("<div class='bs-example' ><div class='alert "+alert_type+"'><a href='#' class='close' data-dismiss='alert'>&times;</a>"+alert_mesg+"</div></div>").show();
  }
 // document.getElementById()

</script>
        <style>
             #accordion-resizer {
    padding: 10px;
    width: 150px;
    height: 120px;
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
              <li>
                  
                    <img src="pages/resources/img/fbconnect.png" style="cursor:pointer; width: 130px;height: 40px;margin-top: 5px;" onclick="Login()" id='fb_login_btn'/>
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
    <div class="container-fluid">
        <div class="row">
       <div id="myCarousel" class="col-sm-4 col-md-7 col-lg-8 carousel slide">
   <!-- Carousel indicators -->
   <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
   </ol>   
   <!-- Carousel items -->
   <div class="carousel-inner">
      <div class="item active">
         <img src="pages/resources/images/slide1.jpg" alt="First slide">
      </div>
      <div class="item">
         <img src="pages/resources/images/slide2.gif" alt="Second slide">
      </div>
      <div class="item">
         <img src="pages/resources/images/slide3.gif" alt="Third slide">
      </div>
   </div>
   <!-- Carousel nav -->
   <a class="carousel-control left" href="#myCarousel" 
      data-slide="prev">&lsaquo;</a>
   <a class="carousel-control right" href="#myCarousel" 
      data-slide="next">&rsaquo;</a>
</div>   

        <div class="col-sm-8 col-md-5 col-lg-4">
    <!--        
<div id="SignUp">
    <div id="signUpForm" class="form-horizontal">
        <div class="form-group">
            <div class="col-sm-3 col-md-3 col-lg-4" id="dp"></div>
            <div class="col-sm-9 col-md-9 col-lg-8">
                <div class="input-group">
                <span class="input-group-addon input-group">@</span>
                <input type="text" class="form-control" id="handle" placeholder="handle" required>
                </div>
            
            </div>
        </div>
       <div class="form-group">
            <label class="control-label col-sm-2" for="name">Name:</label>
            <div class="col-sm-10">
            <input type="text" class="form-control" id="name" placeholder="Enter your FullName">
            </div>
        </div>
       <div class="form-group">
            <label class="control-label col-sm-2" for="pwd">Pollican Password:</label>
            <div class="col-sm-10">
            <input type="text" class="form-control" id="pwd" placeholder="Enter a strong password">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="c_pwd">Confirm Password:</label>
            <div class="col-sm-10">
            <input type="text" class="form-control" id="c_pwd">
            </div>
            <div class="col-sm-10" id="showMatch">
                
            </div>
        </div>  
        
        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Email:</label>
            <div class="col-sm-10">
            <input type="email" class="form-control" id="email" placeholder="Enter email">
            </div>
        </div>
        <div class="form-group">
            <div class="radio col-sm-6">
            <label><input type="radio" name="sex" value="M" id='sex_m'>Male</label>
            </div>
            <div class="radio col-sm-6">
            <label><input type="radio" name="sex" value="F" id='sex_f'>Female</label>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="DOB">Date of Birth:</label>
            <div class="well col-sm-10">  
            <button id="btn2" style="float: right">manual set to 03/17/12</button>
            <input type="text" name="dob" class="span2" data-date-format="mm/dd/yy" id="dob"> 
            </div> 
        </div> 
        
            
            
                
             <button class="btn btn-default" onclick="select_categories()">Next</button>
            </div>
<div id='accordion_div'> 
    Please select 20 categories that describes your interests.
<div id="accordion">
    
</div>
<button class="btn btn-default" onclick="validate()">Register</button>
</div>
</div>
            -->
  </div>
</div><!--row -->

</div><!--container -->
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
