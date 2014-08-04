/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DAO.Poll_Tbl_pkg;

import Category_Manager.Category;
import User_Manager.User_Detail;
import User_Manager.User_TblJDBCTemplate;
import com.google.gson.Gson;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.connectivity;

/**
 *
 * @author abc
 */
public class Poll_Tbl {
    Gson gson=new Gson();
    private int pid;
    private int uid;
    private String cid_json;
    private String title;
    private String description;
    //private String qtn_json;
    private String ans_json;
    private String poll_link;
    private String start_ts;
    private String end_ts;
    private int reward;
    private String poll_type;
    private List<Qtn> qtn_json=new ArrayList<>();
    private List<Category> cat_list=new ArrayList<>();
    private User_Detail user;
    
    public List<Qtn> getQtn_json() {
        return qtn_json;
    }

    public void setQtn_json(String qtn_json) {
        this.qtn_json = gson.fromJson(qtn_json, List.class);
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) throws SQLException {
        this.uid = uid;
        setUser(uid);
    }

    public String getCid_json() {
        return cid_json;
    }

    public void setCid_json(String cid_json1, connectivity conn) throws SQLException {
//        
        //List<Category> cat_list1=new ArrayList();
        
        this.cid_json = cid_json1;
        String cat_arr[]=cid_json.split(",");
        
        Category category;
        for(int i=0; i<cat_arr.length; i++)
        {category = new Category();
        String rslt[]=conn.getCategoryName(Integer.parseInt(cat_arr[i]));
        
        category.setCid(Integer.parseInt(cat_arr[i]));
        category.setCategory_name(rslt[0]);
        category.setGroup(rslt[1]);
            cat_list.add(category);
        }
        String cat_list1=gson.toJson(cat_list);
       
        
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getAns_json() {
        return ans_json;
    }

    public void setAns_json(String ans_json) {
        this.ans_json = ans_json;
    }

    public String getPoll_link() {
        return poll_link;
    }

    public void setPoll_link(String poll_link) {
        this.poll_link = poll_link;
    }

    public String getStart_ts() {
        return start_ts;
    }

    public void setStart_ts(String start_ts) {
        this.start_ts = start_ts;
    }

    public String getEnd_ts() {
        return end_ts;
    }

    public void setEnd_ts(String end_ts) {
        this.end_ts = end_ts;
    }

    public int getReward() {
        return reward;
    }

    public void setReward(int reward) {
        this.reward = reward;
    }

    public String getPoll_type() {
        return poll_type;
    }

    public void setPoll_type(String poll_type) {
        this.poll_type = poll_type;
    }

    public List<Category> getCat_list() {
        return cat_list;
    }

    

    public User_Detail getUser() {
        return user;
    }

    public void setUser(int uid) throws SQLException {
        User_TblJDBCTemplate user_jdbc=new User_TblJDBCTemplate();
        this.user=user_jdbc.get_profile(uid);
        
    }
    
}
