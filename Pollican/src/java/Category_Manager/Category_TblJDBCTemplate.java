/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Category_Manager;

import User_Manager.Exp_Json;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.sql.DataSource;
import model.connectivity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import com.google.gson.Gson;
/**
 *
 * @author Taha
 */
public class Category_TblJDBCTemplate {
    private DataSource dataSource;
   private JdbcTemplate jdbcTemplateObject;
   connectivity conn=null;
    public Category_TblJDBCTemplate() throws SQLException
    {
    ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
     conn=(connectivity)context.getBean("connectivity");
      
      this.dataSource=conn.getDataSource();
      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
      
    }

    public List<Category> Category_list() {
       String SQL = "select * from category_tbl ORDER BY group_name ASC, category_name ASC";
      List <Category> category = jdbcTemplateObject.query(SQL, new Category_Mapper());
      return category;
    }
   
   
    
}
