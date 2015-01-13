<%@include file="header.jspf" %>

            <!-- /.navbar-collapse do not change uptil here-->
            <div id="page-wrapper">

            <div class="container-fluid" >
                <div class="row" id="pollList">
                    
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
                
            </div>
</div>       
     <script>
    var pollJSONtemp;   
    var pollJSON=new Array();
    var ts="";
            // var uidArray = "1";
    var dialog;
    var canLoadMore=true;
    $(window).bind("load", function() {
       $.getScript('${delimiter}pages/resources/js/social.js', function() {});
    });
    $(document).ready(function(){
                $('#loading').hide();
                $('#NoMoreData').hide();
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
           
           function openPoll(i)
       {
           var ind;
           console.log('pollJSON=');
           console.log(pollJSON)
           for(k=0; k<pollJSON.length; k++)
           {console.log(pollJSON[k])
               if(pollJSON[k]['pid']===i)
               {
                   ind=k;
                   console.log("k="+k);
                   break;
               }
           }
          
                 
               var pollJson_obj=pollJSON[ind];
               console.log("In OpenPoll");
               console.log(pollJson_obj);
               var win = window.open("solvePoll/"+pollJson_obj['pid']+"/df", '_blank');
                win.focus();
               /*dialog.dialog( "open" );
       $( "#dialog-modal" ).load( "solvePoll", { pid: pollJson_obj['pid'], obj:JSON.stringify(pollJson_obj), fn:1} ); 
       */
           
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
    </body>
</html>