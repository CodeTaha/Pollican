<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <!-- jQuery -->
    <script src="${delimiter}pages/resources/template/js/jquery.js"></script>
  <script src="${delimiter}pages/resources/template/js/bootstrap.min.js"></script>
  <script src="${delimiter}pages/resources/js/jquery-ui.js"></script>
  <script type="text/javascript" src="${delimiter}pages/resources/js/jquery.datetimepicker.js"></script>
    <!-- Bootstrap Core JavaScript -->
   
<script src="${delimiter}pages/resources/select2/select2.js"></script>
      <!-- <script src="${delimiter}pages/resources/js/ui.core.js"></script>-->
            <script src="${delimiter}pages/resources/js/ui.dropdownchecklist.js"></script>
    <%-- Morris Charts JavaScript
    <script src="${delimiter}pages/resources/template/js/plugins/morris/raphael.min.js"></script>
    <script src="${delimiter}pages/resources/template/js/plugins/morris/morris.min.js"></script>
    <script src="${delimiter}pages/resources/template/js/plugins/morris/morris-data.js"></script>--%>
    <title>Welcome</title>

    <!-- Bootstrap Core CSS -->
    <link href="${delimiter}pages/resources/template/css/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS-->
    <link href="${delimiter}pages/resources/template/css/sb-admin.css" rel="stylesheet">

    <!-- Morris Charts CSS 
    <link href="pages/resources/template/css/plugins/morris.css" rel="stylesheet">-->

    <!-- Custom Fonts -->
    <link href="${delimiter}pages/resources/template/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

   <link rel="stylesheet" href="${delimiter}pages/resources/css/jquery-ui.css">
   <link rel="stylesheet" href="${delimiter}pages/resources/css/jquery-ui.min.css">
   <link rel="stylesheet" href="${delimiter}pages/resources/css/jquery-ui.theme.css">
   <link rel="stylesheet" href="${delimiter}pages/resources/css/jquery.datetimepicker.css" >
   <link rel="stylesheet" href="${delimiter}pages/resources/css/jquery-ui.structure.css" >
   <link rel="stylesheet" href="${delimiter}pages/resources/select2/select2.css"/>
   <link rel="stylesheet" href="${delimiter}pages/resources/css/ui.dropdownchecklist.css" />
    <script src="../../pages/resources/js/d3.min.js"></script> 
        <script src="../../pages/resources/js/jspdf.js"></script>
        <script src="../../pages/resources/js/canvg.js"></script>
        

<script src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jspdf.plugin.addimage.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jspdf.plugin.png_support.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jspdf.plugin.cell.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/png.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/zlib.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/FileSaver.js"></script>
            <link rel="stylesheet" type="text/css" href="../../pages/resources/css/jquery.dataTables.css">
  <link rel="stylesheet" type="text/css" href="../../pages/resources/media/css/TableTools.css">


<!-- DataTables -->
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/media/js/TableTools.js"></script>

 <script type="text/javascript" charset="utf8" src="../../pages/resources/media/js/ZeroClipboard.js"></script>
 <script type="text/javascript" charset="utf8" src="../../pages/resources/js/canvg.js"></script>    
</head>
<body>
  <div id="page-wrapper">

            <div class="container-fluid" id='main_div'>

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header" id="Title">
                            Bootstrap Grid
                        </h1>
                        <ol class="breadcrumb" id="Description">
                            <li>
                                <i class="fa fa-dashboard"></i> 
                            </li>
                        </ol>
                    </div>
                </div>
               
               
                <!-- /.row -->

               
              

            </div>
            <!-- /.container-fluid -->

        </div>  
<script>
            var poll=${poll};// Poll Object
            var result=${result};// Result of the poll
            var logged=${logged};
            console.log("Poll");
            console.log(poll);// use poll to get all the qtns,answers, title etc which defines the poll
             console.log("Results");
            console.log(result);// use result which is the compilation of all the answers users have submitted
            console.log("logged"+logged);
          var margin = {top: 10, right: 20, bottom: 40, left: 30};
    width = 350 - margin.left - margin.right,
    height = 250 - margin.top - margin.bottom;
           
   // console.log("mere niche no of options hai un questions k jinka type mcss hai. ");
    var noOfques = poll['qtn_json'].length;        
    console.log(noOfques); 
    start()
    
    function start()
    {
        describePoll();// Adds Poll Title, Description and Tags
        createQtndiv();// Creates div for every qtns
    }
    
    function createQtndiv()
    {
        for(var i=0; i<poll['qtn_json'].length; i++)
        {
            $("#main_div").append("<div class='row'>\n\
                        <div class='panel panel-info'>\n\
                            <div class='panel-heading'>\n\
                                <h3 class='panel-title'>"+poll['qtn_json'][i]['qtn_id']+":"+poll['qtn_json'][i]['qtn']+"</h3>\n\
                            </div>\n\
                            <div class='panel-body' id='qtn_div_"+i+"'>\n\
                               \n\
                            </div>\n\
                        </div>\n\
                </div>")
            generateTypes(poll['qtn_json'][i],i);//Calls operations on questions
        }
    }
    function clone(obj) {
    if (null == obj || "object" != typeof obj) return obj;
    var copy = obj.constructor();
    for (var attr in obj) {
        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
    }
    return copy;
}
    function generateTypes(poll_qtn,qtn_no)
    {
        //console.log(poll_qtn)
        switch(poll_qtn['qtn_type'])
        {
            case 'mcms':   
            case 'mcss':{   
                            var tempArr1=new Array();
                            var mcss_ans1={};
                            var mcss_final=new Array();
                            var maxArr=new Array();
                            var final=new Array();
                            for(var i=0;i<poll_qtn['rows'].length;i++)
                            {
                                tempArr1.push(poll_qtn['rows'][i]);
                                mcss_ans1[poll_qtn['rows'][i]]=0;
                                maxArr.push(0);
                            }
                             
                            for(var i=0; i<result.length;i++)
                            {
                               mcss_final.push(clone(mcss_ans1));
                                
                                if(poll_qtn['qtn_type']=='mcss')
                                {
                                    for(var j=0; j<result[i]['qtn'][qtn_no]['ans'].length;j++)
                                        {
                                           var temp=+result[i]['qtn'][qtn_no]['ans'][j]-1;
                                           mcss_final[i][tempArr1[temp]]++;
                                           maxArr[temp]++;

                                        }
                                }
                                else
                                {
                                    for(var j=0; j<result[i]['qtn'][qtn_no]['ans'][0].length;j++)
                                       {
                                          var temp=+result[i]['qtn'][qtn_no]['ans'][0][j]-1;
                                          mcss_final[i][tempArr1[temp]]++;
                                          maxArr[temp]++;

                                       }
                                }
                            }
                            
                            for(var i=0; i<maxArr.length;i++)
                            {
                                var temp1={};
                                temp1['key']=tempArr1[i];
                                temp1['value']=maxArr[i];
                                final.push(temp1);
                            }
                            console.log("mcss_final");
                            console.log(final);
                            console.log(mcss_final);
                            generateMCSS(final,tempArr1,maxArr,qtn_no);
                            
                            /*var tempArr1=new Array();
                            var mcss_ans1={};
                            var mcss_final=new Array();
                            var maxArr=new Array();
                            for(var i=0;i<poll_qtn['rows'].length;i++)
                            {
                                tempArr1.push(poll_qtn['rows'][i]);
                                mcss_ans1[poll_qtn['rows'][i]]=0;
                                maxArr.push(0);
                            }
                             
                            for(var i=0; i<result.length;i++)
                            {
                               mcss_final.push(clone(mcss_ans1));
                                for(var j=0; j<result[i]['qtn'][qtn_no]['ans'].length;j++)
                                {
                                    var temp=+result[i]['qtn'][qtn_no]['ans'][j]-1;
                                    
                                    mcss_final[i][tempArr1[temp]]++;
                                    
                                   maxArr[temp]++;
                                }
                            }
                            console.log("mcss_final");
                            console.log(mcss_final);*/
                            //generateMCSS(final,tempArr1,maxArr,qtn_no)
                            ////////////////
                            /*console.log(poll_qtn)
                            var mcss_ans={};
                            var tempArr=new Array();
                            var maxArr=new Array();//to find the max value for y in d3
                            for(var i=0;i<poll_qtn['rows'].length;i++)
                            {
                                mcss_ans[poll_qtn['rows'][i]]=0;
                                tempArr.push(poll_qtn['rows'][i]);
                                maxArr.push(0);
                            }
                            console.log(mcss_ans);
                            for(var i=0; i<result.length;i++)
                            {
                                console.log(result[i]['qtn'][qtn_no]['ans'])
                                for(var j=0; j<result[i]['qtn'][qtn_no]['ans'].length;j++)
                                {
                                    var temp=+result[i]['qtn'][qtn_no]['ans'][j]-1;
                                    mcss_ans[tempArr[temp]]++;
                                    maxArr[temp]++;
                                }
                            }
                            console.log(mcss_ans);
                             */
                            //generate_mcss(mcss_ans,tempArr,maxArr,qtn_no)
                        }break;
        }
    }
    function generateMCSS(mcss_ans,tempArr,maxArr,qtn_no)
    {
        var max_y=Math.max.apply(Math, maxArr);//Gives maximum for number of ticks in y
    // check the API to see the difference between ordinal and linear scales
    var x2 = d3.scale.ordinal().rangeRoundBands([0, width], .1);
    var y2 = d3.scale.linear().range([height, 0]);

    // I create my x-axis
    var xAxis2 = d3.svg.axis()
            .scale(x2)
            .orient("bottom");

    // I create my y-axis
    var yAxis2 = d3.svg.axis()
            .scale(y2)
            .orient("left")
            .ticks(max_y);

    // create my canvas with margins to have everything on screen
    $("#qtn_div_"+qtn_no).append("<div class='col-md-6' id='qtn_"+qtn_no+"_bar'></div>");
    var svg2 = d3.select("#qtn_"+qtn_no+"_bar").append("svg")
            .attr("width", width + margin.left + margin.right+50)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    // Really IMPORTANT, check how are my x2 and y2 domains created
    x2.domain(mcss_ans.map(function(d){return d.key;}));
    y2.domain([0, d3.max(mcss_ans, function(d){ return d.value;})]);
	

    // I create several rects with my data
    // what is x2.rangeBand()? Find out and how important it is?
    svg2.selectAll("rect")
            .data(mcss_ans)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function(d){return x2(d.key);})
            .attr("y", function(d){return y2(d.value);})
            .attr("height", function(d){return height - y2(d.value)})
            .attr("width", x2.rangeBand())
            .style("fill", "blue")
            //.on("click", click)
            .on("mouseover", function(){d3.select(this).style("fill", "green")})
            .on("mouseout", function(){d3.select(this).style("fill", "blue")});


    // ploting my xaxis
    svg2.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + (height) + ")")
            //.attr("transform", "rotate(-90)")
            .call(xAxis2);
svg2.append("text")
    .attr("class", "x label")
    .attr("text-anchor", "end")
    .attr("x", width+20)
    .attr("y", height+15)
    .text("Options");
    // ploting my yaxis
    svg2.append("g")
            .attr("class", "y axis")
            .call(yAxis2);
svg2.append("text")
    .attr("class", "y label")
    .attr("text-anchor", "end")
    .attr("color","red")
    .attr("y", -30)
    .attr("dy", ".75em")
    .attr("transform", "rotate(-90)")
    .text("Votes");

    }
    
    function describePoll()// Adds Poll Title, Description and Tags
    {
         $("#Title").empty().append(poll['title']);//Title of Poll
        $("#Description").empty().append(poll['description']);//Title of Poll
    //<span class='glyphicon glyphicon-tags' aria-hidden='true'></span> Tags:
        $("#Description").append("<br><span class='glyphicon glyphicon-tags' aria-hidden='true'></span> Tags:")
        for(var i=0; i<poll['cat_list'].length; i++)
        {
            $("#Description").append(" "+poll['cat_list'][i]['category_name']+",")
        }
    }
    
    
        </script>
</body>

</html>