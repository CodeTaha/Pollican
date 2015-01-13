<%-- 
    Document   : register2
    Created on : 9 Dec, 2014, 10:47:27 PM
    Author     : Rishi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register 2</title>
        <link href="pages/resources/select2/select2.css" rel="stylesheet"/>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui-timepicker-addon.css" >
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <!--<link rel="stylesheet" href="pages/resources/jquery-ui/jquery-ui.css">-->
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/select2/select2.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui.js"></script>
        <!--<script type="text/javascript" src="pages/resources/js/jquery-ui-timepicker-addon.js"></script>-->
        <script src="pages/resources/template/js/bootstrap.min.js"></script>
        <link href="pages/resources/template/css/bootstrap.css" rel="stylesheet">
    
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
        <div id='alert_box'>
        
        </div>
        <div id="page-wrapper">
            
            

            
            <div class="container-fluid col-lg-6 col-md-8 col-sm-10 col-lg-offset-3 col-md-offset-2 col-sm-offset-0" id='accordion_div'>
                <div class='row'>
                    <button class="btn btn-default pull-left" onclick="validate(0)">Skip</button>
                    <button class="btn btn-success pull-right" onclick="validate(1)">Register</button>
                </div>
                
                <div class='row'>
                    <h2>Please select 10 categories that describes your interests.</h2>  
                </div>
                <div class="row" id="accordion">
                    
                </div>
            
            </div>
        </div>
        
        
   
          <div id="signUpForm" class="form-horizontal" style="visibility:hidden" >
                <input type="text" name="dpsend2" id="dpsend2" style="visibility:hidden" value="${param.dpsend}">
                <input type="text" class="form-control" id="handle" onkeyup="checkHandle(); return false;" value="${param.handle}" required>
                <input type="text" class="form-control" id="name" value="${param.name}" readonly>
                <input type="text" class="form-control" id="username" value="${param.username}" readonly>
                <input type="email" class="form-control" id="email" value="${param.email}" readonly>
                <input type="email" class="form-control" id="gender" value="${param.gender}" readonly>
                <input type="text" name="dob" class="span2" data-date-format="mm/dd/yy" id="dob" value="${param.dob}" readonly> 
                <input type="text" name="city" id="city" value="${param.city}"> 
                <input type="text" name="country" id="country" value="${param.country}"> 
                <input type="text" name="state" id="state" value="${param.state}"> 
                <input type="text" name="phone" id="phone" value="${param.phone}"> 
                <input type="text" name="zip" id="zip" value="${param.zip}"> 
                <input type="text" name="religion" id="religion" value="${param.religion}"> 
                
                
        </div> 
                <div>
                      <input type="hidden" class="form-control" id="pwd" value="${param.hashpwd}" readonly>
                      <input type="hidden" class="form-control" id="password" value="${param.pwd}" readonly>
                      <input type="hidden" class="form-control" id="red_url" value="${param.response_red_url}" readonly>
                </div>
    
        <script type="text/javascript">
             var handle=document.getElementById("handle").value;
           var name=document.getElementById("name").value;
           var username=document.getElementById("username").value;
           var country=document.getElementById("country").value;
            var email_i=document.getElementById("email").value;
             var state=document.getElementById("state").value;
              var city=document.getElementById("city").value;
               var zip=document.getElementById("zip").value;
                var religion=document.getElementById("religion").value;
                var red_url=document.getElementById("red_url").value;
           var link; 
            var dob=document.getElementById("dob").value;;
           var profile_pic=document.getElementById("dpsend2").value;
            var phone=document.getElementById("phone").value;
            var sex=document.getElementById("gender").value;
              var hashedpassword=document.getElementById("pwd").value;
              var password=document.getElementById("password").value;
           var cat_json="";
 var fb=username;
 var cat_list=new Array();// maintains list for categories
 var cat_list=new Array();
   var array2 = new Array();
            var array3 = new Object();
            $(document).ready(function(){
                select_categories();
            });
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
       // console.log('arrays');
        //console.log(array2);
        //console.log(array3);
    $("#accordion").empty();
        for(var i=0;i<array2.length;i++)
       { $("#accordion").append("<h3>"+array2[i]+"</h3><div><div id='cat_"+i+"' class='row'></div></div>");
        
        for(var j=0;j<array3[array2[i]].length;j++)
        {/*
         * <div class="checkbox">
                                    <label>
                                        <input type="checkbox" value="">Checkbox 2
                                    </label>
                                </div>
            */
            $("#cat_"+i).append("<div class='col-lg-4'><div class='checkbox'><label><input class='cat_checkbox' type='checkbox' id='"+array3[array2[i]][j].cid +" 'value='"+array3[array2[i]][j].cid+"'>"+array3[array2[i]][j].category_name+"</label></div></div>");
        }
          
       }
        $("#accordion").accordion({
      heightStyle: "fill"
    });
    $( "#accordion-resizer").resizable({
      minHeight: 0,
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
      // $( "#accordion_div" ).hide(); 
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
       $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "getCategories",
                                data: {},
                                success: function(data){
                                    //console.log(data);
                                    cat_json=JSON.parse(data);
                                    get_accordion();
                                }});
                                          
                                
    
        $("#accordion_div").show();
    }
     function Alerts(alert_type,alert_mesg)
  {
       $("#alert_box").append("<div class='bs-example' ><div class='alert "+alert_type+"'><a href='#' class='close' data-dismiss='alert'>&times;</a>"+alert_mesg+"</div></div>").show();
  }
   
   function validate(param)
  {   var category;
      if(param==1)
      //var profile_pic=$("#profile_pic").val();
    { //$("#category").val();
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
      if(cat_list.length===0)
          category=JSON.stringify([86]);
    }
      else
      category=JSON.stringify([86]);    
      
     //console.log(category);
     //console.log(hashedpassword);
      $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "SignUpReg",
                                data: {handle:handle,name:name,email:email_i,country:country,state:state,city:city,zip:zip,religion:religion,sex:sex,dob:dob,phone:phone,category:category,profile_pic:profile_pic , fb:fb, password:password},
                                success: function(data){
                                  
                                       if(red_url!=="")
                                                {
                                                   window.location.assign(red_url);
                                                }
                                            else
                                                {
                                                    window.location.assign("dashboard");
                                                }
                                }
                        }); 
  }
            </script>

          
 </body>
</html>
