package cn.doreou.model;

import java.util.Date;

public class Carousel {
    private int carousel_id;
    private String carousel_info;
    private String carousel_pic;
    private Date carousel_start;
    private Date carousel_end;
    private int carousel_visible;

    public int getCarousel_id() {
        return carousel_id;
    }

    public void setCarousel_id(int carousel_id) {
        this.carousel_id = carousel_id;
    }

    public String getCarousel_info() {
        return carousel_info;
    }

    public void setCarousel_info(String carousel_info) {
        this.carousel_info = carousel_info;
    }

    public String getCarousel_pic() {
        return carousel_pic;
    }

    public void setCarousel_pic(String carousel_pic) {
        this.carousel_pic = carousel_pic;
    }

    public Date getCarousel_start() {
        return carousel_start;
    }

    public void setCarousel_start(Date carousel_start) {
        this.carousel_start = carousel_start;
    }

    public Date getCarousel_end() {
        return carousel_end;
    }

    public void setCarousel_end(Date carousel_end) {
        this.carousel_end = carousel_end;
    }

    public int getCarousel_visible() {
        return carousel_visible;
    }

    public void setCarousel_visible(int carousel_visible) {
        this.carousel_visible = carousel_visible;
    }
}
