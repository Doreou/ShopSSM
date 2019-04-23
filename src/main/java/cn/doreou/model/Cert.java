package cn.doreou.model;

import java.util.Date;

public class Cert {
    private int cert_id;
    private String user_id;
    private Date up_time;
    private String user_name;
    private String cert_pic;
    private String adm_id;
    private Date adm_time;
    private int status;

    public int getCert_id() {
        return cert_id;
    }

    public void setCert_id(int cert_id) {
        this.cert_id = cert_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public Date getUp_time() {
        return up_time;
    }

    public void setUp_time(Date up_time) {
        this.up_time = up_time;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getCert_pic() {
        return cert_pic;
    }

    public void setCert_pic(String cert_pic) {
        this.cert_pic = cert_pic;
    }

    public String getAdm_id() {
        return adm_id;
    }

    public void setAdm_id(String adm_id) {
        this.adm_id = adm_id;
    }

    public Date getAdm_time() {
        return adm_time;
    }

    public void setAdm_time(Date adm_time) {
        this.adm_time = adm_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
