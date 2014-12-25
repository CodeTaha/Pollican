<%-- 
    Document   : viewPolls
    Created on : Apr 1, 2014, 12:44:23 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Polls</title>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui.css">
        <link rel="stylesheet" href="pages/resources/css/jquery-ui.min.css">
        <link rel="stylesheet" href="pages/resources/css/jquery-ui.theme.css">
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/js/jquery-ui.js"></script>
  
        <script>
    var pollJSONtemp;   
    var pollJSONvp=new Array();
    var ts="";
    var canLoadMore=true;
    //var dialog=  $("#selector1").dialog({autoOpen: true,height: 550,width: 830,modal: true});
    var dialog;
    $(document).ready(function(){
                $('#loading').hide();
                $('#NoMoreData').hide();
                 loadData();
               dialog=$( "#selector1").dialog({autoOpen: false,show: {effect: "clip",duration: 10},hide: {effect: "fade",duration: 1000},close : function() {
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
           url: "viewPollsData",
           data: {ts:ts },
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
               
               createPollDivs();
                 //alert(data);
             }
                   
            }
            });
    }
    
            }
            $(window).scroll(function()
                {
                    if(($(window).scrollTop() === $(document).height() - $(window).height()) && canLoadMore==true)
                    {
                        console.log("Ajax scroll working");
                        loadData();
                    }
                });
            function createPollDivs()
            {
                for(var i=0; i<pollJSONtemp.length;i++)
                     { 
                         pollJSONvp.push(pollJSONtemp[i]);
                      $("#pollList").append('<hr><div id="pid'+pollJSONtemp[i]["pid"]+'">\n\
                      <h3>'+pollJSONtemp[i]["pid"]+":"+pollJSONtemp[i]["title"]+'</h3>\n\
                         \n\<a href="/Pollican/profile/'+pollJSONtemp[i]["user"]["handle"]+'"><img width="50" height = "50" src='+pollJSONtemp[i]["user"]["profile_pic"]+"></a>  <a href='/Pollican/profile/"+pollJSONtemp[i]["user"]["handle"]+"'>"+pollJSONtemp[i]["user"]["name"]+"</a>  <a href='/Pollican/profile/"+pollJSONtemp[i]["user"]["handle"]+"'  >@"+pollJSONtemp[i]["user"]["handle"]+'</a>\n\
                          \n\<h4>'+pollJSONtemp[i]["description"] +'</h4><h5>REWARD :'+pollJSONtemp[i]["reward"]+'</h5></div>'
                          );
                  $("#pid"+pollJSONtemp[i]["pid"]).append("<b><i>TAGS</i></b> :  ");
                         for(var j=0;j<pollJSONtemp[i]["cat_list"].length;j++)
                           $("#pid"+pollJSONtemp[i]["pid"]).append('<b>'+pollJSONtemp[i]["cat_list"][j]["category_name"]+"</b> ");
                         $("#pid"+pollJSONtemp[i]["pid"]).append('<br><button onclick="openPoll('+parseInt(pollJSONtemp[i]["pid"])+')">Take Poll</button>');
                         $("#pid"+pollJSONtemp[i]["pid"]).append('<button onclick="pollResult('+parseInt(pollJSONtemp[i]["pid"])+')">Results</button>');
                      
                         
                     }
            }
           function openPoll(i)
       {
           var poll_js=pollJSONvp;
          // alert();
           //$("#dialog-modal").empty();
           var ind;
           console.log('pollJSONvp=');
           console.log(pollJSONvp)
           for(k=0; k<pollJSONvp.length; k++)
           {//console.log(pollJSONvp[k])
               if(pollJSONvp[k]['pid']===i)
               {
                   ind=k;
                   console.log("k="+k);
                   break;
               }
           }
          
                 
               var pollJson_obj=pollJSONvp[ind];
               console.log("In OpenPoll");
               console.log(pollJson_obj);
               var poll_js=pollJSONvp;
              
       dialog.dialog( "open" );
       $( "#dialog-modal" ).load( "solvePoll", { pid: pollJson_obj['pid'], obj:JSON.stringify(pollJson_obj), fn:1} ); 
       
   
   pollJSONvp=poll_js;
   }
          
           function pollResult(pid)
           {
                var win = window.open("result/"+pid, '_blank');
                win.focus();
                /*$( "#dialog-modal").empty().load( 'pollResult.jsp', {pid: pid}, function( response, status, xhr ) {
                if ( status === "error" ) {
                var msg = "Sorry but there was an error: ";
                $( "#dialog-modal" ).html( msg + xhr.status + " " + xhr.statusText );*/
            }
           
        </script>
    </head>
    <body>
        
        <h1>View Polls </h1>
        <div id="pollList" style="float:left">
            
        </div>
        
        <div id="loading">Loading polls..</div>
        
     <!--   <div id="dialog-modal" title="Solve Poll" style="float:right">   -->
            <div id="selector1">
                <div id="dialog-modal" title="Solve Poll" >
                    
                </div>
            </div>
     <div id="NoMoreData" style="padding-bottom: 3px;">Sorry No More Polls to load</div>
    </body>
</html>