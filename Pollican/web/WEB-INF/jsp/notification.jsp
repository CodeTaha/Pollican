<%-- 
    Document   : notifications
    Created on : 3 Aug, 2014, 3:42:15 PM
    Author     : Taha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notifications</title>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui.css">
        <link rel="stylesheet" href="pages/resources/css/jquery-ui.min.css">
        <link rel="stylesheet" href="pages/resources/css/jquery-ui.theme.css">
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/js/jquery-ui.js"></script>
        <style>
            .Unseen{background-color: white;text-decoration-color: red};
            .Seen{background-color: green};
        </style>
        <script>
    var notify_temp;   
    var notify=new Array();
    var ts="";
    var canLoadMore=true;
    $(document).ready(function(){
                $('#loading').hide();
                $('#NoMoreData').hide();
                 loadData();
               
            });
            function loadData()
            {$('#loading').show();
                if(canLoadMore)
                {
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "getNotifications",
           data: {ts:ts },
           success: function(data){
               $('#loading').hide();
               console.log(data);
               notify_temp=null;
               notify_temp=JSON.parse(data);
               console.log("notify_temp");
               console.log(notify_temp);
               if(notify_temp==[] || notify_temp==null || notify_temp=="")
               {
                   console.log("end of data reached");
                   canLoadMore=false;
                   $('#NoMoreData').show();
                   
               }
               else
               {
               ts=notify_temp[notify_temp.length-1]['ts'];
               console.log("ts="+ts);
               
               createNotifyDivs();
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
                
                function createNotifyDivs()
            {
                for(var i=0; i<notify_temp.length;i++)
                     { 
                         notify.push(notify_temp[i]);
                      for(var i=0; i<notify_temp.length;i++)
                      {
                          $("#notifications").append("<div id=n_"+notify_temp[i]["nid"]+" onclick=openLink("+notify_temp[i]["checked"]+","+notify_temp[i]["nid"]+")><a href="+notify_temp[i]["link"]+" target='blank'>"+notify_temp[i]["notification"]+"</a></div>");
                          if(notify_temp[i]["checked"]===0)
                          {
                              $("#n_"+notify_temp[i]["nid"]).css("background-color","white");
                          }
                          else
                          {
                              $("#n_"+notify_temp[i]["nid"]).css("background-color","grey");
                          }
                      }
                         
                     }
            }
            
            function openLink(checked, ref_nid)
            {
                if(checked==0)
                {
                $("#n_"+ref_nid).css("background-color","grey");
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "clearNotificationChecked",
           data: {nid:ref_nid },
           success: function(data){}
                });
                }
            }
           
        </script>
        
    </head>
    <body>
        <h1>Notification</h1>
        <div id="notifications"></div>
        
        <div id="loading">Loading polls..</div>
        
     
     <div id="NoMoreData" style="padding-bottom: 3px;">Sorry No More Notifications</div>
    </body>
</html>
