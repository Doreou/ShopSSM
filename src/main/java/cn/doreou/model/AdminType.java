package cn.doreou.model;

public class AdminType {
    private int type_id;
    private String type;
    private int user_permission;
    private int sendmsg_permission;
    private int carousel_permission;
    private int subject_permission;
    private int message_permission;
    private int cert_permission;
    private int job_permission;
    private int adm_permission;
    private int report_permission;
    private int permission;

    public int getPermission() {
        return permission;
    }

    public void setPermission(int permission) {
        this.permission = permission;
    }

    public int getReport_permission() {
        return report_permission;
    }

    public void setReport_permission(int report_permission) {
        this.report_permission = report_permission;
    }

    public int getUser_permission() {
        return user_permission;
    }

    public void setUser_permission(int user_permission) {
        this.user_permission = user_permission;
    }

    public int getSendmsg_permission() {
        return sendmsg_permission;
    }

    public void setSendmsg_permission(int sendmsg_permission) {
        this.sendmsg_permission = sendmsg_permission;
    }

    public int getCarousel_permission() {
        return carousel_permission;
    }

    public void setCarousel_permission(int carousel_permission) {
        this.carousel_permission = carousel_permission;
    }

    public int getSubject_permission() {
        return subject_permission;
    }

    public void setSubject_permission(int subject_permission) {
        this.subject_permission = subject_permission;
    }

    public int getMessage_permission() {
        return message_permission;
    }

    public void setMessage_permission(int message_permission) {
        this.message_permission = message_permission;
    }

    public int getCert_permission() {
        return cert_permission;
    }

    public void setCert_permission(int cert_permission) {
        this.cert_permission = cert_permission;
    }

    public int getJob_permission() {
        return job_permission;
    }

    public void setJob_permission(int job_permission) {
        this.job_permission = job_permission;
    }

    public int getAdm_permission() {
        return adm_permission;
    }

    public void setAdm_permission(int adm_permission) {
        this.adm_permission = adm_permission;
    }

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
