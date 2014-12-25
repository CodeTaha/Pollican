/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Category_Manager;

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
public class Category_Mapper implements RowMapper<Category>{
     @Override
     public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
      Category category = new Category();
      category.setCid(rs.getInt("cid"));
      category.setCategory_name(rs.getString("category_name"));
      category.setGroup(rs.getString("group_name"));
      
      
      return category;
   }
}
