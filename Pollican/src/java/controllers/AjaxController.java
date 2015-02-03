
package controllers;

import Category_Manager.Category;
import Category_Manager.Category_TblJDBCTemplate;
import DAO.Poll_Tbl_pkg.Poll_Tbl;
import DAO.Poll_Tbl_pkg.Poll_TblJDBCTemplate;
import DAO.Poll_Tbl_pkg.Qtn;
import DAO.Poll_Tbl_pkg.Qtn_Mapper;
import Notification_Manager.Notification;
import Notification_Manager.Notification_TblJDBCTemplate;
import Poll_Ans_Tbl.Poll_Ans_Tbl;
import Poll_Ans_Tbl.Poll_Ans_TblJDBCTemplate;
import User_Manager.Exp_Json;
import User_Manager.Follow;
import User_Manager.User_Detail;
import User_Manager.User_TblJDBCTemplate;
import com.google.gson.Gson;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.connectivity;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.omg.CORBA.Object;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
/* This class handles urls and shows an example of page redirection from index page to static page*/

/**
 *
 * @author abc
 */
@Controller
public class AjaxController extends Parent_Controller{
   
    @RequestMapping(value = "/submitPollData", method = RequestMethod.POST)
   public void submitPollData(@ModelAttribute Poll_Tbl poll_tbl,User_Detail user_tbl, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
      System.out.println("in AjaxController > submitPollData");
        Poll_TblJDBCTemplate poll_tblJDBCTemplate=new Poll_TblJDBCTemplate(); 
         User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String detail[]= gson.fromJson(request.getParameter("detailJSON"), String[].class);
        String qtn[][]= gson.fromJson(request.getParameter("qtnJSON"), String[][].class);
        List <Qtn> qtn_list = new ArrayList<>();
       // String ans[][]= gson.fromJson(request.getParameter("ansJSON"), String[][].class);
        System.out.println("Qtn JSON="+qtn[0][4]);
        Qtn_Mapper qtn_mapper=new Qtn_Mapper();
        ArrayList alist=new ArrayList();
        for (String[] qtn1 : qtn) {
            Qtn qtn_obj = qtn_mapper.mapRow(qtn1);
            //alist.add(qtn_obj);
            qtn_list.add(qtn_obj);
        }
        String qtn_JSON=gson.toJson(qtn_list);
        String start_ts= request.getParameter("start");
        String end_ts= request.getParameter("end");
        System.out.println("qtn JSON="+qtn_JSON);
        String poll_link = detail[1].replaceAll("[^a-zA-Z0-9 ]+","").replace(" ","_");
        System.out.println("poll_link="+poll_link);
       // poll_link="pollLink";
        int reward=5;
        int fishes=10;
        int uid=Integer.parseInt(request.getParameter("uid"));
        String poll_type="free";
          int rslt=poll_tblJDBCTemplate.create2(Integer.parseInt(detail[0]),","+detail[3]+",",detail[1],detail[2],qtn_JSON,"",poll_link,start_ts,end_ts,reward,poll_type);
        
    //    boolean rslt=poll_tblJDBCTemplate.create(Integer.parseInt(detail[0]),","+detail[3]+",",detail[1],detail[2],qtn_JSON,"",poll_link,start_ts,end_ts,reward,poll_type);
        boolean rslt2=user_tblJDBCTemplate.addreducefishes(uid,fishes,0);
      ArrayList poll_share=new ArrayList();//for sharing poll links
      poll_share.add(detail[1]);
      poll_share.add("/"+rslt+"/"+poll_link);
	//if(rslt==true && rslt2==true) out.println(true);
      if(rslt>0 && rslt2 == true) out.println(gson.toJson(poll_share));
      else out.println(0);
   }
     
   @RequestMapping(value = "/viewPollsData", method = RequestMethod.POST)
   public void viewPollsData(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
       User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
           
       Poll_TblJDBCTemplate poll_tblJDBCTemplate=new Poll_TblJDBCTemplate(); 
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String ts=request.getParameter("ts");
        List<Poll_Tbl> poll_tbl=poll_tblJDBCTemplate.listPolls(ts,ud.getUid(),ud.getCategory_list_json());
         System.out.println("view Polls PollJSON taha ts="+ts);
         //String pollJSON=gson.toJson(alist);
         String pollJSON=gson.toJson(poll_tbl);
         System.out.println("view Polls PollJSON="+pollJSON);
         out.println(pollJSON);
        }
       else
       {
           response.sendRedirect("index");
       }
   }
     @RequestMapping(value = "/solvePoll/{pid}/{ref_url}", method = RequestMethod.GET)
   public String solvePoll(@PathVariable int pid,@PathVariable String ref_url,ModelMap model, HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException, ServletException 
   {
    
       ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
       connectivity conn=(connectivity)context.getBean("connectivity");
       String cat_names="";
       String title="";
       String description="";
       User_Detail ud=get_UserDetails(request);
       if(ud==null)
       {// redirects user if not logged in
        model.addAttribute("uid",0);
        model.addAttribute("handle","");
        model.addAttribute("redirect",true);
        model.addAttribute("red_url",request.getRequestURI());
        model.addAttribute("pid", pid);
        model.addAttribute("solvable", 0);
        model.addAttribute("delimiter", "../../");
        model.addAttribute("profile_pic","");
	 
       }
       else
       {    
        
        int cansolve=conn.solvable(pid,ud.getUid());
        
        
        model.addAttribute("uid",ud.getUid());
        model.addAttribute("handle",ud.getHandle());
        model.addAttribute("redirect",false);
        model.addAttribute("solvable", cansolve);
        model.addAttribute("delimiter", "../../");
        model.addAttribute("profile_pic",ud.getProfile_pic());
        model.addAttribute("pid", pid);
        
   }
       Poll_TblJDBCTemplate poll_tbljdbc=new Poll_TblJDBCTemplate();
        Poll_Tbl poll_tbl=poll_tbljdbc.getPoll(pid);
        List<Category> list1 = poll_tbl.getCat_list();
        for(int tk=0;tk<list1.size();tk++)
        cat_names = cat_names + "," + list1.get(tk).getCategory_name();
        
        System.out.println("tejas and alia here");
       System.out.println(cat_names);
        title= title+poll_tbl.getTitle();
        description = description + poll_tbl.getTitle() +"   " + poll_tbl.getDescription();
        model.addAttribute("obj", gson.toJson(poll_tbl));
       String keywords="pollican,viewpolls,polls,surveys"+cat_names;
       model.addAttribute("page", "solvePoll");
       model.addAttribute("title",title);
       model.addAttribute("meta_description",description);
        model.addAttribute("meta_keywords_org",keywords );
   
          return "solvePoll";
   }
   
   @RequestMapping(value = "/solvePoll", method = RequestMethod.POST)
   public String solvePoll(ModelMap model, HttpServletRequest request) throws IOException, SQLException {
    
       int pid= Integer.parseInt(request.getParameter("pid"));
       String poll_tbl=request.getParameter("obj");
       ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
        connectivity conn=(connectivity)context.getBean("connectivity");
        int cansolve=conn.solvable(pid,uid);
        User_Detail ud=get_UserDetails(request);
        model.addAttribute("uid",ud.getUid());
        model.addAttribute("handle",ud.getHandle());
        model.addAttribute("pid", pid);
        model.addAttribute("obj", poll_tbl);
        model.addAttribute("solvable", cansolve);
        model.addAttribute("delimiter", "");//used to load source files properly
        model.addAttribute("profile_pic",ud.getProfile_pic());
        model.addAttribute("redirect",false);
        model.addAttribute("page", "solvePoll");
	   return "solvePoll";
  
   }
 
   @RequestMapping(value = "/submitPollAns", method = RequestMethod.POST)
   public void submitPollAns(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
       User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate();
       User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
        
        String finalJSON=request.getParameter("finalJSON");
        int anonymous=Integer.parseInt(request.getParameter("anonymous"));
        int fish=Integer.parseInt(request.getParameter("fish"));
        int poll_uid=Integer.parseInt(request.getParameter("poll_uid"));
        String poll_title=request.getParameter("poll_title");
        String poll_link=request.getParameter("poll_link");
        String cid_JSON = request.getParameter("poll_cat");
        String ipaddress= request.getParameter("ip");
        String geolocation_JSON=request.getParameter("geolocation");
       // String exp = request.getParameter("exp");
        System.out.print("ALIA BHAT cid JSON   "+cid_JSON);
       // System.out.print("ALIA BHAT exp   "+exp);
        Poll_TblJDBCTemplate poll_tblJDBCTemplate=new Poll_TblJDBCTemplate(); 
        String notification= "Congratulations!! @"+ ud.getHandle() +" has solved your poll, "+poll_title+" and you earned "+(int)fish/2+" fish for that!!";
        boolean rslt= poll_tblJDBCTemplate.submitPoll(finalJSON, anonymous,poll_uid,poll_link,notification,ipaddress,geolocation_JSON );
        if(anonymous==0)
        {
        boolean rslt2=user_tblJDBCTemplate.addreducefishes(uid,fish,1);// adding fish for solving poll and not anonymously
        }
       List<Exp_Json> expjsonlist =ud.getExp_json();
       String exp = expjsonlist.toString();
       System.out.print("Exp json  "+exp);
        user_tblJDBCTemplate.addreducefishes(poll_uid,(int)fish/2,1);// adding fish to user who created the poll
	user_tblJDBCTemplate.updateExp(ud.getUid(),cid_JSON,exp);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();  
        out.println(rslt);
       }
       
   }
   
    @RequestMapping(value = "/SignUpReg", method = RequestMethod.POST)
    @SuppressWarnings("empty-statement")
   public void SignUpReg(@ModelAttribute Poll_Tbl poll_tbl, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException, Exception {
      System.out.println("in AjaxController > SignUpReg");
        User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
        User_Detail ud;
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String handle=request.getParameter("handle");
        String name=request.getParameter("name");
        String email= request.getParameter("email");
        String country= request.getParameter("country");
        String state= request.getParameter("state");
        String city= request.getParameter("city");
        String zip= request.getParameter("zip");
        String religion= request.getParameter("religion");
        String sex= request.getParameter("sex");
        String dob= request.getParameter("dob");
        String phone= request.getParameter("phone");
        String profile_pic= request.getParameter("profile_pic");
        String fb= request.getParameter("fb");
        String red= request.getParameter("red");
        int category[]=gson.fromJson(request.getParameter("category"), int[].class); ;
        //System.out.println("cat list= "+Arrays.toString(category));
        
        
       String hashedpassword= request.getParameter("password");
       
       
            boolean rslt=user_tblJDBCTemplate.createUser(handle,name,email,country,state,city,zip,religion,sex,dob,phone,profile_pic,category,fb,hashedpassword);
            if(rslt)
            {
              User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();  
        if(fb!=null)// if registration through fb
        {
        
        ud=user.authenticate(fb,email,2);
       
       
        }
        else// if direct registration.
        {
            ud=user.authenticate(handle,email,1);
        
        }
        System.out.println("Adding cookie handle"+ud.getHandle());
        Cookie cookie=set_Cookie("handle",ud.getHandle(),24);
        response.addCookie(cookie); 
        System.out.println("Adding cookie uid"+ud.getUid());
        cookie=set_Cookie("uid",String.valueOf(ud.getUid()),24);
        response.addCookie(cookie);
            }
           out.println(rslt);
            
          
                //response.sendRedirect(red);
            
      
   }
   
   @RequestMapping(value = "/loginFB", method = RequestMethod.POST)
   private void loginFB(HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException, ServletException, Exception {
       User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
       User_Detail ud=get_UserDetails(request);
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        cookies= request.getCookies();
      
       
        String username= request.getParameter("username");
        String password= request.getParameter("password");// its actually e-mail
        String auth= request.getParameter("auth_token");//
        String profile_pic= request.getParameter("profile_pic");//
        String g = "https://graph.facebook.com/me?access_token=" + auth;
			URL u = new URL(g);
			URLConnection c = u.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					c.getInputStream()));
			String inputLine;
			StringBuilder b = new StringBuilder();
			while ((inputLine = in.readLine()) != null)
				b.append(inputLine).append("\n");
			in.close();
			String graph = b.toString();
			System.out.println(graph);
JSONObject json = (JSONObject)new JSONParser().parse(graph);
        ud=user.authenticate(json.get("id").toString(),json.get("email").toString(),2);
        if(ud!=null)
        {
        
        System.out.println("Adding cookie handle"+ud.getHandle());
        Cookie cookie=set_Cookie("handle",ud.getHandle(),24);
        response.addCookie(cookie); 
        System.out.println("Adding cookie uid"+ud.getUid());
        cookie=set_Cookie("uid",String.valueOf(ud.getUid()),24);
        response.addCookie(cookie);
       
        //System.out.print("obj json="+gson.toJson(user_detail));
        //cookie=set_Cookie("",gson.toJson(user_detail),24);
        //response.addCookie(cookie);
        //response.sendRedirect("dashboard");
       out.println(1);
       
        }
        else   
        {
            /*System.out.println("Calling Signup");
            Category_TblJDBCTemplate cat=new Category_TblJDBCTemplate();
            List<Category> category=cat.Category_list();
            String cat_json=gson.toJson(category);
            out.println(cat_json);
                    */
           User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
       
        response.setContentType("text/html;charset=UTF-8");
        
        String handle1=json.get("name").toString().replaceAll("[^a-zA-Z0-9 ]+","").replace(" ","_");
        String name=json.get("name").toString();
        String email= json.get("email").toString();
        String country="";
        String state= "";
        String city="";
        String zip= "";
        String religion= "";
        String sex= json.get("gender").toString();
        String dob= json.get("birthday").toString();
        String phone= "";
        //String profile_pic= request.getParameter("profile_pic");
        String fb= json.get("id").toString();
        
        int category[]={86};
        //System.out.println("cat list= "+Arrays.toString(category));
        
        
       String hashedpassword="";
       
       
            boolean rslt=user_tblJDBCTemplate.createUser(handle1,name,email,country,state,city,zip,religion,sex,dob,phone,profile_pic,category,fb,hashedpassword);
            if(rslt)
            {
            ud=user.authenticate(handle1,email,2);
        System.out.println("Adding cookie handle"+ud.getHandle());
        Cookie cookie=set_Cookie("handle",ud.getHandle(),24);
        response.addCookie(cookie); 
        System.out.println("Adding cookie uid"+ud.getUid());
        cookie=set_Cookie("uid",String.valueOf(ud.getUid()),24);
        response.addCookie(cookie);
        out.println(1);
            } 
            
        }
   
   }

   @RequestMapping(value = "/editprofiledetails", method = RequestMethod.POST)
   private void editprofiledetails( HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException, ServletException, Exception {
      
          User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
       
        response.setContentType("text/html;charset=UTF-8");
       System.out.println("Ajax controller->editprofiledetails");
       
       String citystr= request.getParameter("citystr");
       String countrystr= request.getParameter("countrystr");
    //   String datebirth= request.getParameter("datebirth");
      int useruid = Integer.parseInt(request.getParameter("uidp"));
     //int useruid=1;
      System.out.println("value of city"+citystr);System.out.println("value of country"+countrystr);
      //System.out.println("value of dob"+datebirth);
      System.out.println("value of uid"+useruid);
      boolean rslt=user_tblJDBCTemplate.updateCreatedUser(citystr,countrystr,useruid);
   if(rslt)
   {
     System.out.println("successful");
   }
   else
   {
     System.out.println("unsuccessful");
   }
   
   }
   
   
   
    @RequestMapping(value = "/directLogin", method = RequestMethod.POST)
   private void directLogin(HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException, ServletException, Exception {
       User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
       User_Detail ud=get_UserDetails(request);
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        cookies= request.getCookies();
      
       
        String username= request.getParameter("username");
        String password= request.getParameter("password");// its actually e-mail
        ud=user.authenticate(username,password,3);
        if(ud!=null)
        {
        
        System.out.println("Adding cookie handle"+ud.getHandle());
        Cookie cookie=set_Cookie("handle",ud.getHandle(),24);
        response.addCookie(cookie); 
        System.out.println("Adding cookie uid"+ud.getUid());
        cookie=set_Cookie("uid",String.valueOf(ud.getUid()),24);
        response.addCookie(cookie);
       
        //System.out.print("obj json="+gson.toJson(user_detail));
        //cookie=set_Cookie("",gson.toJson(user_detail),24);
        //response.addCookie(cookie);
        //response.sendRedirect("dashboard");
       out.println(1);
       
        }
        else   
        {
            out.println(0);
        }
   
   }
   @RequestMapping(value = "/viewMyPollsData", method = RequestMethod.POST)
   public void viewMyPollsData(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("in AjaxConnt>viewMyPollsData");
        PrintWriter out = response.getWriter();
        int uidasked = Integer.parseInt(request.getParameter("uidp"));
        int created_solved=Integer.parseInt(request.getParameter("created_solved"));
        System.out.print("tk 8july"+uidasked);
        User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
       Poll_TblJDBCTemplate poll_tblJDBCTemplate=new Poll_TblJDBCTemplate(); 
      
        List<Poll_Tbl> poll_tbl;
         if(created_solved==1)
         {
              poll_tbl=poll_tblJDBCTemplate.ListMyPolls(uidasked);
         }
         else
         {
             poll_tbl=poll_tblJDBCTemplate.ListMySolvedPolls(uidasked);
         }
         //String pollJSON=gson.toJson(alist);
         String pollJSON=gson.toJson(poll_tbl);
         System.out.println("view Polls PollJSON="+pollJSON);
         out.println(pollJSON);
        }
       else
       { 
          out.println("fail");
       }
   }
   
   @RequestMapping(value = "/viewMySolvedPollsData", method = RequestMethod.POST)
   public void viewMySolvedPollsData(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("in AjaxConnt>viewMySolvedPollsData");
        PrintWriter out = response.getWriter();
        int  uidasked = Integer.parseInt(request.getParameter("uidp"));
        System.out.print("tk 8july"+uidasked);
        User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
       Poll_Ans_TblJDBCTemplate poll_tblJDBCTemplate=new Poll_Ans_TblJDBCTemplate(); 
      
        List<Poll_Ans_Tbl> poll_ans_tbl=poll_tblJDBCTemplate.ListMySolvedPolls(uidasked);
         
         //String pollJSON=gson.toJson(alist);
         String pollJSON=gson.toJson(poll_ans_tbl);
         System.out.println("view Polls PollJSON="+pollJSON);
         out.println(pollJSON);
        }
       else
       { 
          out.println("fail");
       }
   }
  @RequestMapping(value = "/viewUsersCategData", method = RequestMethod.POST)
   public void viewUsersCategData(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
        String categs=request.getParameter("categs");
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
       // String ts=request.getParameter("ts");
            Category_TblJDBCTemplate cat=new Category_TblJDBCTemplate();
        //    List<Category> category=cat.User_Category_list(categs);
             List<Category> category=cat.Category_list();
            String cat_json=gson.toJson(category);
//            System.out.println("cat list "+cat_json);
//            model.addAttribute("cat_list", cat_json);
            out.println(cat_json);
       }
       else
       {
          // response.sendRedirect("index");
          // out.println("fail");
       }
     }
   
   @RequestMapping(value = "/follow", method = RequestMethod.POST)
   public void follow(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
       User_Detail ud=get_UserDetails(request);
        
       if(ud!=null)
       {
       PrintWriter out = response.getWriter();
        
        int puid = Integer.parseInt(request.getParameter("puid"));
        int cmd = Integer.parseInt(request.getParameter("cmd"));
        User_TblJDBCTemplate user=new User_TblJDBCTemplate();
        boolean rslt=user.follow_Unfollow(ud.getUid(), puid, cmd);
        out.println(rslt);
       }
   }
   @RequestMapping(value = "/viewActivityData", method = RequestMethod.POST)
   public void viewActivityData(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
       User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
           
       Poll_TblJDBCTemplate poll_tblJDBCTemplate=new Poll_TblJDBCTemplate(); 
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String ts=request.getParameter("ts");
        Follow follow=ud.getFollow();
        int[] category_list_json=ud.getCategory_list_json();
       int arrtest[]=follow.getFollowing();
        List<Poll_Tbl> poll_tbl=poll_tblJDBCTemplate.listActivityPolls(ts,arrtest,category_list_json,ud.getUid());
         System.out.println("view Polls PollJSON taha ts="+ts);
         //String pollJSON=gson.toJson(alist);
         String pollJSON=gson.toJson(poll_tbl);
         System.out.println("view Polls PollJSON="+pollJSON);
         out.println(pollJSON);
        }
      
   }
   
   @RequestMapping(value = "/getNotifications", method = RequestMethod.POST)
   public void getNotifications(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
       User_Detail ud=get_UserDetails(request);
       if(ud !=null)
       {
           String ts=request.getParameter("ts");
       Notification_TblJDBCTemplate notification_TblJDBCTemplate=new Notification_TblJDBCTemplate(); 
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        List<Notification> notifications=notification_TblJDBCTemplate.listNotifications(ts,ud.getUid());
 
         String pollJSON=gson.toJson(notifications);
         
         out.println(pollJSON);
        }
       else
       {
           response.sendRedirect("index");
       }
   }
   
   @RequestMapping(value = "/clearNotificationChecked", method = RequestMethod.POST)
   public void clearNotificationChecked(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
       
        String nid=request.getParameter("nid");
        Notification_TblJDBCTemplate notification_TblJDBCTemplate=new Notification_TblJDBCTemplate(); 
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        notification_TblJDBCTemplate.clearNotificationChecked(nid);
 
         
        out.println(true);
        
       
   }
    @RequestMapping(value = "/getCategories", method = RequestMethod.POST)
   public void getCategories(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
            PrintWriter out = response.getWriter();
            Category_TblJDBCTemplate cat=new Category_TblJDBCTemplate();
            List<Category> category=cat.Category_list();
            String cat_json=gson.toJson(category);
            out.println(cat_json);
   }
      @RequestMapping(value = "/checkHandle", method = RequestMethod.POST)
   public void checkHandle(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        
      User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String check_handle=request.getParameter("currHandle");
        int count =user_tblJDBCTemplate.handleCount(check_handle);
         out.println(count);
        
   }
   
   
   @RequestMapping(value = "/viewFollowings", method = RequestMethod.POST)
   public void viewFollowings(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("in AjaxConnt > viewFollowings");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
      
        String  followersString = request.getParameter("uidfollowings");
        System.out.print("Uid Followings received : "+followersString);
        int uid=Integer.parseInt(request.getParameter("uid"));
        if(followersString.equalsIgnoreCase("[]"))
        { out.println(""); 
        
        }     
        else 
        { 
            
        
        followersString = followersString.substring(1,followersString.length()-1);
        int l1;
        System.out.print("Uid Followings received : "+uid+"tk"+followersString);
        
         
        if(followersString.contains(","))
        {  String followersArr[] = followersString.split(",");
         
        System.out.print("FollowersArr is : "+Arrays.toString(followersArr));
        
        
        
       User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
          
         l1=followersArr.length;
         int i,j;
        User_Detail ud ;
        User_Detail loggedin_user = user_tblJDBCTemplate.get_profile(uid);
        Follow f = loggedin_user.getFollow();
        int f_array[]=f.getFollowing();
        for(int tk=0;tk<f_array.length;tk++)
        { System.out.print("f array"+f_array[tk]);
        }
        String temp = null;
        
        String followersProfile[]=new String[followersArr.length];
             for( i=0;i<l1;i++)
             { ud =user_tblJDBCTemplate.get_profile(Integer.parseInt(followersArr[i]));
               
              // for(int k=0;k<f_array.length;k++)
               // { if(f_array[k]==Integer.parseInt(followersArr[i]))
                 //   { if(Integer.parseInt(followersArr[i])==uid)
                   //     followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                     // else
                     // followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>Following";
                     
                  //  i++;
                    //}
              //  }
                followersProfile[i]=" <a href='http://www.pollican.com/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://www.pollican.com/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                
               
               temp = temp + ud; 
              }
           for( i=0;i<l1;i++)
                System.out.print("Profile of Follower #"+ (i+1) + ":"+followersProfile[i]);
           
           out.println(Arrays.toString(followersProfile));
         }
        else {
            String followersArr[] = new String[1];
            followersArr[0]=followersString;
            User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
        User_Detail loggedin_user = user_tblJDBCTemplate.get_profile(uid);
        Follow f = loggedin_user.getFollow();
        int f_array[]=f.getFollowing();
        
        for(int tk=0;tk<f_array.length;tk++)
        { System.out.print("f array"+f_array[tk]);
        }
        
         l1=followersArr.length;
         int i,j;
        User_Detail ud ;
        String temp = null;
        String followersProfile[]=new String[followersArr.length];
             for( i=0;i<l1;i++)
             { ud =user_tblJDBCTemplate.get_profile(Integer.parseInt(followersArr[i]));
              // if(f_array[0]==Integer.parseInt(followersArr[i]))
              // {    if(Integer.parseInt(followersArr[i])==uid)
               //    followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
               //    else
                //   followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>Following";
               
             //  }   
               //else
                followersProfile[i]=" <a href='http://www.pollican.com/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://www.pollican.com/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                   
               temp = temp + ud; 
              }
           for( i=0;i<l1;i++)
                System.out.print("Profile of Follower #"+ (i+1) + ":"+followersProfile[i]);
           
           out.println(Arrays.toString(followersProfile));
             }    
        } 
        
   }
   @RequestMapping(value = "/viewFollowers", method = RequestMethod.POST)
   public void viewFollowers(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("in AjaxConnt > viewFollowers");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println("uid is"+uid);
        String  followersString = request.getParameter("uidfollowings");
       int uid=Integer.parseInt(request.getParameter("uid"));
        
         System.out.print("Uid Followings received : "+followersString);
       
         if (followersString.equalsIgnoreCase("[]"))
         {
             out.println("");
         }
         else 
        {
        
        followersString = followersString.substring(1,followersString.length()-1);
        int l1;
        System.out.print("Uid Followings received : "+followersString);
        
        if(followersString.contains(","))
        {  String followersArr[] = followersString.split(",");
         
        System.out.print("FollowersArr is : "+Arrays.toString(followersArr));
        
        
        
       User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
         l1=followersArr.length;
         int i,j;
        User_Detail ud ;
        User_Detail loggedin_user = user_tblJDBCTemplate.get_profile(uid);
        Follow f = loggedin_user.getFollow();
        int f_array[]=f.getFollowing();
        for(int tk=0;tk<f_array.length;tk++)
        { System.out.print("f array_doubt"+f_array[tk]);
        }
        String temp = null;
        
        String followersProfile[]=new String[followersArr.length];
             for( i=0;i<l1;i++)
             { ud =user_tblJDBCTemplate.get_profile(Integer.parseInt(followersArr[i]));
               
             //  for(int k=0;k<f_array.length;k++)
              //  { if(f_array[k]==Integer.parseInt(followersArr[i]))
                //    { if(Integer.parseInt(followersArr[i])==uid)
                  //      followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                  //    else
                    //  followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>Following";
                     
                  //  i++;
                 //   }
                //}
                followersProfile[i]=" <a href='http://www.pollican.com/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://www.pollican.com/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                
               
               temp = temp + ud; 
              }
           for( i=0;i<l1;i++)
                System.out.print("Profile of Follower #"+ (i+1) + ":"+followersProfile[i]);
           
           out.println(Arrays.toString(followersProfile));
         }
        else {
            String followersArr[] = new String[1];
            followersArr[0]=followersString;
            User_TblJDBCTemplate user_tblJDBCTemplate=new User_TblJDBCTemplate(); 
        User_Detail loggedin_user = user_tblJDBCTemplate.get_profile(uid);
        Follow f = loggedin_user.getFollow();
        int f_array[]=f.getFollowing();
       
        for(int tk=0;tk<f_array.length;tk++)
        { System.out.print("f array"+f_array[tk]);
        }
        
         l1=followersArr.length;
         int i,j;
        User_Detail ud ;
        String temp = null;
        String followersProfile[]=new String[followersArr.length];
             for( i=0;i<l1;i++)
             { ud =user_tblJDBCTemplate.get_profile(Integer.parseInt(followersArr[i]));
              // if(f_array[0]==Integer.parseInt(followersArr[i]))
              // {    if(Integer.parseInt(followersArr[i])==uid)
                //   followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                 //  else
                  // followersProfile[i]=" <a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://localhost:8080/Pollican/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>Following";
               
             //  }   
             //  else
                followersProfile[i]=" <a href='http://www.pollican.com/profile/"+ud.getHandle()+"'><img src="+ud.getProfile_pic()+ " width='75' height='75'></a> <br>" +ud.getName() + " <br><a href='http://www.pollican.com/profile/"+ud.getHandle()+"'> @<i>"+ud.getHandle()+"</i></a><br>";
                   
               temp = temp + ud; 
              }
           for( i=0;i<l1;i++)
                System.out.print("Profile of Follower #"+ (i+1) + ":"+followersProfile[i]);
           
           out.println(Arrays.toString(followersProfile));
        }  
            
        }
   }

}

