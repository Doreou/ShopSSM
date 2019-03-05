package cn.doreou.model;

public class Book {
//      管理分类
    private int sub_id;
    private String subject;

    public int getSub_id() {
        return sub_id;
    }

    public void setSub_id(int sub_id) {
        this.sub_id = sub_id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }


    @Override
    public String toString() {
        return "id="+sub_id+"subject="+subject;
    }
}
