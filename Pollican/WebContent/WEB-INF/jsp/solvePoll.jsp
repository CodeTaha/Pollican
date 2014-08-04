<%-- 
    Document   : solvePoll
    Created on : Apr 1, 2014, 3:44:20 PM
    Author     : abc
--%>

<%@page import="controllers.Parent_Controller"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="model.connectivity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="User_Manager.User_Detail"%>
<% 
   /*
    Parent_Controller pc=new Parent_Controller();
    boolean foundCookie = false;
    foundCookie=pc.checklogin(request);
    String handle="";
    int uid=0;
    String t;
    if(foundCookie)
    {
        handle=pc.getHandle();
        uid=pc.getUid();
    }
    else
    {
        Gson gson=new Gson();
        String ref_url=request.getRequestURI();
        response.sendRedirect("../../index?refurl="+ ref_url);
    }
   */     
%>
<!DOCTYPE html>
<html>
    <head>
            <link rel="stylesheet" href="${delimiter}pages/resources/css/jquery-ui.css">
            <script src="${delimiter}pages/resources/js/jquery.min.js"></script>
            <script src="${delimiter}pages/resources/js/jquery-ui.js"></script>
            <script src="${delimiter}pages/resources/js/ui.core.js"></script>
            <link rel="stylesheet" href="${delimiter}pages/resources/css/ui.dropdownchecklist.css" />
            <script src="${delimiter}pages/resources/js/ui.dropdownchecklist.js"></script>
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <script>
                console.log("In solvePoll");
               // var pollJSON;
                var qtnJSON;
                var ansJSON;
                var pid=${pid};
                
                var solvable=${solvable};
                var anonymous=0;
                var pollJSON;
                var fish;
                var k1=0,k2=0;
                var redirect=${redirect}
                var uid=${uid};
                
                function set_metadata(title,description,catl,author)
                {
                    var keywords="PollingDuck, Polls, Surveys";
                    for(var i=0; i<catl.length; i++)
                    {
                        keywords=keywords+", "+catl[i]['category_name'];
                    }
                    console.log(catl);
                  $("head").append("<title>"+title+"</title>")
                            .append("<meta name='keywords' content='"+keywords+"'>")
                            .append("<meta name='description' content='"+description+"'>")
                            .append("<meta name='author' content='"+author+"'>");  
                }
                
                $('#anonymous').click(function() {
                                    var $this = $(this);
                                    // $this will contain a reference to the checkbox   
                                    if ($this.is(':checked')) {
                                        anonymous=1;
                                        alert("You wont get the rewarded fish if you solve the poll anonymously and your name wont be displayed on the result page.");
                                    } else {
                                        anonymous=0;
                                        // the checkbox was unchecked
                                    }
                                });
            $(document).ready(function(){
              
                if(redirect)
                 {
                     
                     window.location.assign("${delimiter}index?red_url=${red_url}");
                     return;
                 } 
                pollJSON=${obj};
                fish=pollJSON['reward'];
                set_metadata(pollJSON['title'],pollJSON['description'],pollJSON['cat_list'],pollJSON['user']['name']);
                 
                   
        
                if(solvable===1)
                 {
                console.log("dataIn solvePoll");
               //console.log(data);
               //pollJSON=data;//JSON.parse(data);
               console.log(pollJSON);
               qtnJSON=pollJSON['qtn_json'];
               console.log("qtn JSON");
               console.log(qtnJSON);
               //ansJSON=JSON.parse(pollJSON['ans_json']);
                 //alert(data);
                 
              $("#pollArea").append('<h1>'+pollJSON['title']+'</h1><h2>'+pollJSON['description']+'</h2>');
                  for(var i=0; i<qtnJSON.length; i++)
                  {
                      $("#pollArea").append("<p>Qtn "+qtnJSON[i]['qtn_id']+":"+qtnJSON[i]['qtn']+"</p>");
                     
                      switch(qtnJSON[i]['qtn_type'])
                      {
                          case "mcss":{
                                        var answers=qtnJSON[i]['rows'];
                                        for (var j=0; j<answers.length;j++)
                                            {
                                                $("#pollArea").append('<input type="radio" name="qtn'+(i+1)+'" value="'+(j+1)+'"/>'+answers[j]+'<br/>');
                                            }
                                      }break;
                          case "mcms":{//console.log(ansJSON[i][1]);
                                        var answers=qtnJSON[i]['rows'];
                                       
                                        $("#pollArea").append('<select multiple id="qtn'+(i+1)+'" name="qtn'+(i+1)+'"></select>');
                                        for (var j=0; j<answers.length;j++)
                                            {//console.log(answers[j]);
                                                $("#qtn"+(i+1)).append('<option value="'+(j+1)+'">'+answers[j]+'</option>');
                                                //$("#qtn"+(i+1)).append('<option>Hello</option>');
                                                
                                            }
                                            //$("#pollArea").append('</select>');
                                            $("#qtn"+(i+1)).dropdownchecklist({maxDropHeight:120,width:100,emptyText: "select"});
                                            
                                      }break;
                           case "tb":{
                                       //console.log(ansJSON[i]);
                                       $("#pollArea").append('Enter your answer here. If you have multiple answers then separate them with enter<br/><textarea id="qtn'+(i+1)+'" name="qtn'+(i+1)+'"></textarea>');
                                      }break;
                            case "moc":{
                                          
                                           var rows=qtnJSON[i]['rows'];
                                           var columns=qtnJSON[i]['columns'];
                                           
                                           var tableid="moc"+(i+1);
                                         
                                           $("#pollArea").append('<table id="'+tableid+'"></table>');
                                           for(var k=0; k<=rows.length; k++)
                                           {
                                               var row_id="moctr"+k1;
                                               k1++;
                                               $("#"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               for(var l=0; l<=columns.length; l++)
                                               {
                                                   if(k==0)
                                                   {
                                                       if(l==0)
                                                       {
                                                           $("#"+row_id).append("<th><center>Rows\Columns</center></th>");// top right corner cell
                                                       }
                                                       else
                                                       {
                                                           $("#"+row_id).append("<th><center>"+columns[l-1]+"</center></th>");// naming columns
                                                       }
                                                   }
                                                   else if(l==0)
                                                   {
                                                       $("#"+row_id).append("<th><center>"+rows[k-1]+"</center></th>");//naming rows
                                                   }
                                                   else
                                                   {
                                                       $("#"+row_id).append("<td><center><input type='radio' name='qtn"+(i+1)+" "+(k-1)+"' value='"+(k-1)+","+(l-1)+"'/></center></td>");
                                                   }
                                               }
                                           }
                                           
                                          
                                         
                                       
                                      }break;
                          
                    case "momc":{
                            
                                           var rows=qtnJSON[i]['rows'];
                                           var columns=qtnJSON[i]['columns'];
                                           
                                           var tableid="momc"+(i+1);
                                           $("#pollArea").append('<table id="'+tableid+'"></table>');
                                           for(var k=0; k<=rows.length; k++)
                                           {
                                               var row_id="momctr"+k2;
                                               k2++;
                                               $("#"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               for(var l=0; l<=columns.length; l++)
                                               {
                                                   if(k==0)
                                                   {
                                                       if(l==0)
                                                       {
                                                           $("#"+row_id).append("<th><center>Rows\Columns</center></th>");// top right corner cell
                                                       }
                                                       else
                                                       {
                                                           $("#"+row_id).append("<th><center>"+columns[l-1]+"</center></th>");// naming columns
                                                       }
                                                   }
                                                   else if(l==0)
                                                   {
                                                       $("#"+row_id).append("<th><center>"+rows[k-1]+"</center></th>");//naming rows
                                                   }
                                                   else
                                                   {
                                                       $("#"+row_id).append("<td><center><input type='checkbox' name='qtn"+(i+1)+" "+(k-1)+"' value='"+(k-1)+","+(l-1)+"'/></center></td>");
                                                   }
                                               }
                                           }
                                          
                                }break;
                              
                      }
                  }
               
                }
                else
                {
                    $("#pollArea").empty().append("<p>Sorry but you have already solved this Poll. However you can view the Result</p>").append("<a href='${delimiter}result/"+pid+"' target='blank'>"+pollJSON['title']+"</a>");
                    $("#submitAns").hide();
                    
                }
            });
            
            function submitAns()
            {
                var finalAns=new Array();
                console.log("In submit ans");
                console.log(qtnJSON);
                for(var i=0; i<qtnJSON.length; i++)
                  {
                        var answers=new Array();
                        //answers[0]=qtnJSON[i]['qtn_id'];
                        //answers[1]=qtnJSON[i]['qtn_type'];
                        //answers[2]=new Array();
                      switch(qtnJSON[i]['qtn_type'])
                      {
                          case "mcss":  {
                                            
                                            answers.push($('input[name=qtn'+(i+1)+']:checked').val());
                                            //finalAns.push(answers);
                                        }break;
                          case "mcms":  {
                                            
                                            answers.push($('#qtn'+(i+1)).val());
                                            //finalAns.push(answers);
                                        }break;
                          case "tb":    {
                                           
                                            var temp=$('#qtn'+(i+1)).val().split('\n');
                                            answers.push(temp);
                                            //finalAns.push(answers);
                                        }break;
                          case "moc":   {
                                            
                                            var rows=qtnJSON[i]['rows'];
                                           
                                            for(var k=0; k<rows.length;k++)
                                            {
                                                   answers.push($('input[name="qtn'+(i+1)+' '+k+'"]:checked').val()); 
                                            }
                                           //finalAns.push(answers);
                                        }break;
                          case "momc":  {
                                            
                                            var rows=qtnJSON[i]['rows'];
                                            for(var k=0; k<rows.length;k++)
                                            {
                                                   var temp= new Array();
                                                   $('input[name="qtn'+(i+1)+' '+k+'"]:checked').each(function() {
                                                                                                                //console.log(this.value);
                                                                                                                answers.push(this.value);
                                                                                                             });
                                                   
                                           }
                                           //finalAns.push(answers);
                                        }break;
                      }
                      console.log("i="+i+" qtn id="+qtnJSON[i]['qtn_id']+" qtn type="+qtnJSON[i]['qtn_type']+" answrs="+answers);
                      var ans2={qtn_id:qtnJSON[i]['qtn_id'], qtn_type:qtnJSON[i]['qtn_type'],ans:answers};
                      finalAns.push(ans2);
                  }
                  console.log(finalAns);
                  finalAns=JSON.stringify(finalAns);
                  console.log("finalAns");
                      console.log(finalAns);
                      //console.log(finalAns2);
                  var finalJSON=new Array();
                  finalJSON.push(pid);
                  finalJSON.push(uid);// UID will come here
                  finalJSON.push(finalAns);
                  finalJSON=JSON.stringify(finalJSON);
                  console.log("Final string");
                  console.log(finalJSON);
                  console.log("anonymous="+anonymous+" fish="+fish);
                  $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "${delimiter}submitPollAns",
                                data: { finalJSON: finalJSON, anonymous:anonymous, fish:fish, poll_uid:pollJSON["uid"], poll_title:pollJSON["poll_title"],poll_link:pollJSON["poll_link"]},
                                success: function(data){alert(data);
                                        if(data)
                                        {
                                            $("#submitSurvey").empty().append('<button onclick="pollResult('+pid+');">View Result</button>')
                                        }
                                                location.reload(true);
                                }
                        });
            }
        </script>
    </head>
    <body>
        <div id="pollArea">
            <input type="checkbox" id="anonymous"/>Solve Anonymously
            
        </div>
        <div id='submitSurvey'>
            <button onclick="submitAns();" id="submitAns">Submit Survey</button>
        </div>
    </body>
</html>
