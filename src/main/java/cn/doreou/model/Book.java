package cn.doreou.model;

public class Book {
//      管理分类
    private int subject_id;
    private String subject;
    private String icon;

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public int getSubject_id() {
        return subject_id;
    }

    public void setSubject_id(int subject_id) {
        this.subject_id = subject_id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }


    @Override
    public String toString() {
        return "Book{" +
                "subject_id=" + subject_id +
                ", subject='" + subject + '\'' +
                ", icon='" + icon + '\'' +
                '}';
    }
}
