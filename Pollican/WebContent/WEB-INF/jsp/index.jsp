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
        
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/select2/select2.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui-timepicker-addon.js"></script>
        <script type="text/javascript">
var name;
var username;
var userid;
var email;
var link; 
var birthdate;
var profile_pic;
 var cat_json="";
 var red_url=window.location.search.replace("?", "").toString();
 var cat_list=new Array();
    $(document).ready(function(){
        
        
       
        $("#SignUp").hide();
        $("#dob").datepicker({
           //showSecond: true,
           //timeFormat: 'hh:mm:ss',
           dateFormat:"mm/dd/yy" 
                   });
    $("#category").select2({
                                                            // multiple: true,
                                                       placeholder:"Select The Categories you are interested in",
                                                       maximumSelectionSize:20
                                                       //allowClear: true,
                                                       //tags: cat_list//[{id: 0, text: 'story'},{id: 1, text: 'bug'},{id: 2, text: 'task'}]
                                                     });  
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
  		document.getElementById("message").innerHTML +=  "<br>Connected to Facebook";
  		//SUCCESS
  		
  	}	 
	else if (response.status === 'not_authorized') 
    {
    	document.getElementById("message").innerHTML +=  "<br>Failed to Connect";

		//FAILED
    } else 
    {
    	document.getElementById("message").innerHTML +=  "<br>Logged Out";

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
		 },{scope: 'email,user_photos,user_videos,user_location,user_hometown,user_birthday'});
	

	
	}

  function getUserInfo() {
	    FB.api('/me', function(response) {

	var str="<b>Name</b> : "+response.name+"<br>";
	  	  str +="<b>Link: </b>"+response.link+"<br>";
	  	  str +="<b>Username:</b> "+response.username+"<br>";
	  	  str +="<b>id: </b>"+response.id+"<br>";
	  	  str +="<b>Email:</b> "+response.email+"<br>";
                  
	  	
                  
	  	  str +="<b>Location:</b> "+response.location.name+"<br>";
                  
	  	  str +="<b>Birthday:</b> "+response.birthday+"<br>";
                  
	  	  str +="<b>Gender:</b> "+response.gender+"<br>";
	  	  str +="<input type='button' value='Get Photo' onclick='getPhoto();'/>";
	  	  str +="<input type='button' value='Logout' onclick='Logout();'/>"; 
 document.getElementById("status").innerHTML=str;  
 document.getElementById("imgbut").innerHTML="";
    
 name = response.name;
 username=response.username;
 userid = response.id;
 email = response.email;
 link = response.link; 
 birthdate = response.birthday;
 //profile_pic=response.data.url;
 FB.api('/me/picture?type=normal', function(response) {
                  profile_pic=response.data.url;
                  
                  document.getElementById("profile_pic").value=profile_pic;
                  $("#dp").append("<img src='"+profile_pic+"'/>")
    });
 
                  


                  
   console.log(name);
    console.log(username);
   console.log(userid);
    console.log(email);
   console.log(link);
    
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
                                            $("#SignUp").show();
                                            cat_json=JSON.parse(data);
                                            document.getElementById("email").value =email;
                                            document.getElementById("email").readOnly = true;
                                            document.getElementById("dob").value =birthdate;
                                            document.getElementById("email").readOnly = true;
                                            document.getElementById("name").value=name;
                                            console.log(cat_json);
                                           
                                              for(var i=0; i<cat_json.length; i++)
                                                        {
                                                            cat_list.push({id:cat_json[i]['cid'], text:cat_json[i]['category_name']});
                                                            $("#category").append("<option value="+cat_json[i]['cid']+">"+cat_json[i]['category_name']+"</option>");
                                                        }
                                                       
                                            
                                                         
                                            
                                        }
                                        
                                }
                        });    
    });
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
   
   function validate()
  {
      var handle=$("#handle").val();
      var name=$("#name").val();
      var email=$("#email").val();
      var country=$("#country").val();
      var state=$("#state").val();
      var city=$("#city").val();
      var zip=$("#zip").val();
      var religion=$("#religion").val();
      var sex=$('input[name=sex]:checked').val();
      var dob=$("#dob").val();
      var phone=$("#phone").val();
      var profile_pic=$("#profile_pic").val();
      var category=$("#category").val();
      var fb=username;// Enter fb username here//it was testfb earlier
      
      category=JSON.stringify(category);
      $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "SignUpReg",
                                data: {handle:handle,name:name,email:email,country:country,state:state,city:city,zip:zip,religion:religion,sex:sex,dob:dob,phone:phone,category:category,profile_pic:profile_pic , fb:fb},
                                success: function(data){alert(data);
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
                        });
  }
</script>

    </head>

    <body>
        
        <div id="status">
 </div>
 <div id="details">
     
 </div>
        <div id="imgbut">
<img src="pages/resources/images/LoginWithFacebook.png" style="cursor:pointer;" onclick="Login()"/>
<br/>
</div>
<br/><br/><br/><br/><br/>
<div id="message">
Logs:<br/>
</div>
<div id="SignUp">
    <div id="signUpForm">
             <h1>Fill Up!</h1>
            <table>
                <tr>
                    <td>Profile <input type="hidden" id="profile_pic" name="profile_pic"/></td></td>
                    <td id="dp"></td>
                </tr>
                <tr>
                    <td>Handle</td>
                    <td><input type="text" id="handle" name="handle"/></td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td><input type="text" id="name" name="name"/></td>
                </tr>
                <tr>
                    <td>Categories</td>
                    <td><select id="category" multiple="multiple" style="width:300px;" tabindex="-1" class="select2-offscreen"></select></td>
                </tr>
                <tr>
                    <td>E-mail</td>
                    <td><input type="text" id="email" name="email"/></td>
                </tr>
                <tr>
                    <td>Country</td>
                    <td><input type="text" id="country" name="country"/></td>
                </tr>
                <tr>
                    <td>State</td>
                    <td><input type="text" id="state" name="state"/></td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><input type="text" id="city" name="city"/></td>
                </tr>
                <tr>
                    <td>Zip</td>
                    <td><input type="text" id="zip" name="zip"/></td>
                </tr>
                <tr>
                    <td>Religion</td>
                    <td><input type="text" id="religion" name="religion"/></td>
                </tr>
                <tr>
                    <td>Sex</td>
                    <td> 
                        <input type="radio"  name="sex" value="M" checked/>Male
                        <input type="radio"  name="sex" value="F"/>Female
                        <input type="radio"  name="sex" value="T"/>Transgender
                        <input type="radio"  name="sex" value="O"/>I do not want to mention
                    </td>
                </tr>
                <tr>
                    <td>Date Of Birth</td>
                    <td></td><td></td><td></td><td></td>
                    <td><input type="text" id="dob" name="dob"/></td>
                </tr>
                <tr>
                    <td>Phone</td>
                    <td><input type="text" id="phone" name="phone"/></td>
                </tr>
               
               
                <tr>
                    <td></td>
                    <td>
                        <button onclick="validate()">Register</button>
                    </td>
                </tr>
            </table>
            </div>
</div>
        <form action="login" method="post">
            User id <input type="text" name="username"><br>
            password <input type="password" name="password">
            <input type="submit"/>
        </form>
        
        <a href="SignUp">New User?</a>
      
    </body>
</html>
