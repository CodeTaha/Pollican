/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DAO.Poll_Tbl_pkg;

import com.google.gson.Gson;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
/**
 *
 * @author abc
 */
public class Qtn_Mapper{
    Gson gson=new Gson();
     public Qtn mapRow(String[] qtn_st) throws SQLException {
      Qtn qtn_obj = new Qtn();
      qtn_obj.setQtn_id(Integer.parseInt(qtn_st[0]));
      qtn_obj.setPosition(Integer.parseInt(qtn_st[1]));
      qtn_obj.setQtn_type(qtn_st[2]);
      qtn_obj.setQtn(qtn_st[3]);
      if(qtn_obj.qtn_type.equals("tb"))
      {String arr[]=null;
          qtn_obj.setRows(arr);
      qtn_obj.setColumns(arr);
      }
      else
      {
      String[] rows=gson.fromJson(qtn_st[4],String[].class);
      qtn_obj.setRows(rows);
      if(!qtn_st[5].equals(""))
      {
      String[] columns=gson.fromJson(qtn_st[5],String[].class);
      qtn_obj.setColumns(columns);
      }
      else
      {
          String arr[]=null;
          qtn_obj.setColumns(arr);
      }
      }

      
      return qtn_obj;
   }
}
