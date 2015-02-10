<%-- 
    Document   : result
    Created on : Jun 30, 2014, 3:06:32 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../../pages/resources/js/jquery.min.js"></script>
        <style>
            div.bar {
				display: inline-block;
				width: 20px;
				height: 75px;	/* Gets overriden by D3-assigned height below */
				margin-right: 2px;
				background-color: teal;
			}
        </style>

<link rel="stylesheet" type="text/css" href="${delimiter}pages/resources/css/c3.css">

  <script src="../../pages/resources/template/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../../pages/resources/template/css/bootstrap.css">
  <link rel="stylesheet" href="../../pages/resources/template/css/social-buttons.css" />
    <link href="../../pages/resources/template/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Geo vizualization libraries -->
    <script src="${delimiter}pages/resources/js/d3.min.js"></script>
    <script src="${delimiter}pages/resources/js/topojson.min.js"></script>
    <script src="${delimiter}pages/resources/js/datamaps.all.min.js"></script>
    <script src="${delimiter}pages/resources/js/c3.js"></script>
<!-- Geo vizualization libraries ENDS HERE-->

  <title property="og:title">${title}</title>
  <meta property="og:description" name="description" content="${description}">
         <meta name="keywords" content="${keywords}">
         <link rel="icon" href="${delimiter}pages/resources/img/logo.png" type="image/png" sizes="16x16">
      <meta property="og:site_name" content="pollican"/>
      <meta property="og:type" content="Polls and Surveys" />
     <%-- <meta property="og:url" content="${url}" />--%>
      <meta property="fb:app_id" content="[555702664544677]" />
      
        
    </head>
    <body style='background-color:whitesmoke;'>
        
        <nav class="navbar navbar-inverse">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>                        
          </button>
         <img src="../../pages/resources/img/logo.png" style="width: 45px;height: 45px;margin-left: 35px;padding-top: 5px;"/>
                <a class="navbar-brand" href="index"  style="width:45px; height:45px;">Pollican</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
         
         
        </div>
      </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
        <!--<button onclick="createpdf()"  style="float: right" class="btn btn-info">whole page as pdf</button>-->
        <div id="container" class="col-lg-8" style="height: 800px;">
        </div>
        <div class="col-lg-3" style="height: 1300px;border-left: solid grey;">
            <div id="chart2">
            <div id="chart"></div>
            </div>
            <div id="chart3"></div>
        </div>
        </div>
    </div>
        
        
        
     <script>
            var poll=${poll};// Poll Object
            var result=${result};// Result of the poll
           
            var temp=JSON.parse(result[0]["geo_json"]);
            var geo_obj=new Array();
            console.log("Poll_Ans_Tbl");
            console.log(poll);// use poll to get all the qtns,answers, title etc which defines the poll
            console.log(result);// use result which is the compilation of all the answers users have submitted
          // console.log(temp);
           for(var i=0;i<result.length;i++)
           {
               var temp2=JSON.parse(result[i]["geo_json"]);
               
               geo_obj[i]=new Array();
               geo_obj[i]["geo_json"]=temp2;
               geo_obj[i]["qtn"]=result[i]["qtn"];
           }
           console.log("geo_obj",geo_obj);
           for(i=0;i<poll["qtn_json"].length;i++)
           {
               switch(poll["qtn_json"][i]["qtn_type"])
               {
                   case "moc":{}break;
                   case "momc":{}break;
                   case "mcss":{}break;
                   case "mcms":{plot_mcms(i,poll["qtn_json"][i]["rows"])}break;
                   case "tb":{}break;
               }
           }
           
           
           function plot_mcms(qtn_num,rows)
           {
               console.log("plot_mcms");
               console.log(qtn_num);
               console.log(rows);
               var array_of_countries=new Array();//stores intermediate results
               var country_results=new Array();//stores the final results
               var country_count=new Array();//stores the count for number of results for each country
               var x=new Array(); //array storing answers given by user for every location
               var plotpts=new Array();// array for plotting points
               for(var i=0;i<geo_obj.length;i++)
               {
                   plotpts[i]={};
                   plotpts[i]['geo']=geo_obj[i]['geo_json'][0];
                   plotpts[i]['latitude']=geo_obj[i]['geo_json'][0]['latitude'];
                   plotpts[i]['longitude']=geo_obj[i]['geo_json'][0]['longitude'];
                   plotpts[i]['radius']=4;
                   plotpts[i]['fillKey']='RUS';
                   plotpts[i]['ans']=new Array();
                   var y=new Array(rows.length+1);
                   for(k=0;k<y.length;k++)
                   {
                       y[k]=0;//Initializez all values to 0
                   }
                   var country_code=geo_obj[i]["geo_json"][0]["country_code3"];
                   
                   for(j=0;j<geo_obj[i]["qtn"][qtn_num]["ans"][0].length;j++)
                   {
                       plotpts[i]['ans'].push(parseInt(geo_obj[i]["qtn"][qtn_num]["ans"][0][j]));
                       y[parseInt(geo_obj[i]["qtn"][qtn_num]["ans"][0][j])-1]=1;
                   }
                   y[rows.length]=country_code;// setting the country code in last column
                   if(array_of_countries.indexOf(country_code)==-1)
                   {
                   array_of_countries.push(country_code);
                   country_results.push(y);
                   country_count.push(1);
                    }
                    else
                    {
                        var tmp=array_of_countries.indexOf(country_code);
                        for( ij=0;ij<country_results[tmp].length-1;ij++)
                        {
                            country_results[tmp][ij]=country_results[tmp][ij]+y[ij];
                        }
                        country_count[tmp]++;
                    }
                   x.push(y);
               }
               console.log('plotpts',plotpts);
               console.log('x');
               console.log(x);
               console.log('array_of_countries');
               console.log(array_of_countries);
               console.log('country_results');
               console.log(country_results);
               console.log(country_count);
               var tempdata={};
                for(var i=0;i<array_of_countries.length;i++)
                {
                    
                    tempdata[array_of_countries[i]]={};
                    //tempdata[array_of_countries[i]]['fillKey'] = "LOW";

                        //calculate how much the positive values are in percentage
                        
                        for(var j=0;j<country_results[i].length-1;j++)
                        {
                        var percentage = (country_results[i][j]/country_count[i])*100 ;
                       tempdata[array_of_countries[i]]['country_results'] = country_results[i];    
                       
                        if(percentage > 66)
                            tempdata[array_of_countries[i]]['fillKey'] = "HIGH";    
                        else if (percentage > 33)
                            tempdata[array_of_countries[i]]['fillKey'] = "MEDIUM";
                        else
                            tempdata[array_of_countries[i]]['fillKey'] = "LOW";
                    }

                   // map.updateChoropleth(tempdata);
                    //datamap.push(tempdata)
                }
                console.log(tempdata)
               var map = new Datamap({
							element: document.getElementById('container'),
                                                        responsive: true,
                                                        height: 600, //if not null, datamaps will grab the height of 'element'
                                                        width: 800,
							//scope:'usa',
                                                         setProjection: function(element) {
                                                             console.log('element',element)
                                                                var projection = d3.geo.equirectangular()
                                                                  .center([23, -3])
                                                                  .rotate([4.4, 0])
                                                                  .scale(400)
                                                                  .translate([element.offsetWidth / 2, element.offsetHeight / 2]);
                                                                var path = d3.geo.path()
                                                                  .projection(projection);

                                                                return {path: path, projection: projection};
                                                              },
							fills: 	{
                                                            
									HIGH: '#005F7F',
                                                                        MEDIUM: '#00BEFE',
									LOW: '#82A7D3',
									defaultFill: '#EDD75A'
									},
							data: 	tempdata,
                                                                             /* {
									IRL: {
										fillKey: 'LOW',
										numberO: [34,35,36]
										},
									USA: {
										fillKey: 'MEDIUM',numberOfThin: 10381},
										
									},*/
				
							geographyConfig:{
											//highlightOnHover: false,
											//popupOnHover: false
											 popupTemplate: function(geo, data) {
                                                                                             //console.log(data)
                                                                                             //console.log(data.country_results)
                                                                                             console.log('geo',geo)
                                                                                             if(data!=null)
                                                                                             {plotbar(data.country_results,rows,geo);
                                                                                             var tempstr="'<div class=\"hoverinfo\"><strong>','Number of things in '" + geo.properties.name+",': '" + data.numberOfThings+",'</strong></div>'";
                                                                                             return $("#chart2").html();
                                                                                            }
              
											}
							}
                                                        
						});
		
		map.legend();
		plotpoints(map,plotpts);
                window.addEventListener('resize', function() {
        map.resize();
    });

    //alternatively with d3
    d3.select(window).on('resize', function() {
        map.resize();
    });

    //alternatively with jQuery
    $(window).on('resize', function() {
       map.resize();
    });
           }
   function plotpoints(map,plotpts)
   {

map.bubbles(plotpts, {
    highlightOnHover: true,
    popupOnHover: true,
    popupTemplate: function (geo, data) { 
            return ['<div class="hoverinfo">',
            '<br/>latitude: ' +  data.latitude + ' kilotons',
            '<br/>longitude: ' +  data.longitude + '',
            '</div>'].join('');
    }
});

//map.setProjection
   }
   function plotbar(country_resultsi,rows,geo)
  
   {
       country_resultsi.pop();
        console.log(rows,country_resultsi)
      
    var bar_data=new Array();
    for (var i=0;i<rows.length;i++)
    {
        bar_data[i]=new Array();
        bar_data[i].push(rows[i])
        bar_data[i].push(country_resultsi[i]);
    }
    console.log(bar_data)
    var chart = c3.generate({
    bindto: '#chart',
    size: {
        height: 200,
        width: 400
    },
    data: {
        columns: bar_data,
        type: 'bar'
    },
    bar: {
        width: {
            ratio: 0.3 // this makes bar width 50% of length between ticks
        }
        // or
        //width: 100 // this makes bar width 100px
    },
     axis: {
        x: {
            type: 'category' // this needed to load string x value
        },
         y: {
            tick:{
                count:10
            },
            label: 'no of votes'
        }
    },
});

d3.select('#chart svg').append('text')
    .attr('x', d3.select('#chart svg').node().getBoundingClientRect().width / 2)
    .attr('y', 16)
    .attr('text-anchor', 'middle')
    .style('font-size', '1.4em')
    .text(geo.properties.name);

var donut1 = c3.generate({
    bindto: '#chart3',
    data: {
        columns: bar_data,
        type : 'donut',
        onclick: function (d, i) { console.log("onclick", d, i); },
        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
    },
    donut: {
        title: geo.properties.name
    }
});
}

        </script>
    </body>
</html>