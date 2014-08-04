/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Poll_Ans_Tbl;

import User_Manager.User_Detail;
import User_Manager.User_TblJDBCTemplate;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author abc
 */
public class Poll_Ans_Tbl_Mapper implements RowMapper<Poll_Ans_Tbl> {
    private int count=1;
    @Override
     public Poll_Ans_Tbl mapRow(ResultSet rs, int rowNum) throws SQLException {
         
      Poll_Ans_Tbl poll_ans_tbl = new Poll_Ans_Tbl();
      poll_ans_tbl.setPid(rs.getInt("pid"));
      poll_ans_tbl.setPoll_ans_key(rs.getInt("poll_ans_key"));
      
      poll_ans_tbl.setSolve_ts(rs.getString("solve_ts"));
      poll_ans_tbl.setQtn(rs.getString("ans_json"));
      int anonymous=rs.getInt("anonymous");
      poll_ans_tbl.setAnonymous(anonymous);
      User_Detail user=new User_Detail();
      if(anonymous==0)
      {
            poll_ans_tbl.setUid(rs.getInt("uid"));
            User_TblJDBCTemplate user_jdbc= new User_TblJDBCTemplate();
            user=user_jdbc.get_profile(rs.getInt("uid"));
            poll_ans_tbl.setUser(user);
      }
      else
      {//if the user solved poll anonymously
            poll_ans_tbl.setUid(0);
            user.setName("Anonymous-"+count);
            user.setHandle("Anonymous-"+count);
            user.setUid(0);
            user.setProfile_pic("pages/resources/images/profile/anonymous.jpg");
            poll_ans_tbl.setUser(user);
            count++;
      }
      
      
      
      return poll_ans_tbl;
   }
}
