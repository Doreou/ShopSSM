package cn.doreou.model;

import java.util.Date;

public class Order {
    private int order_id;
    private int goods_id;
    private String buyer_id;
    private Date order_time;
    private Date give_time;
    private float price;
    private String give_place;
    private String pay_type;
    private int pay_status;
    private int number;
    private String leavewords;
    private int owner_confirm;
    private int buyer_get;
    private int owner_get;
    private int order_status;
    private int message_id;

    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(int goods_id) {
        this.goods_id = goods_id;
    }

    public String getBuyer_id() {
        return buyer_id;
    }

    public void setBuyer_id(String buyer_id) {
        this.buyer_id = buyer_id;
    }

    public Date getOrder_time() {
        return order_time;
    }

    public void setOrder_time(Date order_time) {
        this.order_time = order_time;
    }

    public Date getGive_time() {
        return give_time;
    }

    public void setGive_time(Date give_time) {
        this.give_time = give_time;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getGive_place() {
        return give_place;
    }

    public void setGive_place(String give_place) {
        this.give_place = give_place;
    }

    public String getPay_type() {
        return pay_type;
    }

    public void setPay_type(String pay_type) {
        this.pay_type = pay_type;
    }

    public int getPay_status() {
        return pay_status;
    }

    public void setPay_status(int pay_status) {
        this.pay_status = pay_status;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getLeavewords() {
        return leavewords;
    }

    public void setLeavewords(String leavewords) {
        this.leavewords = leavewords;
    }

    public int getOwner_confirm() {
        return owner_confirm;
    }

    public void setOwner_confirm(int owner_confirm) {
        this.owner_confirm = owner_confirm;
    }

    public int getBuyer_get() {
        return buyer_get;
    }

    public void setBuyer_get(int buyer_get) {
        this.buyer_get = buyer_get;
    }

    public int getOwner_get() {
        return owner_get;
    }

    public void setOwner_get(int owner_get) {
        this.owner_get = owner_get;
    }

    public int getOrder_status() {
        return order_status;
    }

    public void setOrder_status(int order_status) {
        this.order_status = order_status;
    }
}
