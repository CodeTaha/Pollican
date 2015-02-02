/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers;

import Category_Manager.Category;
import Category_Manager.Category_TblJDBCTemplate;
import DAO.Poll_Tbl_pkg.Poll_Tbl;
import DAO.Poll_Tbl_pkg.Poll_TblJDBCTemplate;
import Poll_Ans_Tbl.Poll_Ans_Tbl;
import Poll_Ans_Tbl.Poll_Ans_TblJDBCTemplate;
import User_Manager.Follow;
import User_Manager.User_Detail;
import User_Manager.User_TblJDBCTemplate;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
/* This class handles urls and shows an example of page redirection from index page to static page*/

/**
 *
 * @author abc
 */
@Controller
public class UrlController extends Parent_Controller{
    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
   private void logins(HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException, Exception {
       User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
       response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String username= request.getParameter("username");
        String password= request.getParameter("password");
        user_detail=user.authenticate(username,password,1);
        if(user_detail!=null)
        {
        
        System.out.println("Adding cookie handle"+user_detail.getHandle());
        Cookie cookie=set_Cookie("handle",user_detail.getHandle(),24);
        response.addCookie(cookie); 
        System.out.println("Adding cookie uid"+user_detail.getUid());
        cookie=set_Cookie("uid",String.valueOf(user_detail.getUid()),24);
        response.addCookie(cookie);
        
        response.sendRedirect("dashboard");
       
        }
        else   
        {
            System.out.println("login error");
            response.sendRedirect("index");
           
        }
   }
    
    @RequestMapping(value = "", method = RequestMethod.GET)
   public void index1(HttpServletRequest request,HttpServletResponse response) throws IOException {
      
	   response.sendRedirect("index");
   }
    
   @RequestMapping(value = "/logout", method = RequestMethod.GET)
   public String logout(HttpServletRequest request,HttpServletResponse response) {
           Cookie[] cookies2 = request.getCookies();
           user_detail=null;
    if (cookies2 != null) {
        for (Cookie cookie : cookies2) {
            
                cookie.setValue(null);
                cookie.setMaxAge(0);
                
                response.addCookie(cookie);
            
        }
    }
	   return "index";
   }
   
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
   public String dashboard(ModelMap model,HttpServletRequest request) throws IOException, SQLException {
       User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
            
            model.addAttribute("uid",ud.getUid());
            model.addAttribute("handle",ud.getHandle());
           model.addAttribute("delimiter", "");
           model.addAttribute("dashboard_active", "active");
           model.addAttribute("viewpoll_active", "");
           model.addAttribute("createpoll_active", "");
            model.addAttribute("page", "dashboard");
            model.addAttribute("profile_pic",ud.getProfile_pic());
           model.addAttribute("user",gson.toJson(get_UserDetails(request)));
           model.addAttribute("meta_description","Dashboard");
        //   model.addAttribute("meta_keywords_categs", ud.getCategory_list_json());
           model.addAttribute("meta_keywords_org", "pollican,dashboard,polls,surveys");
             model.addAttribute("title", "Pollican-Dashboard");
           return "dashboard";
       }
       else
       {
           return "redirect:index";
       }
   }
    @RequestMapping(value = "/createPoll", method = RequestMethod.GET)
   public String createPoll(ModelMap model, HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
      System.out.println("In UrlController>CreatePolls");
           try{
               User_Detail ud=get_UserDetails(request);
               if(ud!=null)
            {
            System.out.println("Checklogin cleared");
            Category_TblJDBCTemplate cat=new Category_TblJDBCTemplate();
            List<Category> category=cat.Category_list();
            String cat_json=gson.toJson(category);
            
        model.addAttribute("uid",ud.getUid());
        model.addAttribute("handle",ud.getHandle());
            System.out.println("cat list "+cat_json);
            model.addAttribute("cat_list", cat_json);
            model.addAttribute("dashboard_active", "");
           model.addAttribute("viewpoll_active", "");
           model.addAttribute("createpoll_active", "active");
            model.addAttribute("page", "createPoll");
            model.addAttribute("profile_pic",ud.getProfile_pic());
           model.addAttribute("meta_description","Create a poll or a survey and experience the people-power.");
           model.addAttribute("meta_keywords_org", "pollican,polls,surveys");
             model.addAttribute("title", "Pollican - Create Poll or Survey");
            return "createPoll";
            }
            else
            {
                response.sendRedirect("index");    
                return "index";
            }
           }
           catch(IOException | SQLException e)
           {
               System.out.println("Exception occured @ UrlController>createPoll is "+e);
           return "index";
           }
   }
   @RequestMapping(value = "/viewPolls", method = RequestMethod.GET)
   public String viewPolls(ModelMap model,HttpServletRequest request) throws SQLException{
       User_Detail ud=get_UserDetails(request);
       if(ud!=null)
       {
           
        model.addAttribute("uid",ud.getUid());
        model.addAttribute("handle",ud.getHandle());
        model.addAttribute("delimiter", "");
           model.addAttribute("dashboard_active", "");
           model.addAttribute("viewpoll_active", "active");
           model.addAttribute("createpoll_active", "");
            model.addAttribute("page", "viewPoll");
            model.addAttribute("profile_pic",ud.getProfile_pic());
            model.addAttribute("user",gson.toJson(get_UserDetails(request)));
             model.addAttribute("meta_description","View lists of polls and surveys that suit your interests!");
        //   model.addAttribute("meta_keywords_categs", ud.getCategory_list_json());
           model.addAttribute("meta_keywords_org", "pollican,viewpolls,polls,surveys");
             model.addAttribute("title", "Pollican - View Polls");
           return "viewPolls";
       }
       else
       {
           return "redirect:index";
       }
      
   }
   
   
    @RequestMapping(value = "/index", method = RequestMethod.GET)
   public String index() {
	   return "index";
   }
  
    /*@RequestMapping(value = "/register1", method = RequestMethod.POST)
   public String signUp1(ModelMap model,HttpServletRequest request){
     
       //model.addAttribute("response",request.getParameter("resp"));
      //System.out.println(gson.toJson(request.getParameter("resp")));
           return "register1";
       }
       
     
    @RequestMapping(value = "/register2", method = RequestMethod.POST)
   public String signUp2(ModelMap model,HttpServletRequest request){
     
       //model.addAttribute("response",request.getParameter("resp"));
      //System.out.println(gson.toJson(request.getParameter("resp")));
           return "register2";
       }
       
   */
    
   @RequestMapping(value = "/redirect", method = RequestMethod.GET)
   public String redirect() {
     
      return "redirect:finalPage";
   }
   
   @RequestMapping(value = "/finalPage", method = RequestMethod.GET)
   public String finalPage() {
     
      return "final";
   }
   
   @RequestMapping(value = "/staticPage", method = RequestMethod.GET)
   public String redirect2() {
     return "redirect:/pages/final.html";
   }
  
   @RequestMapping(value = "/result/{pid}/{ref_url}",method = RequestMethod.GET)
   public String result(@PathVariable int pid,@PathVariable String ref_url , ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
            System.out.println("In UrlController>result ");
             User_Detail ud=get_UserDetails(request);
             String cat_names="";
       String title="";
       String description="";
            Poll_Ans_TblJDBCTemplate poll_ans_tbl=new Poll_Ans_TblJDBCTemplate();
            Poll_TblJDBCTemplate poll_tbljdbc=new Poll_TblJDBCTemplate();
            Poll_Tbl poll_tbl=poll_tbljdbc.getPoll(pid);
          List<Category> list1 = poll_tbl.getCat_list();
         for(int tk=0;tk<list1.size();tk++)
        cat_names = cat_names  + "," + list1.get(tk).getCategory_name();
        
        System.out.println("tejas and alia here");
       System.out.println(cat_names);
       title= title+poll_tbl.getTitle();
        description = description + poll_tbl.getTitle() +"   " + poll_tbl.getDescription();
       String keywords="pollican,viewpolls,polls,surveys"+cat_names;
     
       model.addAttribute("title",title);
       model.addAttribute("description",description);
        model.addAttribute("keywords",keywords );
        String url="www.pollican.com/result/"+pid+"/a";
            model.addAttribute("url",url);
	
            String rslt=gson.toJson(poll_tbl);
            model.addAttribute("poll", rslt);
            
            List<Poll_Ans_Tbl> poll_ans_tbl_list=poll_ans_tbl.get_PollResult(pid);
           
            rslt=gson.toJson(poll_ans_tbl_list);
             
            model.addAttribute("result", rslt);
            model.addAttribute("page", "result");
           if(ud!=null)
               model.addAttribute("logged", 1);
           else
               model.addAttribute("logged", 0);
           
            
       
           return "result";
   } 
   
  @RequestMapping(value = "/result/{pid}",method = RequestMethod.GET)
   public void result(@PathVariable int pid, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
            Poll_TblJDBCTemplate poll_tbljdbc=new Poll_TblJDBCTemplate();
            Poll_Tbl poll_tbl=poll_tbljdbc.getPoll(pid);
	   response.sendRedirect(pid+"/"+poll_tbl.getPoll_link());
   }
   @RequestMapping(value = "/result",method = RequestMethod.GET)
   public String result_plain(@PathVariable int pid, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
            return "index";
   }
   @RequestMapping(value = "/report/{pid}/{ref_url}",method = RequestMethod.GET)
   public String report(@PathVariable int pid,@PathVariable String ref_url , ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
            System.out.println("In UrlController>result ");
            
            Poll_Ans_TblJDBCTemplate poll_ans_tbl=new Poll_Ans_TblJDBCTemplate();
            Poll_TblJDBCTemplate poll_tbljdbc=new Poll_TblJDBCTemplate();
            Poll_Tbl poll_tbl=poll_tbljdbc.getPoll(pid);
            if(!poll_tbl.getPoll_link().equals(ref_url))
            {
                response.sendRedirect(poll_tbl.getPoll_link());
               return "error";
            }
            String rslt=gson.toJson(poll_tbl);
            model.addAttribute("poll", rslt);
            
            List<Poll_Ans_Tbl> poll_ans_tbl_list=poll_ans_tbl.get_PollResult(pid);
           
            rslt=gson.toJson(poll_ans_tbl_list);
             model.addAttribute("delimiter", "../../");
            model.addAttribute("result", rslt);
            model.addAttribute("page", "report");
            int cs= checkSetCookie(request);
            if(cs==2)
               model.addAttribute("logged", 1);
           else
               model.addAttribute("logged", 0);
           
            
            
	   return "report";
   } 
   @RequestMapping(value = "/profile/{handle}", method = RequestMethod.GET)
   public String profile(@PathVariable String handle, ModelMap model,HttpServletRequest request) throws SQLException, IOException {
       User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
       
        User_Detail profile=user.get_profile(handle);
        //User_Detail ud;
        User_Detail ud=get_UserDetails(request);
        String rslt=gson.toJson(profile);
      
             String greet = ""+profile.getName()+" @"+profile.getHandle();
        model.addAttribute("title", greet);
       
       model.addAttribute("profile", rslt);
       System.out.println("fol=");
       if(ud != null)
       {try{
          Follow follow=ud.getFollow();
           String foll=gson.toJson(follow.getFollowers());
           System.out.println("fol="+foll);
           model.addAttribute("redirect",false);
        model.addAttribute("uid",ud.getUid());
        model.addAttribute("handle",ud.getHandle());
        model.addAttribute("profile_pic",ud.getProfile_pic());
           model.addAttribute("followers", gson.toJson(follow.getFollowers()));
           model.addAttribute("following", gson.toJson(follow.getFollowing()));
           model.addAttribute("loggedin", true);
       }
       catch(Exception e)
       {
           System.out.println("error="+e);
       }
       }
       else
       {
           int [] temp_follow=new int[1];
           temp_follow[0]=0;
           model.addAttribute("loggedin", false);
            model.addAttribute("redirect",true);
        model.addAttribute("red_url",request.getRequestURI());
         model.addAttribute("followers", gson.toJson(temp_follow));
         model.addAttribute("following", gson.toJson(temp_follow)); 
        model.addAttribute("uid",0);
        model.addAttribute("handle","");
       }
        String keywords="pollican,profile,polls,surveys";
      
       model.addAttribute("title","@"+handle);
       model.addAttribute("meta_description","Pollican Profile page of @"+handle);
        model.addAttribute("meta_keywords_org",keywords );
       model.addAttribute("page", "profile");
       model.addAttribute("header", "header.jspf");
         model.addAttribute("delimiter", "../");
        

	   return "profile";
   }
  @RequestMapping(value = "/editProfile", method = RequestMethod.GET)
   public String editProfile(@PathVariable  ModelMap model,HttpServletRequest request) throws SQLException {
     
      return "editProfile";
   }
   
  @RequestMapping(value = "/home", method = RequestMethod.GET)
   public String home(ModelMap model,HttpServletRequest request) throws IOException, SQLException {
         User_Detail ud=get_UserDetails(request);
               if(ud!=null)
       {
           model.addAttribute("dashboard_active", "active");
           model.addAttribute("viewpoll_active", "");
           model.addAttribute("createpoll_active", "");
           model.addAttribute("page", "dashboard");
           
        model.addAttribute("uid",ud.getUid());
        model.addAttribute("handle",ud.getHandle());
        model.addAttribute("profile_pic",ud.getProfile_pic());
        model.addAttribute("meta_description","Dashboard");
        //   model.addAttribute("meta_keywords_categs", ud.getCategory_list_json());
           model.addAttribute("meta_keywords_org", "pollican,dashboard,polls,surveys");
             model.addAttribute("title", "Pollican-Dashboard");
          
           return "dashboard";
       }
       else
       {
           return "redirect:index";
       }
	
   }
   
   @RequestMapping(value = "/notification", method = RequestMethod.GET)
   public String notication(HttpServletRequest request) throws IOException, SQLException {
        User_Detail ud=get_UserDetails(request);
               if(ud!=null)
       {
           return "notification";
       }
       else
       {
           return "redirect:index";
       }
	
   }
   
   @RequestMapping(value = "/template", method = RequestMethod.GET)
   public String template(ModelMap model,HttpServletRequest request) throws IOException, SQLException {
             model.addAttribute("delimiter", "");
           return "template";
	
   }
   
     @RequestMapping(value = {"/*","/*/*","/*/*/*"})
   public void AnyURL(@PathVariable String link, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException, ServletException {
            String url1=request.getRequestURI();
            String url2=request.getScheme() + "://" +   // "http" + "://
             request.getServerName() +       // "myhost"
             ":" + request.getServerPort() + // ":" + "8080"
             request.getRequestURI() +       // "/people"
            (request.getQueryString() != null ? "?" +
             request.getQueryString() : ""); 
            //request.getRequestDispatcher("").forward(request, response);
	  // response.sendRedirect("");
   }
   
   @RequestMapping(value = "/test", method = RequestMethod.GET)
   public String test(HttpServletRequest request) throws IOException, SQLException {
        
           return "test";
     
   }
   
}
