package cn.doreou.model;

import java.util.Date;

public class Comment {
    private int comment_id;
    private int comment_goodsid;
    private String from_uid;
    private String content;
    private Date time;

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getComment_goodsid() {
        return comment_goodsid;
    }

    public void setComment_goodsid(int comment_goodsid) {
        this.comment_goodsid = comment_goodsid;
    }

    public String getFrom_uid() {
        return from_uid;
    }

    public void setFrom_uid(String from_uid) {
        this.from_uid = from_uid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
