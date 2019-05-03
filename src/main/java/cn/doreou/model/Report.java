package cn.doreou.model;

import java.util.Date;

public class Report {
    private int report_id;
    private String report_userid;
    private String bereported_userid;
    private Date report_time;
    private String report_type;
    private String report_content;
    private String adm_id;
    private String reply_title;
    private String reply_content;
    private Date reply_time;
    private String report_pic;
    private int bereported_goodsid;

    public int getBereported_goodsid() {
        return bereported_goodsid;
    }

    public void setBereported_goodsid(int bereported_goodsid) {
        this.bereported_goodsid = bereported_goodsid;
    }

    public String getReport_pic() {
        return report_pic;
    }

    public void setReport_pic(String report_pic) {
        this.report_pic = report_pic;
    }


    public int getReport_id() {
        return report_id;
    }

    public void setReport_id(int report_id) {
        this.report_id = report_id;
    }

    public String getReport_userid() {
        return report_userid;
    }

    public void setReport_userid(String report_userid) {
        this.report_userid = report_userid;
    }

    public String getBereported_userid() {
        return bereported_userid;
    }

    public void setBereported_userid(String bereported_userid) {
        this.bereported_userid = bereported_userid;
    }

    public Date getReport_time() {
        return report_time;
    }

    public void setReport_time(Date report_time) {
        this.report_time = report_time;
    }

    public String getReport_type() {
        return report_type;
    }

    public void setReport_type(String report_type) {
        this.report_type = report_type;
    }

    public String getReport_content() {
        return report_content;
    }

    public void setReport_content(String report_content) {
        this.report_content = report_content;
    }

    public String getAdm_id() {
        return adm_id;
    }

    public void setAdm_id(String adm_id) {
        this.adm_id = adm_id;
    }

    public String getReply_title() {
        return reply_title;
    }

    public void setReply_title(String reply_title) {
        this.reply_title = reply_title;
    }

    public String getReply_content() {
        return reply_content;
    }

    public void setReply_content(String reply_content) {
        this.reply_content = reply_content;
    }

    public Date getReply_time() {
        return reply_time;
    }

    public void setReply_time(Date reply_time) {
        this.reply_time = reply_time;
    }
}
