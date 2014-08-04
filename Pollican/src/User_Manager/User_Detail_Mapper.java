/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package User_Manager;

/**
 *
 * @author Taha
 */
import com.google.gson.Gson;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import org.springframework.jdbc.core.RowMapper;
/**
 *
 * @author abc
 */
public class User_Detail_Mapper implements RowMapper<User_Detail>
{
    Gson gson=new Gson();
    int i;
    public User_Detail_Mapper(int i)
    {
       this.i=i;
    }
     @Override
     public User_Detail mapRow(ResultSet rs, int rowNum) throws SQLException {
         User_Detail user = new User_Detail();
         switch(i)
         {
             case 1:{
                    System.out.println("In User_Detail_Mapper row1");
                    user.setUid(rs.getInt("uid"));
                    user.setCategory_list_json(rs.getString("category_list_json"));
                    user.setHandle(rs.getString("handle"));
                    String followers=rs.getString("followers");
                    String following=rs.getString("following");
                    user.setFollow(rs.getInt("uid"),followers,following);
                    }break;
             case 2:{
                    System.out.println("In User_Detail_Mapper row2");
                    //A.uid,A.fb,A.email, B.handle,B.name,B.city,B.country,B.dob,B.state,B.profile_pic,B.phone,B.religion,B.zip ,C.exp_json,C.category_list_json,C.lc,C.fish
                    user.setUid(rs.getInt("uid"));
                    user.setHandle(rs.getString("handle"));
                    String followers=rs.getString("followers");
                    String following=rs.getString("following");
                    user.setFollow(rs.getInt("uid"),followers,following);
                    user.setExp_json(rs.getString("exp_json"));
                    user.setCategory_list_json(rs.getString("category_list_json"));
                    user.setCity(rs.getString("city"));
                    user.setCountry(rs.getString("country"));
                    user.setEmail(rs.getString("email"));
                    user.setDob(rs.getString("dob"));
                    user.setFb(rs.getString("fb"));
                    user.setFish(rs.getInt("fish"));
                   user.setLc(rs.getString("lc"));
                   user.setName(rs.getString("name"));
                   user.setPhone(rs.getString("phone"));
                   user.setProfile_pic(rs.getString("profile_pic"));
                   user.setReligion(rs.getString("religion"));
                   user.setSex(rs.getString("sex"));
                   user.setZip(rs.getString("zip"));
                   
             }break;    
            case 3:{
                    System.out.println("In User_Detail_Mapper row3");
                    user.setUid(rs.getInt("uid"));
                    user.setHandle(rs.getString("handle"));
                    user.setName(rs.getString("name"));
                    user.setProfile_pic(rs.getString("profile_pic"));
                    
                    }break;     
                 
         }
        
      
      
      return user;
   }
     
    
    
}
