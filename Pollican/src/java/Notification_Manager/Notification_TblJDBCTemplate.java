/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Notification_Manager;

import DAO.Poll_Tbl_pkg.Poll_Tbl;
import com.google.gson.Gson;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.sql.DataSource;
import model.connectivity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author Taha
 */
public class Notification_TblJDBCTemplate {
    private final DataSource dataSource;
    private final JdbcTemplate jdbcTemplateObject;
    Gson gson=new Gson();
    connectivity conn;
    public Notification_TblJDBCTemplate() throws SQLException
    {
    ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
    conn=(connectivity)context.getBean("connectivity");
     
      this.dataSource=conn.getDataSource();
      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
      
    }

   
    public List<Notification> listNotifications(String ts, int uid) {
       
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        
        String SQL;
        List <Notification> notification_tbl;//",2,|,9,|,10,"
       
        if(ts.equals(""))
        {
            SQL ="SELECT * FROM notifications where uid=? Order by ts desc limit 15;"; 
            notification_tbl = jdbcTemplateObject.query(SQL,new Object[]{uid}, new Notification_Mapper());
        }
        else
        {
            SQL ="SELECT * FROM notifications where uid=? and ts<? Order by ts desc limit 15"; 
            notification_tbl = jdbcTemplateObject.query(SQL,new Object[]{uid,ts}, new Notification_Mapper());
        }
      
      return notification_tbl;
   }

    public void clearNotificationChecked(String nid) 
    {
        String SQL;
       
      
            SQL ="UPDATE notifications SET checked=1 WHERE nid=?;"; 
            jdbcTemplateObject.update(SQL,new Object[]{nid});
        
    }
    
    
}
