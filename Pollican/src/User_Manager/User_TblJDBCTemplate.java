/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package User_Manager;

import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.sql.DataSource;
import model.connectivity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author Taha
 */
public class User_TblJDBCTemplate {
    private final DataSource dataSource;
   private final JdbcTemplate jdbcTemplateObject;
   Gson gson=new Gson();
   String SQL="";
   connectivity conn=null;
    public User_TblJDBCTemplate() throws SQLException
    {
    ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
     conn=(connectivity)context.getBean("connectivity");
      
      this.dataSource=conn.getDataSource();
      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
      
    }

    public User_Detail authenticate(String username, String password, int loginType) {
        //loginType can be 
        //local=1
        //fb=2
        //twitter=3
        // google=4
        switch(loginType)
        {
            case 1: {
                        SQL =   "select A.uid,A.followers,A.following,B.handle,C.category_list_json from login_tbl A, user_detail B, user_store C where (A.uid=B.uid and A.uid=C.uid and B.handle=?) \n" +
                            "OR \n" +
                            "(A.uid=B.uid and A.uid=C.uid and A.email=?);";
                    }break;
            case 2: {System.out.println("authenticating for fb username="+username+" email="+password);
                        SQL="select A.uid,A.followers,A.following,B.handle,C.category_list_json from login_tbl A, user_detail B, user_store C where (A.uid=B.uid and A.uid=C.uid and A.fb=?)OR (A.uid=B.uid and A.uid=C.uid and A.email=?);";
                    }    
        }
        
        
       User_Detail user_detail;
       
      try{
           user_detail=jdbcTemplateObject.queryForObject(SQL, new Object[]{username,password}, new User_Detail_Mapper(1));
      }
      catch(DataAccessException e)
      {System.out.println("User does not exist "+e);
          user_detail=null;
      }
      //return rslt;
        
        return user_detail;
    }
    
    public int[] get_category_list_json(int uid)
    {
        SQL="select category_list_json from user_store where uid=?";
        try
        {
            String rslt=jdbcTemplateObject.queryForObject(SQL, new Object[]{uid}, String.class);
            User_Detail user_detail=new User_Detail();
            user_detail.setCategory_list_json(rslt);
            return user_detail.getCategory_list_json();
        }
        catch(DataAccessException e)
        {int fail[]=new int[0];
            System.out.println("Error occured in User_TblJDBC>get_category_list_json "+e);
            return fail;
        }
    }
    
    public boolean createUser(String handle,String name,String email,String country,String state,String city,String zip,String religion,String sex,String dob,String phone,String profile_pic,int category[], String fb )
   {
       System.out.println("In User_Tbl_JDBCTemplate> createUser");
        /* Code for User_Store */
            
            String category_list_json=Arrays.toString(category);
            System.out.println("Category list="+category_list_json);
            List<Exp_Json> exp = new ArrayList();
            Exp_Json obj = null;
            for(int i=0; i<category.length; i++)
            {
            obj=new Exp_Json(category[i]);
                try{exp.add(obj);}
                catch(Exception e)
                {
                    System.out.println("Errror in Exp_json="+e);
                    return false;
                }
                
                
            }
            //System.out.println("reached3");
            String exp_json=gson.toJson(exp);
            System.out.println("Exp_Json="+exp);
        SQL="select uid from login_tbl where email=?";
       try
       {int rslt=jdbcTemplateObject.queryForObject(SQL, new Object[]{email}, Integer.class);// If user is already registered using the email bfr
       return false;
       }
       catch(DataAccessException e)
       {
          
       
           System.out.println("In catch");
           SQL = "insert into login_tbl(fb,email) values(?,?)";// Inserting into login_tbl
           try{
           jdbcTemplateObject.update( SQL, fb,email);// adding email in login_tbl
            SQL="select uid from login_tbl where email=?";// fetchin the uid for newly entered row
            int uid=jdbcTemplateObject.queryForObject(SQL, new Object[]{email}, Integer.class);
            
            
           
            int rs1=0,rs2=0;
            try{SQL="insert into user_detail(uid,handle,name,country,state,city,zip,religion,sex,dob,phone,profile_pic) values(?,?,?,?,?,?,?,?,?,?,?,?)";
             rs1=jdbcTemplateObject.update( SQL, uid,handle,name,country,state,city,zip,religion,sex,dob,phone,profile_pic);
            }
            catch(DataAccessException f)
            {
                System.out.println("Error occured in createUser while inserting row in user_detail e="+f);
            }
            try{
                SQL="insert into user_store(uid,category_list_json,exp_json,fish) values(?,?,?,?)";
                rs2=jdbcTemplateObject.update( SQL, uid,category_list_json,exp_json,1000);
            }
            catch(DataAccessException f)
            {
                System.out.println("Error occured in createUser while inserting row in user_store e="+f);
            }
            if(rs1==1 && rs2==1)
            {
                System.out.println("Successfully created a new user");
                return true;
            }
            else
            {
                //Write a code to revert all transactions and delete new entries
                System.out.println("User cannot be created rs1="+rs1+" rs2="+rs2);
            }
           }
           catch(DataAccessException f)
           {
               System.out.println("error="+f);
           }
           
           return true;
       }
      
   }
    
    public User_Detail get_profile(String handle)
    {
         User_Detail profile=null;
        SQL="select A.uid,A.followers,A.following,A.fb,A.email, B.handle,B.name,B.city,B.country,B.dob,B.sex,B.state,B.profile_pic,B.phone,B.religion,B.zip ,C.exp_json,C.category_list_json,C.lc,C.fish from login_tbl A, user_detail B, user_store C where A.uid=(select uid from user_detail where handle=?) and B.handle=? and C.uid=A.uid;";
        try
        {
            profile=jdbcTemplateObject.queryForObject(SQL, new Object[]{handle,handle}, new User_Detail_Mapper(2));
            
        }
        catch(DataAccessException e)
        {
            System.out.println("Error occured in User_TblJDBC>get_profile "+e);
           
        }
        return profile;
    }
    
    public User_Detail get_profile(int uid)
    {
         User_Detail profile=null;
        SQL="select A.uid, B.handle,B.name,B.profile_pic from login_tbl A, user_detail B where A.uid=? and B.uid=?";
        try
        {
            profile=jdbcTemplateObject.queryForObject(SQL, new Object[]{uid,uid}, new User_Detail_Mapper(3));
            
        }
        catch(DataAccessException e)
        {
            System.out.println("Error occured in User_TblJDBC>get_profile "+e);
           
        }
        return profile;
    }
       
    public boolean addreducefishes(int uid,int fishes,int addreduce)
    {
        if(addreduce==0)
          SQL="update user_store set fish=fish-? where uid=?";
        else 
            SQL="update user_store set fish=fish+? where uid=?";
      //  SQL="select A.uid, B.handle,B.name,B.profile_pic from login_tbl A, user_detail B where A.uid=? and B.uid=?";
        try
        {
          int what =   jdbcTemplateObject.update(SQL,fishes,uid);
        System.out.println("fishes hue change"+what);
        }
        catch(DataAccessException e)
        {
            System.out.println("Error occured in User_TblJDBC>reducefishes "+e);
           return false;
        }
       return true;
    }
    
    public boolean follow_Unfollow(int loggedin_user, int profile_user, int cmd) throws SQLException
    {
        /* 
        follower- is the logged in user sending request to follow/unfollow
        followed- is the user who follower wants to follow or unfollow
        */
        
        try
        {PreparedStatement st=conn.getCon().prepareStatement("SELECT A.following,B.followers FROM login_tbl A, login_tbl B where A.uid=? and B.uid=?;");
        st.setInt(1,loggedin_user);
        st.setInt(2, profile_user);
        ResultSet rs=st.executeQuery();
      
        
        rs.next();
        ArrayList<Integer> profile_user_followers=gson.fromJson(rs.getString("followers"),ArrayList.class);
        ArrayList<Integer> loggedin_user_following=gson.fromJson(rs.getString("following"),ArrayList.class);
        

            
            switch(cmd)
            {
                case 0:  {//unfollow
                                profile_user_followers.remove(loggedin_user+.0);
                                loggedin_user_following.remove(profile_user+.0);
                                
//                           
                            
                        }break;
                case 1:{//follow
                        profile_user_followers.add(loggedin_user);
                        loggedin_user_following.add(profile_user);
                
                        }break;
            }
       
        // IMPORTANT Make a transaction or a batch execution here
       
        st=conn.getCon().prepareStatement("UPDATE login_tbl SET following=? WHERE uid=?;");
        st.setObject(1, loggedin_user_following.toString());
        st.setObject(2,loggedin_user);   
        //System.out.println("query for following"+st);
        st.execute();
       //st.addBatch();
        st=conn.getCon().prepareStatement("UPDATE login_tbl SET followers=? WHERE uid=?;");
        st.setObject(1, profile_user_followers.toString());
        st.setObject(2,profile_user);
        //System.out.println("query for followers"+st);
        st.execute();
        //st.addBatch();
     //int rslt[]=st.executeBatch();
        return true;
    }
        catch(Exception e)
        {
            return false;
        }
    }
    
}
