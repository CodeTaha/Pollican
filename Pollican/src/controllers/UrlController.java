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
   private void logins(HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
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
                cookie.setMaxAge(-1);
                
                response.addCookie(cookie);
            
        }
    }
	   return "index";
   }
  
   @RequestMapping(value = {"/*","/*/*","/*/*/*"})
   public void AnyURL( ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException, ServletException {
            String url1=request.getRequestURI();
            String url2=request.getScheme() + "://" +   // "http" + "://
             request.getServerName() +       // "myhost"
             ":" + request.getServerPort() + // ":" + "8080"
             request.getRequestURI() +       // "/people"
            (request.getQueryString() != null ? "?" +
             request.getQueryString() : ""); 
            request.getRequestDispatcher("").forward(request, response);
	  // response.sendRedirect("");
   }
   
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
   public String dashboard(HttpServletRequest request) throws IOException, SQLException {
       if(checklogin(request))
       {
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
               if(checklogin(request))
            {
            System.out.println("Checklogin cleared");
            Category_TblJDBCTemplate cat=new Category_TblJDBCTemplate();
            List<Category> category=cat.Category_list();
            String cat_json=gson.toJson(category);
            System.out.println("cat list "+cat_json);
            model.addAttribute("cat_list", cat_json);
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
   public String viewPolls(HttpServletRequest request){
       if(checklogin(request))
       {
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
             
            model.addAttribute("result", rslt);
           
           
            
            
	   return "result";
   } 
   
  @RequestMapping(value = "/result/{pid}",method = RequestMethod.GET)
   public void result(@PathVariable int pid, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws SQLException, IOException {
            Poll_TblJDBCTemplate poll_tbljdbc=new Poll_TblJDBCTemplate();
            Poll_Tbl poll_tbl=poll_tbljdbc.getPoll(pid);
	   response.sendRedirect(pid+"/"+poll_tbl.getPoll_link());
   } 
   
   @RequestMapping(value = "/profile/{handle}", method = RequestMethod.GET)
   public String profile(@PathVariable String handle, ModelMap model,HttpServletRequest request) throws SQLException, IOException {
       User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
       
        User_Detail profile=user.get_profile(handle);
        String rslt=gson.toJson(profile);
        checklogin(request);
         
       model.addAttribute("profile", rslt);
       System.out.println("fol=");
       if(user_detail != null)
       {try{
          Follow follow=user_detail.getFollow();
           String foll=gson.toJson(follow.getFollowers());
           System.out.println("fol="+foll);
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
           model.addAttribute("loggedin", false);
       }
       
	   return "profile";
   }
  @RequestMapping(value = "/editProfile", method = RequestMethod.GET)
   public String editProfile(@PathVariable  ModelMap model,HttpServletRequest request) throws SQLException {
     
      return "editProfile";
   }
   
  @RequestMapping(value = "/activity", method = RequestMethod.GET)
   public String activity(HttpServletRequest request) throws IOException, SQLException {
        if(checklogin(request))
       {
           return "activity";
       }
       else
       {
           return "redirect:index";
       }
	
   }
   
   @RequestMapping(value = "/notification", method = RequestMethod.GET)
   public String notication(HttpServletRequest request) throws IOException, SQLException {
        if(checklogin(request))
       {
           return "notification";
       }
       else
       {
           return "redirect:index";
       }
	
   }
   
   
}
