/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Notification_Manager;

/**
 *
 * @author Taha
 */
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
/**
 *
 * @author abc
 */
public class Notification_Mapper implements RowMapper<Notification>{
     @Override
     public Notification mapRow(ResultSet rs, int rowNum) throws SQLException 
     {
      Notification notification = new Notification();
      notification.setNid(rs.getInt("nid"));
      notification.setUid(rs.getInt("uid"));
      notification.setLink(rs.getString("link"));
      notification.setNotification(rs.getString("notification"));
      notification.setTs(rs.getString("ts"));
      notification.setChecked(rs.getShort("checked"));
      return notification;
   }
}
