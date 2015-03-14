<%@include file="header.jspf" %>

            <!-- /.navbar-collapse do not change uptil here-->
            
            
           
            
                <div class="row col-md-12"  id="pollListmain">
                    <div id="categories" class="col-md-2 col-sm-2 col-xs-2 "  style="background-color:#939393;border-top: 21px solid#939393;border-bottom: 25px solid#939393; ">
                     
                    </div>
                    
                    <div id="pollList" class="col-md-10 col-lg-10 col-sm-10 col-xs-10 tab-content pre-scrollable"  style="background-color:white; height:auto; max-height:670px;scrollbar-base-color:F5F5F5; scrollbar-arrow-color:F5F5F5;"  >
                        <br/>
                    </div>
                        
                </div>
               
                <!-- model for boxes
                <div class='row'>
                    <div class='col-sm-4'>
                           <div class='panel panel-primary'>
                                <div class='panel-heading'>
                                    <div class='row'>
                                        <div class='col-sm-8'>
                                            <h3 class='panel-title'>Poll Title</h3>
                                        </div>
                                        <div class='col-sm-4'>
                                            <img style='width:10px;height:auto' src='pages/resources/images/pollicoins.png'> 50 
                                            <img style='width:10px;height:auto' src='pages/resources/images/bulb.png'> 50
                                        </div>
                                    </div>
                                </div>
                               
                                <div class='panel-body'>
                                    <div class='row'>
                                        <a href='#' target='blank'> <img class='img-thumbnail' style='width:50px;height:50px' src='https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpf1/v/t1.0-1/p100x100/10171238_729237357164686_2553226577218477225_n.jpg?oh=4c5334a13282b6f4053a79281a24df74&oe=5505DC4E&__gda__=1427521192_72cd9638add4d69b1f792361e7cdbbd7' alt=''>
                                            username @ handle</a>
                                    </div>
                                    <div class='row'>
                                        <div class='col-sm-7'>
                                             <span class='glyphicon glyphicon-tags' aria-hidden='true'></span> Tags: Java,PHP
                                        </div>
                                        <div class='col-sm-5'>
                                            <button type='button' class='btn btn-sm btn-primary'>Solve</button>
                                            <button type='button' class='btn btn-sm btn-success'>Report</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>-->
            
                
            
</div>  
<style>
    
    
         #pollList::-webkit-scrollbar {
width: 10px;
height: 10px;
}
#pollList::-webkit-scrollbar-track-piece  {
//background-color: #DFDCD9;
//background: linear-gradient(to bottom,#DFDCD9,white);
}
#pollList::-webkit-scrollbar-thumb:vertical {
height: 30px;
//background-color: #DFDCD9;
//background: linear-gradient(to bottom,#DFDCD9,white);
}

//#pollList { overflow:hidden;height:600px; }
//#pollList:hover { overflow-y:scroll; }

    
    .btn-sm2{
  position: relative;
  vertical-align: center;
  margin: 0px;
  height: 80x;
  width: 170px;
  padding: 20px 20px;
  font-size: 3.5px;
  color: white;
  text-align: center;
  text-shadow: 0 3px 2px rgba(0, 0, 0, 0.3);
  background: #62b1d0;
  border: 0;
  border-bottom: 3px solid #9FE8EF;
  cursor: pointer;
  -webkit-box-shadow: inset 0 -3px #9FE8EF;
  box-shadow: inset 0 -3px #9FE8EF;
}

.btn-sm2:active {
  top: 2px;
  outline: none;
  -webkit-box-shadow: none;
  box-shadow: none;
}
.btn-sm2:hover {
  background: #45E1E8;
}

  .btn-sm1{
  position: relative;
  vertical-align: center;
  margin: 0px;
  height: 80x;
  width: 170px;
  padding: 20px 20px;
  font-size: 3.5px;
  color: white;
  text-align: center;
  text-shadow: 0 3px 2px rgba(0, 0, 0, 0.3);
  background: #17818b;
  border: 0;
  border-bottom: 3px solid #9FE8EF;
  cursor: pointer;
  -webkit-box-shadow: inset 0 -3px #9FE8EF;
  box-shadow: inset 0 -3px #9FE8EF;
}

.btn-sm1:active {
  top: 2px;
  outline: none;
  -webkit-box-shadow: none;
  box-shadow: none;
}

    </style>
     <script>
    var pollJSONtemp;   
    var pollJSON=new Array();
    var ts="";
            // var uidArray = "1";
            var count=0;
    var dialog;
     var alltags=new Array();
     var alltagstemp=new Array();
     var alltagstemp2=new Array();
    var canLoadMore=true;
    var buttonid=0;
    var divid=0;
    var divcreateid;
    var selectbutton;
    var catdiv;
    var createdpollhide=new Array();
    var catremove=new Array();
    var catremovedata=new Array();
    var removeind=0;
    var buttonselect=new Array();
    var chkind=0;
    $(window).bind("load", function() {
       $.getScript('${delimiter}pages/resources/js/social.js', function() {});
    });
     
    $(document).ready(function(){
                
            
                $('#loading').hide();
                $('#NoMoreData').hide();
              //   $('#categories').append('<h2 style=" background-color:#DFDCD9;"> Categories </h2> ');
                 loadData();
               dialog=$( "#selector1" ).dialog({autoOpen: false,show: {effect: "clip",duration: 10},hide: {effect: "fade",duration: 1000},close : function() {
           $( "#dialog-modal" ).empty();
          //location.reload(true);
          
       }});
   
   
   
            });
           
            function loadData()
            {$('#loading').show();
                if(canLoadMore)
                {
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "viewActivityData",
           data: {ts:ts},
           success: function(data){
               $('#loading').hide();
               console.log(data);
               pollJSONtemp=null;
               pollJSONtemp=JSON.parse(data);
               console.log("pollJSONtemp");
               console.log(pollJSONtemp);
               if(pollJSONtemp==[] || pollJSONtemp==null || pollJSONtemp=="")
               {
                   console.log("end of data reached");
                   canLoadMore=false;
                   $('#NoMoreData').show();
                   
               }
               else
               {
               ts=pollJSONtemp[pollJSONtemp.length-1]['start_ts'];
               console.log("ts="+ts);
               var i=0;
               /*var animationLoop = function(){
                             pollJSON.push(pollJSONtemp[i]);
                              createPollDivs("#pollList",pollJSONtemp[i]);
                                i++;
                                if(i<pollJSONtemp.length)
                                {
                                    setTimeout(animationLoop, 1000/5);
                                }
                            
                                }
                    animationLoop();*/
                 for(var i=0; i<pollJSONtemp.length;i++)
                     { 
                         pollJSON.push(pollJSONtemp[i]);
                         divcreateid="div"+divid;
                         $("#pollList").append('<div id="'+divcreateid+'"></div>');
                         createPollDivs("#"+divcreateid,pollJSONtemp[i],1);
                         //listmecategories("#categories",pollJSONtemp[i],1);
                         console.log(divcreateid);
                         
                          for(var j=0;j<pollJSONtemp[i]["cat_list"].length;j++)
                          { console.log(pollJSONtemp[i]["cat_list"][j]["category_name"]);
                             
                             if(j===0)
                            createdpollhide[divid]=pollJSONtemp[i]["cat_list"][j]["category_name"]+";";
                             else
                                 createdpollhide[divid]=createdpollhide[divid]+pollJSONtemp[i]["cat_list"][j]["category_name"]+";";
                          }  
                   // createdpollhide[divid]=createdpollhide[divid]+"*";
                      console.log("createdpollhide"+divid);console.log(createdpollhide);
                          divid++;                
                
                     }
                     //var alltags=new Array();
                     if(count>0)
                     {     
                    // for(var j=0;j<alltags.length;j++)
                     alltags=alltagstemp;
                     
                     } 
                     
                console.log("value after inserting alltagstemp");console.log(alltags);
                  console.log("catremove after loading data");console.log(catremove);console.log(catremovedata);
                for(var i=0;i<pollJSONtemp[0]["cat_list"].length;i++)  
                if(alltags.indexOf(pollJSONtemp[0]["cat_list"][i]["category_name"])===-1)
            {
                alltags.push(pollJSONtemp[0]["cat_list"][i]["category_name"]);
                alltagstemp2.push(pollJSONtemp[0]["cat_list"][i]["category_name"]);
            }
                console.log("one"+alltags);
               //var alltags;
               for(var i=1;i<pollJSONtemp.length;i++)  
               {
                   for(var j=0;j<pollJSONtemp[i]["cat_list"].length;j++)
                         {
                                if(alltags.indexOf(pollJSONtemp[i]["cat_list"][j]["category_name"])===-1)
                                { 
                                    alltags.push(pollJSONtemp[i]["cat_list"][j]["category_name"]);
                                    alltagstemp2.push(pollJSONtemp[i]["cat_list"][j]["category_name"]);
                                }
                        // tags.push(poll_obj["cat_list"][j]["category_name"])
                         }
                         //console.log("neha sharma"+alltags);
                        // $("#categories").append(""+alltags);
               }
               
               console.log("alltagstemp2"+alltagstemp2);
               if(count===0)
               { //$("#categories").append("<form id='choosecateg' action='' method=''>");
            for(var x=0;x<alltags.length;x++)    
            {   // $("#categories").append("<input type='checkbox' id='"+alltags[x]+"' value='"+alltags[x]+"'  checked>"+alltags[x]+"<br>");
               catdiv="catdiv"+buttonid;
                    $("#categories").append('<div id="'+catdiv+'"></div>');
                    $("#"+catdiv).append('<button class="btn btn-sm2 " id="'+buttonid+'" value="'+alltags[x]+'" onclick="hidePoll(id)"><i class="fa fa-5x" >'+alltags[x]+'</i></button><br/>')  ;              
            // $("#categories").append("
            //$("#categories").append("</form>");
            buttonid++;
                
            }
             
    
                }
             else
             {
                 $("#categories").empty();
                // $("#categories").append("<form id='choosecateg' action='' method=''>");
            for(var x=0;x<alltags.length;x++)    
            {
                 catdiv="catdiv"+buttonid;
                    $("#categories").append('<div id="'+catdiv+'"></div>');
                              
                   if(catremovedata.indexOf(alltags[x])!==-1)
                   {
                       $("#"+catdiv).append('<button class="btn btn-sm1 " id="'+buttonid+'" value="'+alltags[x]+'" onclick="showPoll(id)"><i class="fa  fa-5x" >'+alltags[x]+'</i></button><br/>');
                  for(var ind=0;ind<createdpollhide.length;ind++)
                 {     
                 var dataextracted=createdpollhide[ind].toString().split(";");
                  if(dataextracted.indexOf(alltags[x])===-1)
                  {
                    $("#div"+ind).hide(); 
                  }
                 }  
                    }
                   else
                   {   
                     $("#"+catdiv).append('<button class="btn btn-sm2 " id="'+buttonid+'" value="'+alltags[x]+'" onclick="hidePoll(id)"><i class="fa  fa-5x" >'+alltags[x]+'</i></button><br/>'); 
                   }
 //$("#categories").append("<input type='checkbox' id='"+alltags[x]+"' value='"+alltags[x]+"'  checked>"+alltags[x]+"<br>");
            // $("#categories").append("
            //$("#categories").append("</form>");
                 buttonid++;
             }
             
         //    for(var z=0;z<catremove.length;z++)
           //  {
             //    $("#catdiv"+catremove[z]).empty();
              //   $("#catdiv"+catremove[z]).append('<button class="btn btn-success" id="'+catremove[z]+'" value="'+catremovedata[z]+'" onclick="showPoll(id)">'+catremovedata[z]+'</button><br/><p></p>');
             //}
              
            }
              }
            
            }
            });
            
            
            }
            }//loaddata() ends
            function hidePoll(id)
             {      
                 var no=id;
                 console.log("id"+no);
                 var catdivchange="catdiv"+id;
                   selectbutton=document.getElementById(id).value;
                  // buttonselect[chkind]=selectbutton;
                  // chkind++;
                 console.log("selectbutton");console.log(selectbutton);
                 
                 for(var ind=0;ind<createdpollhide.length;ind++)
                 {     
                 var dataextracted=createdpollhide[ind].toString().split(";");
                  if(dataextracted.indexOf(selectbutton)===-1)
                  {
                    $("#div"+ind).hide(); 
                  //  $("#"+catdivchange).empty();
                    //$("#"+catdivchange).append('<button class="btn btn-success" id="'+no+'" value="'+selectbutton+'" onclick="showPoll(id)">'+selectbutton+'</button><br/><p></p>');
                  } 
                 } 
                   $("#"+catdivchange).empty();
                    $("#"+catdivchange).append('<button class="btn btn-sm1 " id="'+no+'" value="'+selectbutton+'" onclick="showPoll(id)"><i class="fa fa-5x" >'+selectbutton+'</i></button><br/>');
            catremove[removeind]=no;
         //   var tejastemp = catremovedata.indexOf(selectbutton); 
        //    if(tejastemp==-1)
          //  {
              if(catremovedata.indexOf(selectbutton)===-1)
              {  catremovedata.push(selectbutton);
                removeind++;
              }
           // }
            //else
              //  catremovedata.splice(tejas,1);
            console.log("catremovedata");console.log(catremovedata);
              }
              
              function showPoll(id)
              {     
                   var no=id;
                 var catdivchange="catdiv"+id;
                   selectbutton=document.getElementById(id).value;
                 console.log("selectbutton");console.log(selectbutton);
                 
                 for(var ind=0;ind<createdpollhide.length;ind++)
                 {     
                 var dataextracted=createdpollhide[ind].toString().split(";");
                  if(dataextracted.indexOf(selectbutton)===-1)
                  {
                    $("#div"+ind).show(); 
                    //$("#"+catdivchange).empty();
                    //$("#"+catdivchange).append('<button class="btn btn-primary" id="'+no+'" value="'+selectbutton+'" onclick="hidePoll(id)">'+selectbutton+'</button><br/><p></p>');
                  } 
                 }     
                  $("#"+catdivchange).empty();
                  $("#"+catdivchange).append('<button class="btn btn-sm2" id="'+no+'" value="'+selectbutton+'" onclick="hidePoll(id)"><i class="fa  fa-5x" >'+selectbutton+'</i></button><br/>');
                  var toberemove=catremovedata.indexOf(selectbutton);
                  if(toberemove>-1)
                      catremovedata.splice(toberemove,1);
                
                 for(var ind=0;ind<createdpollhide.length;ind++)
                 {     
                     $("#div"+ind).show();
                 }
                 console.log("catremovedata");console.log(catremovedata);console.log("createdpollhide");console.log(createdpollhide);
                 if(catremovedata.length>0)
                 {
                     for(var checker=0;checker<catremovedata.length;checker++)
                     {
                         console.log("catremovedata"+checker);console.log(catremovedata[checker]);
                          for(var ind=0;ind<createdpollhide.length;ind++)
                       {     
                        var dataextracted=createdpollhide[ind].toString().split(";");
                       if(dataextracted.indexOf(catremovedata[checker])===-1)
                         {
                             $("#div"+ind).hide(); 
                         }
                       }
                         
                         
                     }
                     
                     
                 }
    
             }
              
              
            
            $(window).scroll(function()
                {
                    if(($(window).scrollTop() === $(document).height() - $(window).height()) && canLoadMore===true)
                    {
                        console.log("Ajax scroll working");
                           console.log("all tags value after parse 1");console.log(alltags);             
                        for(var i=0;i<alltags.length;i++)
                        {
                            //if(alltags[i]!==undefined)
                           alltagstemp[i]=alltags[i] ;                           
                        }
                         console.log("all tags temp");console.log(alltagstemp);
                        count++;
                        loadData();
                        
                    }
                });
           
        </script>
    </body>
</html>