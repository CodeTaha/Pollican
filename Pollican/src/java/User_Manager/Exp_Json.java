/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package User_Manager;

/**
 *
 * @author abc
 */
public class Exp_Json {
    private int cid;
    private int exp;

    public Exp_Json()
    {System.out.println("Exp_Json obj created");
        this.cid=0;
        this.exp=0;
    }
    public Exp_Json(int t)
    {System.out.println("Exp_Json obj created for cid="+t);
        this.cid=t;
        this.exp=1000;
    }
    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getExp() {
        return exp;
    }

    public void setExp(int exp) {
        this.exp = exp;
    }
    
    public Exp_Json getObj(int t)
    {
        System.out.println("cat id="+ t);
        Exp_Json obj1=new Exp_Json(t);
        
        return obj1;
    }

}
