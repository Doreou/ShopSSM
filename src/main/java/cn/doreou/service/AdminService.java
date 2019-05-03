package cn.doreou.service;


import cn.doreou.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminService {
    boolean isLogin(Admin admin);
    Admin getByAdminID(String id);
    void RegisterAdmin(Admin admin);
    List<Book> getAllSubject(int start,int pageSize);
    int getSubjectCount();
    void deleteSubject(String subject);
    void updateSubject(Book book);
    void addNewSubject(Book book);
    List<Applyer> getAllApply(int start,int pageSize);
    int getAllApplyCount();
    List<User> getAllUser();
    List<Applyer> getOneApply(int apply_id);
    void ApplyPass(Applyer applyer);
    void ApplyRefused(Applyer applyer);
    List<Admin> getAllAdmin(int start,int pageSize);
    int getAllAdminCount();
    List<AdminType> getAllAdminType();
    List<Carousel> getAllCarousel(int start,int pageSize);
    int getAllCarouselCount();
    void addNewCarousel(Carousel carousel);
    void deleteCarousel(int carousel_id);
    void updateCarousel(Carousel carousel);
}
