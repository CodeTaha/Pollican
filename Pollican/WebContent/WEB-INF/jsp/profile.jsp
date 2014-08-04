<%-- 
    Document   : profile
    Created on : 4 Jul, 2014, 4:16:37 PM
    Author     : Taha
--%>


<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
Cookie[] cookies = request.getCookies();
String handle="";
int uid=0;
//User_Detail user_detail;

        boolean foundCookie = false;

        for(int i = 0; i < cookies.length; i++) { 
            Cookie cookie1 = cookies[i];
            if(cookie1.getName().equals("handle"))
            {
                handle=cookie1.getValue();
                foundCookie = true;
            }
            else if(cookie1.getName().equals("uid"))
            {
                uid=Integer.parseInt(cookie1.getValue());
                foundCookie = true;
            }
            else if(cookie1.getName().equals("User_Obj"))
            {
                System.out.println(cookie1.getValue());
               // user_detail=gson.fromJson(cookie1.getValue(), User_Detail.class);
                foundCookie = true;
            }
           
            
        }  

        if (!foundCookie) {
            System.out.println("cookies not found 2");
            //response.sendRedirect("index");
        }
        
       
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
      <link rel="stylesheet" href="../pages/resources/css/jquery-ui.css">
  <script src="../pages/resources/js/jquery.min.js"></script>
  <script src="../pages/resources/js/jquery-ui.js"></script>
    <script>
        var followers,following;
         var profile=${profile}; 
        var loggedin=${loggedin};
        var uid=<%=uid%>;
        followers=${followers};
        following=${following};           
        $(document).ready(function(){
                if(loggedin)
                {console.log("user is logged in");
                   
                  
                }
        // handle of user
            
      
         var name=profile['name'];
        var fbid=profile['fb'];
        var city=profile['city'];
        var country=profile['country'];
        var dob=profile['dob'];
        var email=profile['email'];
        var sex=profile['sex'];
        var religion=profile['religion'];
        var fish=profile['fish'];
        var handle=profile['handle'];
        var lc=profile['lc'];
        var phone=profile['phone'];
        var profile_pic =profile['profile_pic'];
        var categs = profile['category_list_json'];
        var exp_json = profile['exp_json'];
         $("#user_everything").append('<h1>Name : '+name+'</h1><br/><a href="http://www.facebook.com/'+fbid+'" target="_blank">'+fbid+'</a>');
// <br/><p>'+city+'<br/>'+country+'<br/>'+dob+'<br/>'+email+'<br/>'+sex+'<br/>'+religion+'<br/>'+fish+'<br/>'+handle+'<br/>'+lc+'<br/>'+phone+'<br/>''<img src="'+profile_pic+'"></p>'    
$("#user_everything").append('<br/><b>City </b>: '+city+'<br/><b> Country </b>: '+country+'<br/><b>Date Of Birth </b> : '+dob+'<br/><b> Email </b> : '+email+'<br/><b>Sex </b>: '+sex+'<br/><b> Religion </b>: '+religion+'<br/><b> Fishes </b> : '+fish+'<br/><b> Polling Duck Handle</b> : <i>'+handle+'</i><br/><b> Last Change </b> : '+lc+'<br/><b> Contact : </b>'+phone+'<br/>');
$("#dp").append("<b> Profile Picture</b> <img width='50' height='50' src="+profile_pic+">").append("<br><b> Followers</b>:"+profile['follow']['followers'].length).append("<b> Following</b>:"+profile['follow']['following'].length);
if(profile['uid']==uid)
{
    $("#dp").append('<br/><button onclick=editProfile();>Edit Profile</button>');
    
}
else
{
    if(uid!==0)
    {
        if(profile['follow']['followers'].indexOf(uid)!==-1)
        {
            $("#follUnfoll").append('<button id="followUnfollow" onclick="follow(0);">Following</button>');
        }
        else
        {
            $("#follUnfoll").append('<button id="followUnfollow" onclick="follow(1);">Follow</button>');
        }
        if(profile['follow']['following'].indexOf(uid)!==-1)
        {
            $("#dp").append('<br/> <b>Follows you<b>');
        }
        
    }
}

   $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewUsersCategData",
           data:   {   },
           success: function(data){
            
               userCategJSON=JSON.parse(data);
             
                for(var i=0;i<userCategJSON.length;i++)
                {   for (var j=0; j < categs.length ; j++)
                    { if(userCategJSON[i]['cid']===categs[j])
                        { $("#usercateg").append( "<b>" + userCategJSON[i]['category_name']  +"</b>") ;
                          $("#usercateg").append( " <i> "+ exp_json[j]['exp']+"</i>") ;
                           $("#usercateg").append( "   |   ") ;
                        }
                    }
                }
            }
});
       

//timeline

$("#createdPolls").append('<h3>Polls Created </h3><br/>');
      
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewMyPollsData",
           data: { uidp:profile['uid'] },
           success: function(data){
              
               mypollJSON=JSON.parse(data);
               
                 for(var i=0; i<mypollJSON.length;i++)
                 {  $("#createdPolls").append("<p><b>Title </b>"+mypollJSON[i]['title']+"</p>");
                 $("#createdPolls").append("<p><b>Description </b>"+mypollJSON[i]['description']+"</p>");
                 $("#createdPolls").append('<button onclick="pollResult('+parseInt(mypollJSON[i]["pid"])+')">Results</button>');
                 
                 }
            }
});
       
                   
$("#solvedPolls").append('<h3>Polls Solved </h3></br/>');
            
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewMySolvedPollsData",
           data: { uidp : profile['uid'] },
           success: function(data){
               
               mysolvedpollJSON=JSON.parse(data);
              
                for(var i=0; i<mysolvedpollJSON.length;i++)
                 {  $("#solvedPolls").append("<p><b>Poll ID : </b>"+mysolvedpollJSON[i]['pid']+"</p>");
                 $("#solvedPolls").append("<p><b>Poll Ans Key: </b>"+mysolvedpollJSON[i]['poll_ans_key']+"</p>");
           $("#solvedPolls").append('<button onclick="pollResult('+parseInt(mysolvedpollJSON[i]["pid"])+')">Results</button>');
                     
        }   
            }
           });  
         
});
function pollResult(pid)
           {    
                     var win = window.open("../result/"+pid, '_blank');
                win.focus();    
            }
function editProfile()
           {    
                 
            }
            
function follow(cmd)
{//alert(cmd);
    $.ajax({
        type: "POST",       // the dNodeNameefault
           url: "../follow",
           data: { puid : profile['uid'], cmd:cmd },
           success: function(data)
           {console.log("follow"+data);
               if(data)
               {//id="followUnfollow" <button id="followUnfollow" onclick="follow(0);">Following</button>
                   //$("#followUnfollow").remove();
                   if(cmd===1)
                    {//alert(11);
                        //$("#followUnfollow").empty().append("Following").prop("onclick","follow(0);");
                        $("#follUnfoll").empty().append('<button id="followUnfollow" onclick="follow(0);">Following</button>');
                    }
                    else
                    {//alert(22);
                        //$("#followUnfollow").empty().append("Follow").prop("onclick","follow(1);");//.attr("onclick='follow(1);'");
                        $("#follUnfoll").empty().append('<button id="followUnfollow" onclick="follow(1);">Follow</button>');
                    }
                   
               }
           }
    });
}
    </script>
    </head>
    <body>
        
        <div id="user_everything"></div> 
        <div id="dp"></div>
        <div id="follUnfoll"></div>
        <div id="usercateg">
            <h2>User Experiences</h2><br/>
        </div> 
        
        <div id="timeline"><center> <h1> <b>TimeLine  </b></h1>
                <div id="createdPolls">
        
                </div>
                <div id="solvedPolls">
             
                </div>
             </center>
            
        </div>
        
        
    </body>
</html>
