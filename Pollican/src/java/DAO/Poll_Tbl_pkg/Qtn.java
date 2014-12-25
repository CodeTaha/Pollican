/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DAO.Poll_Tbl_pkg;

/**
 *
 * @author Taha
 */
public class Qtn {
    int qtn_id;
    int position;
    String qtn_type;
    String qtn;
    String rows[];
    String columns[];

   

    public String[] getRows() {
        return rows;
    }

    public void setRows(String[] rows) {
        this.rows = rows;
    }

    public String[] getColumns() {
        return columns;
    }

    public void setColumns(String[] columns) {
        this.columns = columns;
    }

    public int getQtn_id() {
        return qtn_id;
    }

    public void setQtn_id(int qtn_id) {
        this.qtn_id = qtn_id;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public String getQtn_type() {
        return qtn_type;
    }

    public void setQtn_type(String qtn_type) {
        this.qtn_type = qtn_type;
    }

    public String getQtn() {
        return qtn;
    }

    public void setQtn(String qtn) {
        this.qtn = qtn;
    }


        
    
}
