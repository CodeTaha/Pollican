/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DAO.Poll_Tbl_pkg;
import com.google.gson.Gson;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import javax.sql.DataSource;
import model.connectivity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
/**
 *
 * @author abc
 */
public class Poll_TblJDBCTemplate  {
   private DataSource dataSource;
   private JdbcTemplate jdbcTemplateObject;
   Gson gson=new Gson();
   connectivity conn;
    public Poll_TblJDBCTemplate() throws SQLException
    {
    ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
    conn=(connectivity)context.getBean("connectivity");
     
      this.dataSource=conn.getDataSource();
      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
      
    }
   /*@Override
   public void setDataSource(DataSource dataSource) {
      this.dataSource = dataSource;
      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
   }*/

  
   public boolean create(int uid, String cid_json, String title, String description, String qtn_json, String ans_json, String poll_link, String start_ts,String end_ts,int reward, String poll_type)
   {
       String SQL = "insert into poll_tbl(uid,cid_json,title,description,qtn_json,ans_json,poll_link,start_ts,end_ts,reward,poll_type) values(?,?,?,?,?,?,?,?,?,?,?)";
     
     int ty=jdbcTemplateObject.update( SQL, uid, cid_json,title,description, qtn_json, ans_json,poll_link,start_ts,end_ts, reward, poll_type);
        
     return true;
   }
   
   public List<Poll_Tbl> listPolls(String ts, int uid, int[] user_cat_list) {
       
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        
        String SQL;
        List <Poll_Tbl> poll_tbl;//",2,|,9,|,10,"
        String likeClause=","+user_cat_list[0]+",";
        for(int i=1; i<user_cat_list.length;i++)
        {
            likeClause=likeClause+"|,"+user_cat_list[i]+",";
        }
        if(ts.equals(""))
        {System.out.println("in listPolls() if");
           //SQL ="SELECT * FROM pollingduck.poll_tbl where start_ts<=? and end_ts>=? Order by start_ts desc limit 5"; //"select * from poll_tbl";
           // SQL ="SELECT * FROM pollingduck.poll_tbl where pid NOT IN (select pid from poll_ans_tbl where uid=?) and start_ts<? and end_ts>=? Order by start_ts desc limit 5"; //"select * from poll_tbl";
            SQL ="SELECT * FROM poll_tbl where (cid_json REGEXP \""+likeClause+"\") and (pid NOT IN (select pid from poll_ans_tbl where uid=?)) and (start_ts<=? and end_ts>=?) Order by start_ts desc limit 5;"; //"select * from poll_tbl";
            poll_tbl = jdbcTemplateObject.query(SQL,new Object[]{uid,dateFormat.format(date),dateFormat.format(date)}, new Poll_Tbl_Mapper(conn));
        }
        else
        {System.out.println("in listPolls() else");
            
//            SQL ="SELECT * FROM pollingduck.poll_tbl where start_ts<? and end_ts>=? Order by start_ts desc limit 5"; //"select * from poll_tbl";
            SQL ="SELECT * FROM pollingduck.poll_tbl where (cid_json REGEXP \""+likeClause+"\") and (pid NOT IN (select pid from poll_ans_tbl where uid=?)) and (start_ts<? and end_ts>=?) Order by start_ts desc limit 5"; //"select * from poll_tbl";
            poll_tbl = jdbcTemplateObject.query(SQL,new Object[]{uid,ts,dateFormat.format(date)}, new Poll_Tbl_Mapper(conn));
        }
      
      return poll_tbl;
   }
   
   public boolean submitPoll(String finalJSON, int anonymous, int poll_uid, String poll_link, String notification) throws SQLException
    {System.out.println("in model_polls --> submitPoll()");
        String detail[]= gson.fromJson(finalJSON, String[].class);
        
   String SQL = "insert into poll_ans_tbl(pid,uid,ans_json,anonymous) values(?,?,?,?)";
   String notify="insert into notifications(uid,notification,link) values(?,?,?)";
      try
      {
          int rslt=jdbcTemplateObject.update( SQL, detail[0], detail[1],detail[2], anonymous);
          jdbcTemplateObject.update( notify, poll_uid,notification,"result/"+detail[0]+"/"+poll_link);
          
      System.out.println("Poll ans submitted rslt="+rslt);
      }
      catch(DataAccessException e)
      {
          System.out.println("error occured in Poll_TblJDBCTemplate>submitPoll "+e);
      }
    
        
       return true;
        
    }
   
   public Poll_Tbl getPoll(int pid) {
      String SQL = "select * from poll_tbl where pid=?";
      List <Poll_Tbl> poll_tbl = jdbcTemplateObject.query(SQL, new Object[]{pid},new Poll_Tbl_Mapper(conn));
      return poll_tbl.get(0);
   }
   
   public List<Poll_Tbl> ListMyPolls(int uid) {
       
      String SQL = "select * from poll_tbl where uid=?";
      List <Poll_Tbl> poll_tbl = jdbcTemplateObject.query(SQL,new Object[]{uid}, new Poll_Tbl_Mapper(conn));
      return poll_tbl;
}
   public List<Poll_Tbl> listActivityPolls(String ts, int [] following) {
        System.out.println("in Poll_tblJDBCTemplate >listPolls()");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        System.out.println("Todays date="+dateFormat.format(date)+" ts="+ts);
        String SQL;
        System.out.println("arr2"+Arrays.toString(following));
        String fp = Arrays.toString(following);
        fp=fp.replace("[","");
        fp=fp.replace("]","");
        System.out.println("neha sharma ..."+fp);
        List <Poll_Tbl> poll_tbl;
        if(ts.equals(""))
        {System.out.println("in listPolls() if");
            SQL ="SELECT * FROM pollingduck.poll_tbl where start_ts<=? and end_ts>=? and uid in ("+fp+") Order by start_ts desc"; //"select * from poll_tbl";
            poll_tbl = jdbcTemplateObject.query(SQL,new Object[]{date,date}, new Poll_Tbl_Mapper(conn));
        }
        else
        { System.out.println("in listPolls() else");
            SQL ="SELECT * FROM pollingduck.poll_tbl where start_ts<? and end_ts>=? and uid in ("+fp+") Order by start_ts desc limit 5"; //"select * from poll_tbl";
            poll_tbl = jdbcTemplateObject.query(SQL,new Object[]{ts,date}, new Poll_Tbl_Mapper(conn));
        }
      
      return poll_tbl;
   }
   
}
