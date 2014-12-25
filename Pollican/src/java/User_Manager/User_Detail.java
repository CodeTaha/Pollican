/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package User_Manager;

import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Taha
 */
public class User_Detail {
    private int uid,fish;
    private String handle;
    private int category_list_json[];
    private String fb,email;
    private List <Exp_Json> exp_json= new ArrayList();
    
    private String name,country,state,zip,city,religion,sex,dob,phone,profile_pic ;
    private String lc ;
    private Follow follow=new Follow();
    
    
    
    Gson gson=new Gson();
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getHandle() {
        return handle;
    }

    public void setHandle(String handle) {
        this.handle = handle;
    }

    public int[] getCategory_list_json() {
        return category_list_json;
    }

    public void setCategory_list_json(String category_list_json) {
        
        this.category_list_json = gson.fromJson(category_list_json, int[].class);
    }

    public String getFb() {
        return fb;
    }

    public void setFb(String fb) {
        this.fb = fb;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<Exp_Json> getExp_json() {
        return exp_json;
    }

    public void setExp_json(String exp_json) {
        this.exp_json = gson.fromJson(exp_json, List.class);
    }

    public int getFish() {
        return fish;
    }

    public void setFish(int fish) {
        this.fish = fish;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getReligion() {
        return religion;
    }

    public void setReligion(String religion) {
        this.religion = religion;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProfile_pic() {
        return profile_pic;
    }

    public void setProfile_pic(String profile_pic) {
        this.profile_pic = profile_pic;
    }

    public String getLc() {
        return lc;
    }

    public void setLc(String lc) {
        this.lc = lc;
    }

    public Follow getFollow() {
        return follow;
    }

    public void setFollow(int fuid,String followers, String following) {
        
        try{
            follow.setUid(fuid);
            
        follow.setFollowers(gson.fromJson(followers, int[].class));
        follow.setFollowing(gson.fromJson(following, int[].class));
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
                
    }
 
    
    
    
}
