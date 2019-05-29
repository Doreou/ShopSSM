package cn.doreou.model;

public class Click {
    private int click_id;
    private String user_id;
    private int goods_id;

    public int getClick_id() {
        return click_id;
    }

    public void setClick_id(int click_id) {
        this.click_id = click_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(int goods_id) {
        this.goods_id = goods_id;
    }
}
