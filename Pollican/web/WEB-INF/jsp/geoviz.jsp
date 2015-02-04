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




  <script src="../../pages/resources/template/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../../pages/resources/template/css/bootstrap.css">
  <link rel="stylesheet" href="../../pages/resources/template/css/social-buttons.css" />
    <link href="../../pages/resources/template/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Geo vizualization libraries -->
    <script src="${delimiter}pages/resources/js/d3.min.js"></script>
    <script src="${delimiter}pages/resources/js/topojson.min.js"></script>
    <script src="${delimiter}pages/resources/js/datamaps.all.min.js"></script>
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
        
        <!--<button onclick="createpdf()"  style="float: right" class="btn btn-info">whole page as pdf</button>-->
        <div id="container" style="position: relative; width: 1000px; height: 800px;">
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
           console.log(geo_obj);
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
               for(var i=0;i<geo_obj.length;i++)
               {
                   var y=new Array(rows.length+1);
                   for(k=0;k<y.length;k++)
                   {
                       y[k]=0;//Initializez all values to 0
                   }
                   var country_code=geo_obj[i]["geo_json"][0]["country_code3"];
                   
                   for(j=0;j<geo_obj[i]["qtn"][qtn_num]["ans"][0].length;j++)
                   {
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
               console.log('x');
               console.log(x);
               
               var map = new Datamap({
							element: document.getElementById('container'),
							//scope:'usa',
							fills: 	{
                                                            
									HIGH: '#afafaf',
									LOW: '#123456',
									MEDIUM: 'blue',
									UNKNOWN: 'rgb(0,0,0)',
									defaultFill: 'green'
									},
							data: 	{
									IRL: {
										fillKey: 'LOW',
										numberOfThings: 2002
										},
									USA: {
										fillKey: 'MEDIUM',numberOfThings: 10381},
										
									},
				
							geographyConfig:{
											//highlightOnHover: false,
											//popupOnHover: false
											 popupTemplate: function(geo, data) {
                return ['<div class="hoverinfo"><strong>',
                        'Number of things in ' + geo.properties.name,
                        ': ' + data.numberOfThings,
                        '</strong></div>'].join('');
											}
							}
						});
						
		//draw a legend for this map
		map.legend();
		
		map.updateChoropleth({
                                        USA: {fillKey: 'LOW'},
                                        CAN: '#0fa0fa'
                                     });
               console.log(array_of_countries);
               console.log(country_results);
               console.log(country_count);
               
                for(var i=0;i<array_of_countries.length;i++)
                {
                    var tempdata = new Array();
                    tempdata[array_of_countries[i]]=new Array();
                    tempdata[array_of_countries[i]]['fillKey'] = "LOW";
                    map.updateChoropleth(tempdata);
                }
           }
   
    
        </script>
     
    </body>
</html>