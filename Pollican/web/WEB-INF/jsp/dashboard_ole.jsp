<%@page import="com.google.gson.Gson"%>
<%@page import="User_Manager.User_Detail"%>
<% 
Cookie[] cookies = request.getCookies();
String handle="";
int uid=0;
//User_Detail user_detail;
Gson gson=new Gson();
        boolean foundCookie = false;

        for(int i = 0; i < cookies.length; i++) { 
            Cookie cookie1 = cookies[i];
            if(cookie1.getName().equals("handle"))
            {
                handle=cookie1.getValue();
                foundCookie = true;
            }
            else if(cookie1.getName().equals("uid"))
            {
                uid=Integer.parseInt(cookie1.getValue());
                foundCookie = true;
            }
            else if(cookie1.getName().equals("User_Obj"))
            {
                System.out.println(cookie1.getValue());
               // user_detail=gson.fromJson(cookie1.getValue(), User_Detail.class);
                foundCookie = true;
            }
        }  

        if (!foundCookie) {
            System.out.println("cookies not found 2");
            response.sendRedirect("index");
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to PollingDuck project</title>
        <script>
      
           
        </script>
    </head>
    <body>
        <div style="float: right"><a href="logout">Logout</a></div>
        <ul>
            <li>
                <a href="createPoll">Create</a>
            </li>
            <li>
                <a href="viewPolls">View</a>
            </li>
             <li>
                <a href="profile/<%=handle%>">Profiles</a>
            </li>
              <li>
                <a href="activity">Activity</a>
            </li>
            <li>
                <a href="notification">Notifications</a>
            </li>
        </ul>
        <p><%= handle %>! Your uid is <%= uid%> This is the default welcome page for a PollingDuck project.</p>
        <p><i>To display a different welcome page for this project, modify</i>
            <tt>index.jsp</tt> <i>, or create your own welcome page then change
                the redirection in</i> <tt>redirect.jsp</tt> <i>to point to the new
                welcome page and also update the welcome-file setting in</i>
            <tt>web.xml</tt>.</p>
    </body>
</html>
