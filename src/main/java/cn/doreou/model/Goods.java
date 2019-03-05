package cn.doreou.model;

public class Goods {
    private int goods_id;
    private String owner_id;
    private String goods_title;
    private String introduce;
    private float pri_cost;
    private float expt_price;
    private String status;
    private String subject;
    private String cover;
    private int number;
    private int clickcount;
    private int focuscount;
    private int collectcount;

    public int getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(int goods_id) {
        this.goods_id = goods_id;
    }

    public String getOwner_id() {
        return owner_id;
    }

    public void setOwner_id(String owner_id) {
        this.owner_id = owner_id;
    }

    public String getGoods_title() {
        return goods_title;
    }

    public void setGoods_title(String goods_title) {
        this.goods_title = goods_title;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public float getPri_cost() {
        return pri_cost;
    }

    public void setPri_cost(float pri_cost) {
        this.pri_cost = pri_cost;
    }

    public float getExpt_price() {
        return expt_price;
    }

    public void setExpt_price(float expt_price) {
        this.expt_price = expt_price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getClickcount() {
        return clickcount;
    }

    public void setClickcount(int clickcount) {
        this.clickcount = clickcount;
    }

    public int getFocuscount() {
        return focuscount;
    }

    public void setFocuscount(int focuscount) {
        this.focuscount = focuscount;
    }

    public int getCollectcount() {
        return collectcount;
    }

    public void setCollectcount(int collectcount) {
        this.collectcount = collectcount;
    }
}
