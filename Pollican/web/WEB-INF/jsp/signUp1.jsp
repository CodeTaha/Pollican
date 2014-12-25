<%-- 
    Document   : signUp1
    Created on : 9 Dec, 2014, 10:47:13 PM
    Author     : Rishi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up 1</title>
         <link href="pages/resources/select2/select2.css" rel="stylesheet"/>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui-timepicker-addon.css" >
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/select2/select2.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui.js"></script>
        <!--<script type="text/javascript" src="pages/resources/js/jquery-ui-timepicker-addon.js"></script>-->
        <script src="pages/resources/template/js/bootstrap.min.js"></script>
        <link href="pages/resources/template/css/bootstrap.css" rel="stylesheet">
       <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/md5.js"></script>
    </head>
    <body>
        
        
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
      </div>
    </nav>
        
        
        
        
        
        
        
        
  <div id="SignUp">
   <form name="f2" method="get" action="signUp2.html" id="f2">
    <div id="signUpForm" class="form-horizontal">
         <label class="control-label col-sm-2" for="dp">Profile Pic :</label><img name="dp" id="dp" src=${param.response_dp} >
         <input type="text" name="dpsend" id="dpsend" style="visibility:hidden" value="${param.response_dp}">
        <div class="form-group">
            <label class="control-label col-sm-2" for="handle">Handle:</label>
            <div class="col-sm-8">    
                 <div class="input-group">
                <span class="input-group-addon input-group">@</span>
                <input type="text" name="handle" class="form-control" id="handle" onkeyup="checkHandle(); return false;" required>
                </div>
            <span id="confirmHandle" class="confirmHandle"></span>
            </div>
        </div>
       <div class="form-group">
            <label class="control-label col-sm-2" for="name">Name:</label>
            <div class="col-sm-6">
                <input name="name" type="text" class="form-control" id="name" value="${param.response_name}" readonly>
            </div>
        </div>
            <div class="form-group">
            <label class="control-label col-sm-2" for="username">User Name:</label>
            <div class="col-sm-6">
                <input name="username" type="text" class="form-control" id="username" value="${param.response_username}" readonly>
            </div>
        </div>
       
       <div class="form-group">
            <label class="control-label col-sm-2" for="pwd">Pollican Password:</label>
            <div class="col-sm-6">
            <input  type="password" name="pwd" class="form-control" id="pwd" placeholder="Enter a strong password" >
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="c_pwd">Confirm Password:</label>
            <div class="col-sm-6">
                <input type="password" class="form-control" id="c_pwd" onkeyup="checkPass(); return false;"  >
            </div>
           <span id="confirmMessage" class="confirmMessage"></span>
        </div>
        
        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Email:</label>
            <div class="col-sm-6">
                <input name="email" type="text" class="form-control" id="email" value="${param.response_email}" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="gender">Gender:</label>
            <div class="well col-sm-6">
            <input name="gender" type="text" class="form-control" id="gender" value="${param.response_gender}" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="dob">Date of Birth:</label>
            <div class="well col-sm-6">  
            
                <input type="text" name="dob" class="span2" data-date-format="mm/dd/yy" id="dob" value="${param.response_birthdate}" readonly> 
            </div> 
        </div> 
        
        <div class="form-group">
            <label class="control-label col-sm-2" for="city">City :</label>
            <div class="well col-sm-6">  
                <input type="text" name="city" id="city" > 
            </div> 
        </div> 
         <div class="form-group">
            <label class="control-label col-sm-2" for="country">Country :</label>
            <div class="well col-sm-6">  
                <input type="text" name="country" id="country" > 
            </div> 
        </div>
            <div class="form-group">
            <label class="control-label col-sm-2" for="state">State :</label>
            <div class="well col-sm-6">  
                <input type="text" name="state" id="state" > 
            </div> 
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="phone">Phone :</label>
            <div class="well col-sm-6">  
            
                <input type="text" name="phone" id="phone" > 
            </div> 
        </div>
            
            <div class="form-group">
            <label class="control-label col-sm-2" for="zip">ZIP :</label>
            <div class="well col-sm-6">  
            
                <input type="text" name="zip" id="zip" > 
            </div> 
        </div>
            
            <div class="form-group">
            <label class="control-label col-sm-2" for="religion">Religion :</label>
            <div class="well col-sm-6">  
            
                <input type="text" name="religion" id="religion" > 
            </div> 
        </div>
             </div>
            
            <div class="form-group">
            <label class="control-label col-sm-2" for="hashpwd">Hashed Password :</label>
            <div class="well col-sm-6">  
            
                <input type="text" name="hashpwd" id="hashpwd"  readonly> 
            </div> 
        </div>
         <div class="form-group">
            
                
           
            <div class="well col-sm-2">  
             <input type="submit" value="NEXT" id="next" style="font-size:18px; " />
           </div>  
        </div> 
        
    
    </div>
            
   
        
        <script>
            var prehashvalue;
            function checkPass()
              {
                //Store the password field objects into variables ...
                var pass1 = document.getElementById('pwd');
                var pass2 = document.getElementById('c_pwd');
                //Store the Confimation Message Object ...
                var message = document.getElementById('confirmMessage');
                //Set the colors we will be using ...
                var goodColor = "#66cc66";
                var badColor = "#ff6666";
                //Compare the values in the password field 
                //and the confirmation field
                if(pass1.value == pass2.value){
                    //The passwords match. 
                    //Set the color to the good color and inform
                    //the user that they have entered the correct password 
                    pass2.style.backgroundColor = goodColor;
                    message.style.color = goodColor;
                    
                    $("#next").removeAttr('disabled');
                    message.innerHTML = "Passwords Match!";
                    document.getElementById('hashpwd').value=CryptoJS.MD5(pass1.value);
                }else
                {
                    //The passwords do not match.
                    //Set the color to the bad color and
                    //notify the user.
                    pass2.style.backgroundColor = badColor;
                    message.style.color = badColor;
                    $("#next").attr('disabled','true');
                    message.innerHTML = "Passwords Do Not Match!"
                }
                
            }  
            function checkHandle()
            {    var currHandle = document.getElementById('handle').value;
                //alert(""+currHandle);
               //  var message2 = document.getElementById('confirmHandle').value;
                 document.getElementById('confirmHandle').innerHTML="";
                  $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "checkHandle",
           data: { currHandle: currHandle },
           success: function(data){
               
               if (data==1)
               {
                   console.log(data);
                  document.getElementById('confirmHandle').innerHTML = "Handle Taken!!";
                   $("#next").attr('disabled','true');
               }   
               else 
               { 
                    $("#next").removeAttr('disabled'); // document.getElementById('confirmHandle').innerHTML = "Handle Available!!";
                   
               }    
            }
            }); 
    
                
            }
         
           
        </script>
         
    
        
           

            </form>
</div>
</div>
    </body>
</html>
