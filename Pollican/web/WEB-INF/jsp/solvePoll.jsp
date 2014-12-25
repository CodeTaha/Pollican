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
<%@include file="header.jspf" %>
        
        <div id="page-wrapper">

            <div class="container-fluid" >
                
               
                <div class='row' >
                  
                    <div class='col-sm-12 col-md-8 col-lg-6 col-sm-offset-0 col-md-offset-2 col-lg-offset-3' id="pollArea">
                       <input type="checkbox" id="anonymous"/>Solve Anonymously
                        
                    </div>
                     
                </div>
                <div class='row'>
                     <div class='col-sm-12 col-md-8 col-lg-6 col-sm-offset-0 col-md-offset-2 col-lg-offset-3' id='submitSurvey'>
                        <button class="btn btn-primary" onclick="submitAns();" id="submitAns">Submit Survey</button>
                    </div>
                </div>
                   
              
                                        
            </div>
                
            </div>
</div>       
        <script>
                //console.log("In solvePoll");
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
              //  var profile=${profile};
                 
                function set_metadata(title,description,catl,author)
                {
                    var keywords="PollingDuck, Polls, Surveys";
                    for(var i=0; i<catl.length; i++)
                    {
                        keywords=keywords+", "+catl[i]['category_name'];
                    }
                    //console.log(catl);
                  $("title").empty().append(title);
                    $("head").append("<meta name='keywords' content='"+keywords+"'>")
                            .append("<meta name='description' content='"+description+"'>")
                            .append("<meta name='author' content='"+author+"'>");  
                }
                
                $('#anonymous').click(function() {
                    
                                    var $this = $(this);
                                    // $this will contain a reference to the checkbox   
                                    if ($this.is(':checked')) {
                                        anonymous=1;
                                        Alerts("alert-warning","You wont get the rewarded if you solve the poll anonymously, but your name wont be displayed on the report page of this survey.");
                                    } else {
                                        anonymous=0;
                                        $("#alert_box").empty();
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
               // console.log("dataIn solvePoll");
               //console.log(data);
               //pollJSON=data;//JSON.parse(data);
               //console.log(pollJSON);
               qtnJSON=pollJSON['qtn_json'];
               console.log("qtn JSON");
               //console.log(qtnJSON);
               //ansJSON=JSON.parse(pollJSON['ans_json']);
                 //alert(data);
                 /*
                  *
                    <div class='panel panel-primary'>
                                <div class='panel-heading'>
                                    <div class='row'>
                                        <div class='col-sm-8'>
                                            <h3 class='panel-title'>Question</h3>
                                        </div>
                                    </div>
                                </div>
                               
                                <div class='panel-body'>
                                    <div class='row'>
                                        <div class='col-sm-5'>
                                            <button type='button' class='btn btn-sm btn-primary'>Solve</button>
                                            <button type='button' class='btn btn-sm btn-success'>Report</button>
                                        </div>
                                    </div>
                                </div>
                    </div>
              
                  */
              
              //$("#pollArea").append('<h1>'+pollJSON['title']+'</h1><h2>'+pollJSON['description']+'</h2>');
                  for(var i=0; i<qtnJSON.length; i++)
                  {
                      //$("#pollArea").append("<p>Qtn "+qtnJSON[i]['qtn_id']+":"+qtnJSON[i]['qtn']+"</p>");
                      $("#pollArea").append("<div class='panel panel-primary'>\n\
                                                <div class='panel-heading'>\n\
                                                    <div class='row'>\n\
                                                        <div class='col-sm-8'>\n\
                                                            <h3 class='panel-title'>"+qtnJSON[i]['qtn_id']+":"+qtnJSON[i]['qtn']+"</h3>\n\
                                                        </div>\n\
                                                    </div>\n\
                                                </div>\n\
                                              <div class='panel-body'>\n\
                                                <div class='row'>\n\
                                                    <div class='col-sm-8' id='qtndiv_"+i+"'>\n\
                                                    </div>\n\
                                                </div>\n\
                                            </div>\n\
                                        </div>");
                      switch(qtnJSON[i]['qtn_type'])
                      {
                          case "mcss":{
                                        var answers=qtnJSON[i]['rows'];
                                      
                                        for (var j=0; j<answers.length;j++)
                                            {//<div class='radio'><label><input type='radio' name='optionsRadios' id='optionsRadios1' value='option1' checked=''>Radio 1</label></div>
                                                //$("#pollArea").append('<input type="radio" name="qtn'+(i+1)+'" value="'+(j+1)+'"/>'+answers[j]+'<br/>');
                                                $("#qtndiv_"+i).append("<label class='col-sm-6 col-lg-6'><input type='radio' name='qtn"+(i+1)+"' value='"+(j+1)+"' checked=''>"+answers[j]+"</label>");
                                            }
                                          
                                      }break;
                          case "mcms":{//console.log(ansJSON[i][1]);
                                        var answers=qtnJSON[i]['rows'];
                                       
                                        //$("#pollArea").append('<select multiple id="qtn'+(i+1)+'" name="qtn'+(i+1)+'"></select>');
                                        $("#qtndiv_"+i).append("<select multiple id='qtn"+(i+1)+"' name='qtn"+(i+1)+"'></select>");
                                        for (var j=0; j<answers.length;j++)
                                            {//console.log(answers[j]);
                                                $("#qtn"+(i+1)).append('<option value="'+(j+1)+'">'+answers[j]+'</option>'); 
                                            }
                                            //$("#pollArea").append('</select>');
                                            $("#qtn"+(i+1)).dropdownchecklist({maxDropHeight:120,width:100,emptyText: "select"});
                                            
                                      }break;
                           case "tb":{
                                       //console.log(ansJSON[i]);
                                       
                                       //$("#pollArea").append('Enter your answer here. If you have multiple answers then separate them with enter<br/><textarea id="qtn'+(i+1)+'" name="qtn'+(i+1)+'"></textarea>');
                                       $("#qtndiv_"+i).append(" <div class='form-group'>\n\
                                                                    <label>Enter your answer here. If you have multiple answers then separate them with enter</label>\n\
                                                                    <textarea class='form-control' rows='2' id='qtn"+(i+1)+"' name='qtn"+(i+1)+"'></textarea>\n\
                                                                </div>");
                                      }break;
                            case "moc":{
                                          /* 
                                          <table class='table table-hover table-striped'>
                                <thead>
                                    <tr>
                                        <th>Page</th>
                                        <th>Visits</th>
                                        <th>% New Visits</th>
                                        <th>Revenue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>/index.html</td>
                                        <td>1265</td>
                                        <td>32.3%</td>
                                        <td>$321.33</td>
                                    </tr>
                                </tbody>
                            </table>
                                           */
                                           var rows=qtnJSON[i]['rows'];
                                           var columns=qtnJSON[i]['columns'];
                                          
                                           var tableid="moc"+(i+1);
                                         
                                           $("#qtndiv_"+i).append("<div class='table-responsive'><table id='"+tableid+"' class='table table-bordered table-hover table-striped col-sm-12'></table><div>");
                                           $("#"+tableid).append("<thead id='thead_"+tableid+"'></thead>");
                                           $("#"+tableid).append("<tbody id='tbody_"+tableid+"'></tbody>");
                                           for(var k=0; k<=rows.length; k++)
                                           {
                                               var row_id="moctr"+k1;
                                               k1++;
                                               //$("#"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               if(k==0)
                                               {
                                                   $("#thead_"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               }
                                               else
                                               {
                                                   $("#tbody_"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               }
                                               for(var l=0; l<=columns.length; l++)
                                               {
                                                   if(k==0)
                                                   {
                                                       
                                                       if(l==0)
                                                       {
                                                          
                                                           $("#"+row_id).append("<th></th>");// top right corner cell
                                                           //$("#thead_"+row_id).append("<th>Rows\Columns</th>");// top right corner cell
                                                       }
                                                       else
                                                       {
                                                          $("#"+row_id).append("<th><center>"+columns[l-1]+"</center></th>");// naming columns
                                                           //$("#thead_"+row_id).append("<th>"+columns[l-1]+"</th>");// naming columns
                                                       }
                                                   }
                                                   else
                                                   {
                                                       
                                                  if(l==0)
                                                   {
                                                       
                                                       $("#"+row_id).append("<th><center>"+rows[k-1]+"</center></th>");//naming rows
                                                       //$("#tbody_"+row_id).append("<th><center>"+rows[k-1]+"</center></th>");//naming rows
                                                   }
                                                   else
                                                   {
                                                       $("#"+row_id).append("<td><center><input type='radio' name='qtn"+(i+1)+" "+(k-1)+"' value='"+(k-1)+","+(l-1)+"'></label></center></td>");
                                                       //$("#tbody_"+row_id).append("<td><input type='radio' name='qtn"+(i+1)+" "+(k-1)+"' value='"+(k-1)+","+(l-1)+"'></label></td>");
                                                   }
                                                    }
                                               }
                                           }
                                           
                                          
                                         
                                       
                                      }break;
                          
                    case "momc":{
                            
                                           var rows=qtnJSON[i]['rows'];
                                           var columns=qtnJSON[i]['columns'];
                                           
                                           var tableid="momc"+(i+1);
                                           //$("#pollArea").append('<table id="'+tableid+'"></table>');
                                           $("#qtndiv_"+i).append("<div class='table-responsive'><table id='"+tableid+"' class='table table-bordered table-hover table-striped'></table></div>");
                                           $("#"+tableid).append("<thead id='thead_"+tableid+"'></thead>");
                                           $("#"+tableid).append("<tbody id='tbody_"+tableid+"'></tbody>");
                                           for(var k=0; k<=rows.length; k++)
                                           {
                                               var row_id="momctr"+k2;
                                               k2++;
                                               if(k==0)
                                               {
                                                   $("#thead_"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               }
                                               else
                                               {
                                                   $("#tbody_"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               }
                                               //$("#"+tableid).append('<tr id="'+row_id+'"></tr>');
                                               for(var l=0; l<=columns.length; l++)
                                               {
                                                   if(k==0)
                                                   {
                                                       if(l==0)
                                                       {
                                                           //$("#"+row_id).append("<th><center>Rows\Columns</center></th>");// top right corner cell
                                                           $("#"+row_id).append("<th></th>");// top right corner cell
                                                       }
                                                       else
                                                       {
                                                           //$("#"+row_id).append("<th><center>"+columns[l-1]+"</center></th>");// naming columns
                                                           $("#"+row_id).append("<th><center>"+columns[l-1]+"</center></th>");// naming columns
                                                       }
                                                   }
                                                   else if(l==0)
                                                   {
                                                       //$("#"+row_id).append("<th><center>"+rows[k-1]+"</center></th>");//naming rows
                                                       $("#"+row_id).append("<th><center>"+rows[k-1]+"</center></th>");//naming rows
                                                   }
                                                   else
                                                   {
                                                       //$("#"+row_id).append("<td><center><input type='checkbox' name='qtn"+(i+1)+" "+(k-1)+"' value='"+(k-1)+","+(l-1)+"'/></center></td>");
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
               //   console.log("alia bhatt"+pollJSON);
                  console.log("anonymous="+anonymous+" fish="+fish);
               //   console.log("profile "+ profile);
           
        $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "${delimiter}submitPollAns",
                                data: { finalJSON: finalJSON, anonymous:anonymous, fish:fish, poll_uid:pollJSON["uid"], poll_title:pollJSON["poll_title"],poll_link:pollJSON["poll_link"],poll_cat:pollJSON["cid_json"]},
                                success: function(data){
                                        console.log("op")
                                        console.log(data);
                                        if(data)
                                        {
                                            $("#pollArea").empty();
                                            $("#submitSurvey").empty().append("<a href='${delimiter}result/"+pid+"/pollican' style=' text-decoration: none;'><button class='btn btn-success'>View Result</button></a>")
                                        }
                                                //location.reload(true);
                                }
                        });
              
            }
        </script>
    </body>
</html>
