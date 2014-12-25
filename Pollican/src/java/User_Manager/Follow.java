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
public class Follow {
    private int uid;
    private int[] followers;
    private int[] following;

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int[] getFollowers() {
        return followers;
    }

    public void setFollowers(int[] followers) {
        this.followers = followers;
    }

    public int[] getFollowing() {
        return following;
    }

    public void setFollowing(int[] following) {
        this.following = following;
    }
    
    
}
