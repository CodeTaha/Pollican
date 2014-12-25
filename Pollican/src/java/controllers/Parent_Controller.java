/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers;

import User_Manager.User_Detail;
import User_Manager.User_TblJDBCTemplate;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;

/**
 *
 * @author Taha
 */
@Controller
public class Parent_Controller {
    protected final Gson gson=new Gson();
    protected User_Detail user_detail;
    protected boolean loggedin=false;
    protected int uid=0;
    protected String handle="";
    protected int cat_list[];
    Cookie[] cookies;
    boolean cookiesSet=false;
    
    public boolean checklogin(HttpServletRequest request)
   {
       try{
       int cs=checkSetCookie(request);
       
   
       if(user_detail!=null && cs==2)
       {
               if(uid==user_detail.getUid() && handle.equals(user_detail.getHandle()))
               {
                  loggedin=true;
                  cat_list=user_detail.getCategory_list_json();
               }
               else
               {
                   user_detail=null;
               }
           
       }
       
       else if(user_detail==null && cookiesSet)
       {
               User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
               cat_list=user.get_category_list_json(uid);
               user_detail=user.get_profile(handle);
               loggedin=true;
           
       }
       
       else if(user_detail==null && !cookiesSet)
       {
         loggedin=false;
       }
       
               
       return loggedin;
       }
       catch(Exception e)
       {
           System.out.println("In checklogin() error occured is "+e);
           return false;
       } 
    }
    
    public Cookie set_Cookie(String name, String value, int ttl)
    {
        Cookie cookie = new Cookie(name, value);
            cookie.setMaxAge(ttl*60*60);
            return cookie;
            //response.addCookie(cookie); 
    }

    public User_Detail getUser_detail() {
        return user_detail;
    }

    public int getUid() {
        return uid;
    }

    public String getHandle() {
        return handle;
    }

    public int[] getCat_list() {
        return cat_list;
    }
    
    public int checkSetCookie(HttpServletRequest request)
    {
        cookies= request.getCookies();
        int countcookies=0;
        for (Cookie cookie1 : cookies) 
           {
            switch (cookie1.getName()) 
            {
               case "handle":
                    System.out.println("Got Handle cookie");
                   handle=cookie1.getValue();
                   countcookies++;
                   break;
               case "uid":
                   System.out.println("Got uid cookie");
                   uid=Integer.parseInt(cookie1.getValue());
                   countcookies++;
                   break;
            }
           }
        if(countcookies==0)
        {
            
            return 0;
        }
        else
        {
            cookiesSet=true;
            return 2;
            
        }
    }
    
    public User_Detail get_UserDetails(HttpServletRequest request) throws SQLException
    {
        User_Detail ud;
        int cs= checkSetCookie(request);
        if(cs==2)
        {User_Manager.User_TblJDBCTemplate user=new User_TblJDBCTemplate();
        ud=user.get_profile(handle);
        }
        else
        {
            ud=null;
        }
        return ud;
    }
    
}
