/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author root
 */
public class model_polls extends connectivity {
    private PreparedStatement st;
private ResultSet rs;
Gson gson;
private final Connection con;
    public model_polls() throws SQLException
    {   
        gson=new Gson();
        connectivity conn= new connectivity();
        con=conn.getCon();
    }
    
    public boolean createPoll(String detailJSON, String qtnJSON, String ansJSON) throws SQLException
    {System.out.println("in model_polls -->createPoll()");
        String detail[]= gson.fromJson(detailJSON, String[].class);
        for (String detail1 : detail) {
        System.out.println(detail1);
    }
    
    String qtn[][]= gson.fromJson(qtnJSON, String[][].class);
    for (String[] qtn1 : qtn) {
        for(String qtn2 : qtn1){
        System.out.println(qtn2);}
    }
    String ans[][]= gson.fromJson(ansJSON, String[][].class);
    for (String[] an : ans) {
        for(String qtn2 : an){
        System.out.println(qtn2);}
        
    }
    
    st=con.prepareStatement("insert into poll_tbl(uid,cid_json,title,description,qtn_json,ans_json,poll_link,reward,poll_type) values(?,?,?,?,?,?,?,?,?)");
   
       st.setInt(1,Integer.parseInt(detail[0]));//uid
       st.setString(2,detail[3]);//cidJSON
       st.setString(3,detail[1]);//title
       st.setString(4,detail[2]);//decscription
       st.setString(5,qtnJSON);
       st.setString(6,ansJSON);
       st.setString(7,"pollLink");
       st.setInt(8,5);//reward
       st.setString(9,"free");
   
    System.out.println("query="+st);
    try
    {
        st.execute();
        System.out.println("hua");
        return true;
    }
    catch(SQLException e)
    {System.out.println("nahi hua"+e);
    return false;
    }
        
    }
public String viewPolls() throws SQLException
{
    try{System.out.println("in model_polls -->viewPolls()");
        st=con.prepareStatement("select pid, uid, cid_json, title, description,reward from poll_tbl");
    rs=st.executeQuery();
    ArrayList alist=new ArrayList();
    
    while(rs.next())
    {String temp[]=new String[6];
        temp[0]=String.valueOf(rs.getInt(1));// pid
        temp[1]=String.valueOf(rs.getInt(2));//uid
        temp[2]=rs.getString(3);//cidJSON
        temp[3]=rs.getString(4);//title
        temp[4]=rs.getString(5);//description
        temp[5]=String.valueOf(rs.getInt(6));//reward
        alist.add(temp);
    }
    String pollJSON=gson.toJson(alist);
    System.out.println("PollJSON="+pollJSON);
    return pollJSON;
    }
    catch(SQLException e)
    {
        System.out.println("Exception occured at connectivity-> viewPolls() "+e);
    return "";
    }
}

public String solvePoll(int pid) throws SQLException
{
    try{System.out.println("in model_polls --> solvePoll()");
        st=con.prepareStatement("select * from poll_tbl where pid=?");
        st.setInt(1,pid);
    rs=st.executeQuery();
    ArrayList alist=new ArrayList();
    
    while(rs.next())
    {for(int i=1 ; i<= 12; i++)
    {
         String temp=rs.getString(i);
         System.out.println(i+"Temp="+temp);
         alist.add(temp);
    }
        
    }
    String pollJSON=gson.toJson(alist);
    System.out.println("PollJSON="+pollJSON);
    return pollJSON;
    }
    catch(SQLException e)
    {
        System.out.println("Exception occured at connectivity-> solvePolls() "+e);
    return "";
    }
}
    

    public boolean submitPoll(String finalJSON) throws SQLException
    {System.out.println("in model_polls --> submitPoll()");
        String detail[]= gson.fromJson(finalJSON, String[].class);
        
   
    
    
    st=con.prepareStatement("insert into poll_ans_tbl(pid,uid,ans_json) values(?,?,?)");
   
       st.setInt(1,Integer.parseInt(detail[0]));//pid
       st.setInt(2,Integer.parseInt(detail[1]));//uid
       st.setString(3,detail[2]);
   
    System.out.println("query="+st);
    try
    {
        st.execute();
        System.out.println("hua");
        return true;
    }
    catch(SQLException e)
    {System.out.println("nahi hua"+e);
    return false;
    }
        
    }
    
    public String pollResult(int pid) throws SQLException
{
    try{System.out.println("in model_polls --> pollResult()");
        st=con.prepareStatement("select poll_ans_key,uid,ans_json, solve_ts from poll_ans_tbl where pid=?");
        st.setInt(1,pid);
        System.out.println("query="+st);
    rs=st.executeQuery();
    ArrayList alist=new ArrayList();
    
    while(rs.next())
    {
         String temp[]=new String[4];
         temp[0]=String.valueOf(rs.getInt(1));
         temp[1]=String.valueOf(rs.getInt(2));
         temp[2]=rs.getString(3);
         temp[3]=rs.getString(4);
         alist.add(temp);  
    }
    String resultJSON=gson.toJson(alist);
    System.out.println("resultJSON="+resultJSON);
    return resultJSON;
    }
    catch(SQLException e)
    {
        System.out.println("Exception occured at connectivity-> pollResult() "+e);
    return "";
    }
}
    
    public String pollDetails(int pid) throws SQLException
{
    try{System.out.println("in model_polls --> pollDetails()");
        st=con.prepareStatement("select * from poll_tbl where pid=?");
        st.setInt(1,pid);
        System.out.println("query="+st);
    rs=st.executeQuery();
    ArrayList alist=new ArrayList();
    
    while(rs.next())
    {for(int i=1; i<=12;i++)
    {
         alist.add(rs.getString(i)); 
    }
    }
    String resultJSON=gson.toJson(alist);
    System.out.println("resultJSON="+resultJSON);
    return resultJSON;
    }
    catch(SQLException e)
    {
        System.out.println("Exception occured at connectivity-> pollDetails() "+e);
    return "";
    }
}
}
