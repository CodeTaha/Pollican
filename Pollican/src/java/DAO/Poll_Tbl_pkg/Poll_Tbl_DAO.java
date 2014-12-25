/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DAO.Poll_Tbl_pkg;
import java.util.List;
import javax.sql.DataSource;
/**
 *
 * @author abc
 */
public interface Poll_Tbl_DAO {
     /** 
    * This is the method to be used to initialize
    * database resources ie. connection.
    */
  // public void setDataSource(DataSource ds);
   /** 
    * This is the method to be used to create
    * a record in the Student table.
    */
   public boolean create(int uid, String cid_json, String title, String description, String qtn_json, String ans_json, String poll_link, int reward, String poll_type);
   /** 
    * This is the method to be used to list down
    * a record from the Student table corresponding
    * to a passed student id.
    */
   //public Poll_Tbl getStudent(Integer id);
   /** 
    * This is the method to be used to list down
    * all the records from the Student table.
    */
  // public List<Poll_Tbl> listStudents();
   /** 
    * This is the method to be used to delete
    * a record from the Student table corresponding
    * to a passed student id.
    */
  // public void delete(Integer id);
   /** 
    * This is the method to be used to update
    * a record into the Student table.
    */
  // public void update(Integer id, Integer age);
}
