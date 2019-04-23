package cn.doreou.model;

import java.util.List;

public class PojoToJson {
    private int code;
    private String msg;
    private int count;
    private List data;

    public PojoToJson(int code, String msg, int count, List data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    @Override
    public String toString() {
        return "PojoToJson{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", count=" + count +
                ", data=" + data +
                '}';
    }
}
