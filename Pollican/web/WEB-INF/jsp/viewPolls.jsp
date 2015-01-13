<%@include file="header.jspf" %>

            <!-- /.navbar-collapse do not change uptil here-->
            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row" id="pollList">
                    
                    </div>
                </div>
            </div>
            
               
                   
                    
        
        
     <!--   <div id="dialog-modal" title="Solve Poll" style="float:right">   -->
            <div id="selector1">
                <div id="dialog-modal" title="Solve Poll" >
                    
                </div>
            </div>
     <div id="NoMoreData" style="padding-bottom: 3px;">Sorry No More Polls!</div>
                   
                
           
            </div>
</div>       
  
        <script>
 $(window).bind("load", function() {
       $.getScript('${delimiter}pages/resources/js/social.js', function() {});
    });
    var pollJSONtemp;   
    var pollJSON=new Array();
    var ts="";
    var canLoadMore=true;
    //var dialog=  $("#selector1").dialog({autoOpen: true,height: 550,width: 830,modal: true});
    var dialog;
    $(document).ready(function(){
                
                 loadData();
               dialog=$( "#selector1").dialog({autoOpen: false,show: {effect: "clip",duration: 10},hide: {effect: "fade",duration: 1000},close : function() {
           $( "#dialog-modal" ).empty();
          //location.reload(true);
       }});
            });
            function loadData()
            {
                if(canLoadMore)
                {
                $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "viewPollsData",
           data: {ts:ts },
           success: function(data){
               
               console.log(data);
               pollJSONtemp=null;
               pollJSONtemp=JSON.parse(data);
               console.log("pollJSONtemp");
               console.log(pollJSONtemp);
               if(pollJSONtemp==[] || pollJSONtemp==null || pollJSONtemp=="")
               {
                   console.log("end of data reached");
                   canLoadMore=false;
                   
                   
               }
               else
               {
               ts=pollJSONtemp[pollJSONtemp.length-1]['start_ts'];
               console.log("ts="+ts);
                for(var i=0; i<pollJSONtemp.length;i++)
                     { 
                         pollJSON.push(pollJSONtemp[i]);
                         createPollDivs("#pollList",pollJSONtemp[i],1);
                     }
               
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
       
           
        </script>
 
        
    </body>
</html>