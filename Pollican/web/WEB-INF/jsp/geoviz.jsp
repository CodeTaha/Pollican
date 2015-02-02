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
        <link rel="stylesheet" type="text/css" href="../../pages/resources/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="../../pages/resources/css/c3.css">
  <link rel="stylesheet" type="text/css" href="../../pages/resources/media/css/TableTools.css">

<!-- DataTables -->
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/media/js/TableTools.js"></script>

 <script type="text/javascript" charset="utf8" src="../../pages/resources/media/js/ZeroClipboard.js"></script>
 <script type="text/javascript" charset="utf8" src="../../pages/resources/js/canvg.js"></script>
 <script type="text/javascript" charset="utf8" src="../../pages/resources/js/rgbcolor.js"></script>
 <script type="text/javascript" charset="utf8" src="../../pages/resources/js/StackBlur.js"></script>


  <script src="../../pages/resources/template/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../../pages/resources/template/css/bootstrap.css">
  <link rel="stylesheet" href="../../pages/resources/template/css/social-buttons.css" />
    <link href="../../pages/resources/template/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

  <title property="og:title">${title}</title>
  <meta property="og:description" name="description" content="${description}">
         <meta name="keywords" content="${keywords}">
         <link rel="icon" href="${delimiter}pages/resources/img/logo.png" type="image/png" sizes="16x16">
      <meta property="og:site_name" content="pollican"/>
      <meta property="og:type" content="Polls and Surveys" />
     <%-- <meta property="og:url" content="${url}" />--%>
      <meta property="fb:app_id" content="[555702664544677]" />
      
        <script>
            var poll=${poll};// Poll Object
            var result=${result};// Result of the poll
            var logged=${logged};
            console.log("Poll_Ans_Tbl");
            console.log(poll);// use poll to get all the qtns,answers, title etc which defines the poll
            console.log(result);// use result which is the compilation of all the answers users have submitted
            console.log("logged"+logged);
          
           
   
    
        </script>
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
        <div id="whole" style="background-color:whitesmoke">
        <script src="../../pages/resources/js/d3.min.js"></script>
        <script src="../../pages/resources/js/c3.js"></script>
        <script src="../../pages/resources/js/jspdf.js"></script>
        <script src="../../pages/resources/js/canvg.js"></script>
        

<!--<script src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>-->
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jspdf.plugin.addimage.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jspdf.plugin.png_support.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/jspdf.plugin.cell.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/png.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/zlib.js"></script>
<script type="text/javascript" charset="utf8" src="../../pages/resources/js/FileSaver.js"></script>
    <!--    <script type="text/javascript"  src="/.../WEB-INF/pages/resources/js/d3/d3.min.js"</script>  -->
      
     
    </body>
</html>