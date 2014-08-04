/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Poll_Ans_Tbl;
import DAO.Poll_Tbl_pkg.Poll_Tbl;
import DAO.Poll_Tbl_pkg.Poll_Tbl_Mapper;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import model.connectivity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
/**
 *
 * @author abc
 */
public class Poll_Ans_TblJDBCTemplate {
    private DataSource dataSource;
   private JdbcTemplate jdbcTemplateObject;
   connectivity conn=null;
    public Poll_Ans_TblJDBCTemplate() throws SQLException
    {
    ApplicationContext context =new ClassPathXmlApplicationContext("Beans.xml");
     conn=(connectivity)context.getBean("connectivity");
      
      this.dataSource=conn.getDataSource();
      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
      
    }
    
    public List<Poll_Ans_Tbl> get_PollResult(int pid) {
       String SQL = "select * from poll_ans_tbl where pid=?";
      List <Poll_Ans_Tbl> category = jdbcTemplateObject.query(SQL, new Object[]{pid},new Poll_Ans_Tbl_Mapper());
      return category;
    }
     public List<Poll_Ans_Tbl> ListMySolvedPolls(int uid) {
       System.out.println("in list my solved polls");
      String SQL = "select * from poll_ans_tbl where uid=?";
      List <Poll_Ans_Tbl> poll_ans_tbl = jdbcTemplateObject.query(SQL,new Object[]{uid}, new Poll_Ans_Tbl_Mapper());
      return poll_ans_tbl;
}
}
