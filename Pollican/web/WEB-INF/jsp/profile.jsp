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
$("#pic").append("<img width='135' height='135' style='z-index:2000;' class='media-object dp img-circle'  src="+profile_pic+"><p></p>");
$("#name").append('<h2><b>'+name+'</b></h2><p></p>');
$("#follow").append("<br/><b >"+profile['follow']['followers'].length+"</b>&nbsp<br/>");
$("#followinguser").append("<br/><b >"+profile['follow']['following'].length+"</b>&nbsp<br/>");
$("#fishes").append("<br/><b >"+fish+"</b>&nbsp<br/>");
$("#handle").append("<p></p>&nbsp&nbsp<b>Pollican Handle : @"+handle+"</b>");
$("#city").append("&nbsp&nbsp<b>City : "+city+"</b>");
$("#country").append("&nbsp&nbsp<b>Country : "+country+"</b>");
$("#sex").append("&nbsp&nbsp<b>Gender : "+sex+"</b>");
$("#dob").append("&nbsp&nbsp<b>Date of Birth : "+dob+"</b>");
$("#follUnfoll").append("<p></p>");
//$("#timeline_pic").append("<img id='bigpic'  src="+profile_pic+">");
if(profile['uid']==uid)
{
    $("#pic").append('<br/><left><button id="editprofile" class="btn btn-primary" onclick=editProfile();>Edit Profile</button></left>');
  
}
else
{
    if(uid!==0)
    {
        if(profile['follow']['followers'].indexOf(uid)!==-1)
        {
            $("#follUnfoll").append('<button id="followUnfollow" class="btn btn-success" onclick="follow(0);">following</button>');
        }
        else
        {
            $("#follUnfoll").append('<button id="followUnfollow" class="btn btn-primary" onclick="follow(1);">Follow</button>');
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
                           if(exp_json[j]['exp'] >=1051 && exp_json[j]['exp'] <=1300)
                           {
                               $("#uexp").append( "<span class='label label-success'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else if(exp_json[j]['exp'] >=1301 && exp_json[j]['exp'] <=1600)
                           {
                               $("#uexp").append( "<span class='label label-warning'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else if(exp_json[j]['exp'] >=1000 && exp_json[j]['exp'] <=1050)
                           {
                               $("#uexp").append( "<span class='label label-info'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else if(exp_json[j]['exp'] >=1601 && exp_json[j]['exp'] <=2000)
                           {
                               $("#uexp").append( "<span class='label label-primary'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
                           }
                           
                           else 
                           {
                               $("#uexp").append( "<span class='label label-danger'><b>" + userCategJSON[i]['category_name']  +"</b>&nbsp:&nbsp<i>"+exp_json[j]['exp']+"</i>&nbsp<br/></span>") ;
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
           data: { uidfollowings : JSON.stringify(profile['follow']['following']),uid : profile['uid'] },
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
           data: { uidfollowings : JSON.stringify(profile['follow']['followers']) ,uid : profile['uid'] },
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
            
  var cityfetched=JSON.stringify(profile['city']).substring(1,JSON.stringify(profile['city']).length-1);
  var countryfetched=JSON.stringify(profile['country']).substring(1,JSON.stringify(profile['country']).length-1);
function editProfile()
           {    
               $("#editprofile").hide();
               $("#dob").append("<div id='temporary' style='background-color:white;'><br/></div>");
               $("#temporary").show();
                  $("#city").empty();
       $("#city").append("<div class='form-group'><label class='control-label' for='"+city+"'>&nbsp City:</label><textarea  id='editcity' value='"+city+"' class='form-control' ></textarea></div>");
     //  console.log("city");
     var citystr=cityfetched; 
        var citylen=citystr.length;
        $("#editcity").val(citystr);
        
     
                  $("#country").empty();
       $("#country").append("<div class='form-group'><label class='control-label' for='"+country+"'>&nbsp Country:</label><textarea  id='editcountry' value='"+country+"' class='form-control' ></textarea></div>");
        var countrystr=countryfetched; 
        var clen=countrystr.length;
        $("#editcountry").val(countrystr);
        
        
      //  $("#sex").empty();
       //$("#sex").append("<div class='form-group'><label class='control-label' for='"+sex+"'>Sex:</label><textarea  id='editsex' value='"+sex+"' class='form-control' ></textarea></div>");
        //var sexstr=JSON.stringify(profile['sex']); 
        //var sexlen=sexstr.length;
        //$("#editsex").val(sexstr.substring(1,sexlen-1));
        
  //      $("#dob").empty();
    //   $("#dob").append("<div class='form-group'><label class='control-label' for='"+dob+"'>DOB:</label><textarea  id='editdob' value='"+dob+"' class='form-control' ></textarea></div>");
  //var datebirth=JSON.stringify(profile['dob']);
    //    var dlen=datebirth.length;
      //  $("#editdob").val(datebirth.substring(1,dlen-1));
   
       $("#submitchanges").append('<br/><left><button class="btn btn-success" onclick="submittedchanges()";>Submit Changes</button></left><p></p>');       
        
        
    }
 
 function submittedchanges()
 {
    // console.log(JSON.stringify(profile['dob']));
   //  console.log(profile['uid']);
     
      cityfetched=$("#editcity").val();
      countryfetched=$("#editcountry").val();
    // var dobfetched=$("#editdob").val();
     console.log(cityfetched);console.log(countryfetched);
     //console.log(dobfetched);
        
                     $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "../editprofiledetails",
                                data: {citystr : cityfetched, countrystr : countryfetched, uidp : profile['uid']},
                                success: function(data){
                                            //alert(data);
                                            console.log("data passed");
                                                                    
                                }
                        });
        
     $("#editprofile").show();
     $("#temporary").remove();
      var citystr=cityfetched; 
      var countrystr=countryfetched;    
     // var datebirth=JSON.stringify(profile['dob']);        
      
     $("#city").empty();$("#country").empty();
    // $("#sex").empty();
   //  $("#dob").empty();
   
        var citylen=citystr.length;
        $("#city").append("&nbsp&nbsp<b>City : "+citystr+"</b>");
 
     
        var clen=countrystr.length;   
        $("#country").append("&nbsp&nbsp<b>Country : "+countrystr+"</b>");

 //var sexstr=JSON.stringify(profile['sex']); 
   //     var sexlen=sexstr.length;
   //$("#sex").append("&nbsp&nbsp<b>Gender : "+sexstr.substring(1,sexlen-1)+"</b>");


      //  var dlen=datebirth.length;
        //$("#dob").append("&nbsp&nbsp<b>Date of Birth : "+datebirth.substring(1,dlen-1)+"</b>");
   
        
        $("#submitchanges").empty();
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
                        $("#follUnfoll").empty().append('<button id="followUnfollow" class="btn btn-success" onclick="follow(0);">Following</button>');
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
//$("#timeline").niceScroll({cursorcolor:"#111111"});
    </script>
   <style>
        #timeline::-webkit-scrollbar {
width: 15px;
height: 15px;
}
#timeline::-webkit-scrollbar-track-piece  {
//background-color: #DFDCD9;
//background: linear-gradient(to bottom,#DFDCD9,white);
}
#timeline::-webkit-scrollbar-thumb:vertical {
height: 30px;
//background-color: #DFDCD9;
//background: linear-gradient(to bottom,#DFDCD9,white);
}

#timeline { overflow:hidden;height:600px; }
#timeline:hover { overflow-y:scroll; }

  #uexp::-webkit-scrollbar {
width: 15px;
height: 15px;
}
#uexp::-webkit-scrollbar-track-piece  {
background-color: whitesmoke;

}
#uexp::-webkit-scrollbar-thumb:vertical {
height: 30px;
background-color: whitesmoke;
}

#uexp { overflow:hidden;height:250px; }
#uexp:hover { overflow-y:scroll; }

       
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
        transform: scale3d;
        //transform:rotate(360deg);
        //-ms-transform:rotate(360deg);  
        //-webkit-transform:rotate(360deg);  
        /*-webkit-font-smoothing:antialiased;*/
    }
    
  //  #bigpic{
    //    width: 100%;
      // min-height:100px;
      // max-height: 280px;
      // z-index:3000;
     //background-color: white;
    //}
    
    #pic{
        margin-top: 10px;
       // z-index: 2000;
        margin-left: 40px;
       // background-color:white; 
    }
  //  #timeline_pic{
    //    margin-left: -14px;
       // background: linear-gradient(to bottom, #9c9e9f, #f6f6f6);
    //}
    
    #page-wrapper {
   // position: fixed;
  background: linear-gradient(to bottom, whitesmoke, white); 
}

    #csff {
   // position: fixed;
  //background: linear-gradient(to bottom,#DFDCD9,white); 
}

   </style>
   
   <div id="page-wrapper" data-spy="scroll" data-target="#info" style="">
            
             <div class="container-fluid" >
                  
                
                 <div class="row col-md-12" style="background-color:white" >
                       <div  id="info"  style=" height: auto; background-color: white;" class="col-md-4 col-xs-12 col-sm-12 col-lg-4">
                         
                           
                              
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
                           <div id="spaces"><p><br/><br/></p></div>
                           <div id="follUnfoll" >
                               
                            </div>
                                 
                           <div id="handle_city_country_sex_dob_uexp"  >
                               
                                        <div id="handle" style="background-color:#d4d4d4">
                                          
                                        </div>
                                           <div id="sex" style="background-color:#d4d4d4" >

                                        </div>

                                     <div id="dob" style="background-color:#d4d4d4">

                                        </div>
                                       
                                       <div id="city" style="background-color:#d4d4d4" >

                                        </div>

                                        <div id="country" style="background-color:#d4d4d4">

                                        </div>
                                        
                                    
                                        
                                        <div id="submitchanges">
                                   
                                        </div>
                                        <div id="uexp" class="tab-content pre-scrollable " style="background-color:whitesmoke; height: auto; max-height:264px;scrollbar-base-color:F5F5F5; scrollbar-arrow-color:F5F5F5; " >
                                         <center><h2>user experience</h2></center>
                                        </div>
                            </div>
                           
                              
                           </div>    
                             
                      <div id="csff" class="col-md-6 col-xs-12 col-sm-12 col-lg-6" style="background-color:#DFDCD9" >
                          
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
                              
                           <div id="timeline" class="tab-content pre-scrollable " style=" height: auto; max-height:644px;scrollbar-base-color:F5F5F5; scrollbar-arrow-color:F5F5F5; ">
            
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
                       
       <div id="suggestions" style="background-color:white ;height:auto; max-height:500px;"  class="col-md-2 col-xs-12 col-sm-12 col-lg-2 ">
                           
                             <b>  Suggestions</b>                           
                       </div> 
               </div>
                 </div>
             </div>
                
        
            
       </body>
</html>