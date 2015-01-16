<%@include file="header.jspf" %>
    <script>
        var followers,following;
         var profile=${profile}; 
        var loggedin=${loggedin};
        var uid=${uid};
        followers=${followers};
        following=${following};    
        var redirect=${redirect};
        $(document).ready(function(){
            
                 if(redirect)
                 {
                     
                     window.location.assign("${delimiter}index?red_url=${red_url}");
                     return;
                 }
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
      //  var testing=[153,201,300,602,800,904,732,589,1000,654]
/*         $("#user_everything").append('<h1> '+name+'</h1><br/><a href="http://www.facebook.com/'+fbid+'" target="_blank">'+fbid+'</a>');
$("#user_everything").append('<br/><b>City </b>: '+city+'<br/><b> Country </b>: '+country+'<br/><b>Date Of Birth </b> : '+dob+'<br/><b> Email </b> : '+email+'<br/><b>Sex </b>: '+sex+'<br/><b> Religion </b>: '+religion+'<br/><b> Fishes </b> : '+fish+'<br/><b> Polling Duck Handle</b> : <i>'+handle+'</i><br/><b> Last Change </b> : '+lc+'<br/><b> Contact : </b>'+phone+'<br/>');
$("#dp").append("<b> Profile Picture</b> <img width='50' height='50' src="+profile_pic+">").append("<br><b> Followers</b>:"+profile['follow']['followers'].length).append("<b> Following</b>:"+profile['follow']['following'].length);

*/
$("#pic").append("<img width='100' height='100' class='media-object dp img-circle'  src="+profile_pic+"><p></p>");
$("#name").append('<h2><b>'+name+'</b></h2><p></p>');
$("#follow").append("<br/><b >"+profile['follow']['followers'].length+"</b>&nbsp<br/>");
$("#followinguser").append("<br/><b >"+profile['follow']['following'].length+"</b>&nbsp<br/>");
$("#fishes").append("<br/><b >"+fish+"</b>&nbsp<br/>");
$("#handle").append("<p></p><b>Pollican Handle : @"+handle+"</b>");
$("#city").append("<b>City : "+city+"</b>");
$("#country").append("<b>Country : "+country+"</b>");
$("#sex").append("<b>Gender : "+sex+"</b>");
$("#dob").append("<b>Date of Birth : "+dob+"</b>");
$("#follUnfoll").append("<p></p>");

if(profile['uid']==uid)
{
   // $("#pic").append('<br/><button class="btn btn-primary" onclick=editProfile();>Edit Profile</button>');
    
}
else
{
    if(uid!==0)
    {
        if(profile['follow']['followers'].indexOf(uid)!==-1)
        {
            $("#follUnfoll").append('<button id="followUnfollow" onclick="follow(0);">Unfollow</button>');
        }
        else
        {
            $("#follUnfoll").append('<button id="followUnfollow" onclick="follow(1);">Follow</button>');
        }
        if(profile['follow']['following'].indexOf(uid)!==-1)
        {
            $("#pic").append('<br/> <b>Follows you<b>');
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
                        { //$("#uexp").append( "<b>" + userCategJSON[i]['category_name']  +"</b>") ;
                         // $("#uexp").append( " <i> "+ exp_json[j]['exp']+"</i><br/>") ;
                           if(exp_json[j]['exp'] >=0 && exp_json[j]['exp'] <=200)
                           {
                               $("#uexp").append( "<span class='label label-danger'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else if(exp_json[j]['exp'] >=201 && exp_json[j]['exp'] <=400)
                           {
                               $("#uexp").append( "<span class='label label-warning'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else if(exp_json[j]['exp'] >=401 && exp_json[j]['exp'] <=600)
                           {
                               $("#uexp").append( "<span class='label label-info'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else if(exp_json[j]['exp'] >=601 && exp_json[j]['exp'] <=800)
                           {
                               $("#uexp").append( "<span class='label label-primary'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else 
                           {
                               $("#uexp").append( "<span class='label label-success'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                        }
                    }
                }
            }
});

       

$("#createdPolls").append('<br/><br/><br/><br/>');
      
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewMyPollsData",
           data: { uidp:profile['uid'],created_solved:1  },
           success: function(data){
              
               mypollJSON=JSON.parse(data);
               console.log("neha sharma"+mypollJSON);
                 for(var i=0; i<mypollJSON.length;i++)
                 {  /*$("#createdPolls").append("<p><b>Title </b>"+mypollJSON[i]['title']+"</p>");
                 $("#createdPolls").append("<p><b>Description </b>"+mypollJSON[i]['description']+"</p>");
                 $("#createdPolls").append('<button type="button" class="btn btn-primary" onclick="pollResult('+parseInt(mypollJSON[i]["pid"])+')">Results</button>');
                 */
                   createPollDivs("#createdPolls",mypollJSON[i],2);         
                   
                 }
            }
});
       
                   
$("#solvedPolls").append('<br/><br/><br/></br/>');
            
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewMyPollsData",
           //url: "../viewMySolvedPollsData",
           data: { uidp : profile['uid'],created_solved:2 },
           success: function(data){
               
               mysolvedpollJSON=JSON.parse(data);
              
                for(var i=0; i<mysolvedpollJSON.length;i++)
                 {  
                    //$("#solvedPolls").append("<p><b>Poll ID : </b>"+mysolvedpollJSON[i]['pid']+"</p>");
                    //$("#solvedPolls").append("<p><b>Poll Ans Key: </b>"+mysolvedpollJSON[i]['poll_ans_key']+"</p>");
                    //$("#solvedPolls").append('<button type="button" class="btn btn-primary" onclick="pollResult('+parseInt(mysolvedpollJSON[i]["pid"])+')">Results</button>');
                    createPollDivs("#solvedPolls",mysolvedpollJSON[i],2);
                  }   
            }
           });
           
           
           console.log(profile['follow']['followers']);
           
           console.log(profile['follow']['following']);
 $("#following").append('<br/><br/><br/></br/>');  
            $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewFollowings",
           data: { uidfollowings : JSON.stringify(profile['follow']['following']) },
           success: function(data){
               
               myFollowings=data;
               console.log("myFollowings"+myFollowings);
               var myFollowings_array = [];
               var temp="";
               temp = myFollowings.toString();
               temp = temp.trim();
               temp = temp.substring(1,temp.length-1);
               myFollowings_array = temp.split(",");
               console.log(myFollowings_array);
              // var abcd = JSON.stringify(myFollowings);
                for(var i=0;i<myFollowings_array.length;i++)
                 $("#following").append(myFollowings_array[i]+"<br><br>");
               
             // var abc = JSON.stringify(myFollowings);
           
            }
           }); 
$("#followers").append('<br/><br/><br/></br/>');  
 $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "../viewFollowers",
           data: { uidfollowings : JSON.stringify(profile['follow']['followers']) },
           success: function(data){
               
               myFollowers=data;
               console.log("myFollowers"+myFollowers);
               var myFollowers_array = [];
               var temp="";
               temp = myFollowers.toString();
                temp = temp.trim();
               temp = temp.substring(1,temp.length-1);
               myFollowers_array = temp.split(",");
               console.log(myFollowers_array);
              // var abcd = JSON.stringify(myFollowers);
                for(var i=0;i<myFollowers_array.length;i++)
                 $("#followers").append(myFollowers_array[i]+"<br><br>");
               
           
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
                 alert("edit profile func called");
            }
 
function follow(cmd)
{ 
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
                        $("#follUnfoll").empty().append('<button id="followUnfollow" class="btn btn-primary" onclick="follow(0);">Following</button>');
                    }
                    else
                    {//alert(22);
                        //$("#followUnfollow").empty().append("Follow").prop("onclick","follow(1);");//.attr("onclick='follow(1);'");
                        $("#follUnfoll").empty().append('<button id="followUnfollow" class="btn btn-primary" onclick="follow(1);">Follow</button>');
                    }
                   
               }
           }
    });
}
    </script>
   <style>
     #timeline::-webkit-scrollbar {
width: 15px;
height: 15px;
}
#timeline::-webkit-scrollbar-track-piece  {
background-color: whitesmoke;
}
#timeline::-webkit-scrollbar-thumb:vertical {
height: 30px;
background-color: whitesmoke;
}

#timeline { overflow:hidden;height:600px; }
#timeline:hover { overflow-y:scroll; }

       
.media
    {
        /*box-shadow:0px 0px 4px -2px #000;*/
        margin: 20px 0;
        padding:30px;
    }
    .dp
    {
        border:10px solid #eee;
        transition: all 0.2s ease-in-out;
    }
    .dp:hover
    {
        border:2px solid #eee;
        transform:rotate(360deg);
        -ms-transform:rotate(360deg);  
        -webkit-transform:rotate(360deg);  
        /*-webkit-font-smoothing:antialiased;*/
    }
   </style>
   
   <div id="page-wrapper" data-spy="scroll" data-target="#info" style="background-color:whitesmoke ">
            
             <div class="container-fluid" >
                 <div class="row col-md-12"  >
                  
                   
                       <div  id="info"  style=" height: auto;" class="col-md-4 col-xs-12 col-sm-12">
                         
                           
                              
                           <div id="pic_name" >
                                
                                 <div id="pic" >
                               
                                 </div>
                                 
                                  
                                
                                 <div id="name" >
                               
                                 </div>
                                    
                            </div>
                             
                           <div id="fff" >
                                        <div id="follow"     class="col-md-4 label label-primary">
                                          <b>followers</b>
                                        </div>

                                        <div id="followinguser"  class="col-md-4 label label-primary">
                                          <b>followings</b>
                                        </div>

                                        <div id="fishes"  class="col-md-4 label label-primary">
                                          <b>Pollicoins</b>
                                        </div>
                            </div>
                           
                           <div id="follUnfoll" >
                               
                            </div>
                                 
                           <div id="handle_city_country_sex_dob_uexp"  >
                               
                                        <div id="handle" >
                                          
                                        </div>

                                        <div id="city" >

                                        </div>

                                        <div id="country">

                                        </div>
                                        
                                        <div id="sex" >

                                        </div>

                                        <div id="dob" >

                                        </div>

                                        <div id="uexp">
                                         <h3 >user experience</h3>
                                        </div>
                            </div>
                           
                              
                           </div>    
                             
                      <div id="csff" class="col-md-6 col-xs-12 col-sm-12" >
                          
                             <ul id="myTab1" class="nav nav-tabs " style="background-color: #111111;">
                                <li class="active " >
                                    <a href="#createdPolls" data-toggle="tab">
                                       Created Polls
                                    </a>
                                </li>
                                <li><a href="#solvedPolls" data-toggle="tab">
                                        Solved Polls
                                    </a>
                                </li>
                                <li><a href="#following" data-toggle="tab">
                                        Following
                                    </a>
                                </li>
                                <li><a href="#followers" data-toggle="tab">
                                        Followers
                                    </a>
                                </li>
                             </ul>
                              
                           <div id="timeline" class="tab-content pre-scrollable " style=" height: auto; max-height:500px;scrollbar-base-color:F5F5F5; scrollbar-arrow-color:F5F5F5; ">
            
                           <div class="tab-pane fade in active" id="createdPolls" style="width: 100%">
                           </div>
                               
                           <div class="tab-pane fade" id="solvedPolls"style="width: 100%" >
                           </div>
                
                           <div class="tab-pane fade" id="following" style="width: 100%">
                           </div>
                               
                           <div class="tab-pane fade" id="followers" style="width: 100%">
                           </div>
            
                           </div>
        
                       </div>
                       
       
                       <div id="suggestions"   class="col-md-2 col-xs-12 col-sm-12 ">
                           
                             <b>  Suggestions</b>                           
                       </div> 
               </div>
                 </div>
             </div>
                
        
            
       </body>
</html>