/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package User_Manager;

import com.google.gson.Gson;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;
import model.connectivity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

/**
 *
 * @author Taha
 */
public class User_TblJDBCTemplate {
    //private final DataSource dataSource;
   private final JdbcTemplate jdbcTemplateObject;
   Gson gson=new Gson();
   String SQL="";
   connectivity conn=null;
   private Connection con=null;
    public User_TblJDBCTemplate() throws SQLException
    {
        ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
     conn=(connectivity)context.getBean("connectivity");
      
     
      this.jdbcTemplateObject = new JdbcTemplate(conn.getDataSource());
      
    }

    public User_Detail authenticate(String username, String password, int loginType) throws Exception {
      User_Detail user_detail=null;
       try{
      switch(loginType)
      {
          case 1: {
              SQL =   "select A.uid,A.followers,A.following,A.handle,C.category_list_json from login_tbl A, user_detail B, user_store C where (A.uid=B.uid and A.uid=C.uid and B.handle=?) \n" +
                      "OR \n" +
                      "(A.uid=B.uid and A.uid=C.uid and A.email=?);";
          }break;
          case 2: {System.out.println("authenticating for fb username="+username+" email="+password);
          SQL="select A.uid,A.followers,A.following,B.handle,C.category_list_json from login_tbl A, user_detail B, user_store C where (A.uid=B.uid and A.uid=C.uid and A.fb=?)OR (A.uid=B.uid and A.uid=C.uid and A.email=?);";
          user_detail=jdbcTemplateObject.queryForObject(SQL, new Object[]{username,password}, new User_Detail_Mapper(1));
          }break;
          case 3: {System.out.println("authenticating for Direct username="+username+" password="+password);
          String tempPass=encrypt(password);
          SQL="select A.uid,A.followers,A.following,A.handle,C.category_list_json from login_tbl A, user_detail B, user_store C where (A.uid=B.uid and A.uid=C.uid and A.email=? and A.hashed_password=?)OR (A.uid=B.uid and A.uid=C.uid and A.handle=? and A.hashed_password=?);";
          user_detail=jdbcTemplateObject.queryForObject(SQL, new Object[]{username,tempPass,username,tempPass}, new User_Detail_Mapper(1));
          }break;
      }
      
           
       }
       catch(DataAccessException e)
       {System.out.println("User does not exist "+e);
       user_detail=null;
       }
      return user_detail;
    }
    private String encrypt(String x) throws Exception {
   MessageDigest m = MessageDigest.getInstance("MD5");
    m.update(x.getBytes("UTF8"));
    byte s[] = m.digest();
    String result = "";
    for (int i = 0; i < s.length; i++) {
      result += Integer.toHexString((0x000000ff & s[i]) | 0xffffff00).substring(6);
    }
    //return d.digest();
    return result;
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
    /*URL url = new URL(profile_pic);
                InputStream in = new BufferedInputStream(url.openStream());
                ByteArrayOutputStream out1 = new ByteArrayOutputStream();
                byte[] buf = new byte[1024];
                int n = 0;
                while (-1!=(n=in.read(buf)))
                {
                   out1.write(buf, 0, n);
                }
                out1.close();
                in.close();
                byte[] response1 = out1.toByteArray();
                 java.util.Date date= new java.util.Date();
                Timestamp ts=new Timestamp(date.getTime());
                String profile_pic1=handle+ts+".jpg";
                FileOutputStream fos = new FileOutputStream("C:/Users/Taha/Documents/GitHub/PollingDuck-Spring/PollingDuck-Spring/web/WEB-INF/pages/profile_pics/"+profile_pic1);
                fos.write(response1);
                fos.close();*/
    public boolean createUser(String handle,String name,String email,String country,String state,String city,String zip,String religion,String sex,String dob,String phone,String profile_pic,int category[], String fb, String hashedpassword ) throws SQLException, FileNotFoundException, IOException, Exception
   {
       System.out.println("In User_Tbl_JDBCTemplate> createUser");
        System.out.println(" Handle "+handle +" name "+name+" email "+email+" country "+country+" state "+state+" city "+city+" zip "+zip+" religion "+ religion+" sex "+sex+" dob "+dob+" phone "+phone+" profile_pic "+profile_pic+" categ "+ Arrays.toString(category) +" fb "+fb+"hashed password "+hashedpassword);
        String password=encrypt(hashedpassword);
        //System.out.println(testpass);
        /* Code for User_Store */
          /*  URL url = new URL(profile_pic);
            ByteArrayOutputStream out1;
       try (InputStream in = new BufferedInputStream(url.openStream())) 
            {
                out1 = new ByteArrayOutputStream();
                byte[] buf = new byte[1024];
                int n = 0;
                while (-1!=(n=in.read(buf)))
                {
                    out1.write(buf, 0, n);
                }
                System.out.println("In try 1");
                out1.close();
            }
                    byte[] response1 = out1.toByteArray();
                    java.util.Date date= new java.util.Date();
                    Timestamp ts=new Timestamp(date.getTime());
                    String profile_pic1=handle+".jpg";
                    System.out.println("out of try1. image .jpg is:"+profile_pic1);   
       try (FileOutputStream fos = new FileOutputStream("C:\\Users\\Rishi\\Documents\\GitHub\\PollingDuck-Spring\\web\\WEB-INF\\pages\\profile_pics"+profile_pic1))
            {
                fos.write(response1);
                fos.close();
                System.out.println("In try 2");
            }
        
            System.out.println("out of try 2");
           
            */
            
            
            String category_list_json=Arrays.toString(category);
            //System.out.println("Category list="+category_list_json);
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
           // System.out.println("next up is callablestatement");
            String exp_json=gson.toJson(exp);
             CallableStatement st;
       /* (IN handle_i varchar(45),IN username_i varchar(45),IN email_i varchar(45),IN country_i varchar(45),
IN state_i varchar(45),IN city_i varchar(45),IN zip_i varchar(45),IN religion_i varchar(45),IN sex_i varchar(45),IN dob_i varchar(45),IN phone_i varchar(45),
IN profile_pic_i varchar(45),IN fb_i varchar(100), IN category_list_json_i varchar(1000),IN exp_json_i varchar(1000),IN fish_i int)*/
            try{
               
             con=conn.getDataSource().getConnection();
             System.out.println("10 dec 4pm"); 
             st=con.prepareCall("call createUser2('"+handle+"','"+name+"','"+email+"','"+country+"','"+state+"','"+city+"','"+zip+"','"+religion+"','"+sex+"'"
                    + ",'"+dob+"','"+phone+"','"+profile_pic+"','"+fb+"','"+category_list_json+"','"+exp_json+"',"+0+",'"+password+"')");
             st.executeQuery();
             con.close();
             System.out.println("11 dec 2am");
             return true;
            }
          catch(Exception e)
          {
              System.out.println("CreateUser2 procedure error="+e);
              return false;
          }
           
           
       
      
   }
    public boolean createUser_ole(String handle,String name,String email,String country,String state,String city,String zip,String religion,String sex,String dob,String phone,String profile_pic,int category[], String fb )
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
           SQL = "insert into login_tbl(fb,email,handle) values(?,?,?)";// Inserting into login_tbl
           try{
           jdbcTemplateObject.update( SQL, fb,email,handle);// adding email in login_tbl
            SQL="select uid from login_tbl where email=?";// fetchin the uid for newly entered row
            int uid=jdbcTemplateObject.queryForObject(SQL, new Object[]{email}, Integer.class);
            
            
           
            int rs1=0,rs2=0;
            try{SQL="insert into user_detail(uid,handle,username,country,state,city,zip,religion,sex,dob,phone,profile_pic) values(?,?,?,?,?,?,?,?,?,?,?,?)";
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
        SQL="select A.uid,A.followers,A.following,A.fb,A.email, B.handle,B.username,B.city,B.country,B.dob,B.sex,B.state,B.profile_pic,B.phone,B.religion,B.zip ,C.exp_json,C.category_list_json,C.lc,C.fish from login_tbl A, user_detail B, user_store C where A.uid=(select uid from user_detail where handle=?) and B.handle=? and C.uid=A.uid;";
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
        SQL="select A.uid, B.handle,B.username,B.profile_pic,A.followers, A.following from login_tbl A, user_detail B where A.uid=? and B.uid=?";
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
        {
        con=conn.getDataSource().getConnection();
        PreparedStatement st=con.prepareStatement("SELECT A.following,B.followers FROM login_tbl A, login_tbl B where A.uid=? and B.uid=?;");
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
       
        st=con.prepareStatement("UPDATE login_tbl SET following=? WHERE uid=?;");
        st.setObject(1, loggedin_user_following.toString());
        st.setObject(2,loggedin_user);   
        //System.out.println("query for following"+st);
        st.execute();
       //st.addBatch();
        st=con.prepareStatement("UPDATE login_tbl SET followers=? WHERE uid=?;");
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
        finally
        {
            con.close();
        }
    }
    public boolean updateExp(int uid,String cid_JSON,String exp)
    {
           System.out.println(" tk uid "+uid +" cid "+cid_JSON + " exp "+ exp);
       try
        {
       String cid_split[]= cid_JSON.split(",");
        int k = 0;
            String cid_splitted[]=cid_JSON.split(",");
            int cid_splitt[]=new int[cid_splitted.length];
            for(k=0;k<cid_splitted.length;k++)
                    cid_splitt[k]=Integer.parseInt(cid_splitted[k]);
            
            
                 SQL = "UPDATE uid_cid_mapper SET exp=exp+10 WHERE uid=? and cid IN ("+cid_JSON+")";
                
                 jdbcTemplateObject.update(SQL,uid);
               /* SQL = "UPDATE uid_cid_mapper SET exp=exp+10 WHERE uid=? and cid=?";
                int what=0;
                for(k=0;k<cid_splitt.length;k++)
                {  what =   jdbcTemplateObject.update(SQL,uid,cid_splitt[k]);
                     System.out.println("exp updated what new"+what);
                }*/
       
       /* int count=0;
        for(int i=0;i<cid_split.length;i++)
        {
            if(exp.contains("cid="+cid_split[i]+".0"))
                    { count ++;
                    }
        }
      
       int index[]=new int[count];
       int index2[]=new int[count];
        for(int i=0,j=0;i<cid_split.length;i++)
        {
            if(exp.contains("cid="+cid_split[i]+".0"))
                    { index[j] = exp.indexOf("cid="+cid_split[i]+".0")+13;
                     index2[j] = exp.indexOf(".0",index[j]);
                             j++;
                    }
        }
         for(int i=0;i<index.length;i++)
         {
          exp = exp.replaceFirst(exp.substring(index[i],index2[i]),(Integer.parseInt(exp.substring(index[i],index2[i]))+10)+"");
         }
         exp=exp.replace("cid","\"cid\"");
         exp=exp.replace("exp","\"exp\"");
         exp=exp.replace(".0","");
         exp=exp.replace(", ",",");
         exp=exp.replace("=",":");
       //[{cid=1.0, exp=1010.0}, {cid=2.0, exp=1010.0}, {cid=4.0, exp=1010.0}, {cid=5.0, exp=1000.0}, {cid=95.0, exp=1000.0}, {cid=141.0, exp=1000.0}]
       //[{"cid":1,"exp":1000},{"cid":2,"exp":1000},{"cid":4,"exp":1000},{"cid":5,"exp":1010},{"cid":95,"exp":1000},{"cid":141,"exp":1000}]
      // [{"cid":1,"exp":1010},{"cid":2,"exp":1010},{"cid":4,"exp":1010},{"cid":5,"exp":1000},{"cid":95,"exp":1000},{"cid":141,"exp":1000}]
        
           
                
                String SQL2="UPDATE user_store SET exp_json=? where uid=?";
                 int what2 =   jdbcTemplateObject.update(SQL2,exp,uid);
                     System.out.println("exp updated what old"+what2);*/
        
        }    
        catch(DataAccessException e)
        {
            System.out.println("Error occured in User_TblJDBC>updating experiences "+e);
           return false;
        }
       
       return true;
       
       
    }
    
    public void closeConnection()
    {
        
    }
    public int handleCount (String handle)
    {  int count = 1;
        String SQL="select count(*) from user_detail where handle=?";
        try
        {
            count  = jdbcTemplateObject.queryForObject(SQL, new Object[]{handle}, Integer.class);
        }
        catch(DataAccessException e)
        {   
            System.out.println(e.getMessage());
        }
        return count;
    }
}
