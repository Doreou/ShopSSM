package cn.doreou.model;

import java.util.Date;

public class Applyer {
    private int apply_id;
    private String name;
    private String user_id;
    private String major;
    private String job;
    private String info;
    private String conn_way;
    private String conn_type;
    private Date up_time;
    private String apply_adm;
    private String reply;
    private String reply_title;

    public String getReply_title() {
        return reply_title;
    }

    public void setReply_title(String reply_title) {
        this.reply_title = reply_title;
    }

    public String getApply_adm() {
        return apply_adm;
    }

    public void setApply_adm(String apply_adm) {
        this.apply_adm = apply_adm;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public Date getUp_time() {

        return up_time;
    }

    public void setUp_time(Date up_time) {
        this.up_time = up_time;
    }

    public Date getCheck_time() {
        return check_time;
    }

    public void setCheck_time(Date check_time) {
        this.check_time = check_time;
    }

    private Date check_time;

    public String getConn_type() {
        return conn_type;
    }

    public void setConn_type(String conn_type) {
        this.conn_type = conn_type;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    private  int status;
    private String location;

    public int getApply_id() {
        return apply_id;
    }

    public void setApply_id(int apply_id) {
        this.apply_id = apply_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getConn_way() {
        return conn_way;
    }

    public void setConn_way(String conn_way) {
        this.conn_way = conn_way;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
