package cn.doreou.model;

import java.util.Date;

public class Reply{
    private int reply_id;
    //回复对应的comment_id
    private int replyto_id;
    private String content;
    private String my_uid;
    private String to_uid;
    private String reply_type;
    private Date time;

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getReply_id() {
        return reply_id;
    }

    public void setReply_id(int reply_id) {
        this.reply_id = reply_id;
    }

    public int getReplyto_id() {
        return replyto_id;
    }

    public void setReplyto_id(int replyto_id) {
        this.replyto_id = replyto_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMy_uid() {
        return my_uid;
    }

    public void setMy_uid(String my_uid) {
        this.my_uid = my_uid;
    }

    public String getTo_uid() {
        return to_uid;
    }

    public void setTo_uid(String to_uid) {
        this.to_uid = to_uid;
    }

    public String getReply_type() {
        return reply_type;
    }

    public void setReply_type(String reply_type) {
        this.reply_type = reply_type;
    }
}
