package cn.doreou.service;


import cn.doreou.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminService {
    boolean isLogin(Admin admin);
    Admin getByAdminID(String id);
    void RegisterAdmin(Admin admin);
    List<Book> getAllSubject(int start,int pageSize,String subject);
    int getSubjectCount();
    void deleteSubject(String subject);
    void updateSubject(Book book);
    void addNewSubject(Book book);
    List<Applyer> getAllApply(int start,int pageSize,SearchPojo searchPojo);
    int getAllApplyCount(SearchPojo searchPojo);
    List<User> getAllUser();
    List<Applyer> getOneApply(int apply_id);
    void ApplyPass(Applyer applyer);
    void ApplyRefused(Applyer applyer);
    List<Admin> getAllAdmin(int start,int pageSize);
    int getAllAdminCount();
    List<AdminType> getAllAdminType();
    List<Carousel> getAllCarousel(int start,int pageSize,SearchPojo searchPojo);
    int getAllCarouselCount();
    void addNewCarousel(Carousel carousel);
    void deleteCarousel(int carousel_id);
    void updateCarousel(Carousel carousel);
    void updateAdminInfo(Admin admin);
    List<AdminType> getPermission(String type);
    int getUserCountOfMan();
    int getUserCountOfWoman();
    int getUserCountOfNoRecord();
    List<User> getAllUserInfo(int start,int pageSize,SearchPojo searchPojo);
    int getAllUserInfoOfCount();
    List<AdminType> getAllAdminTypePage(int start,int pageSize);
    int getAllCountOfAdminType();
    void updatePermission(AdminType adminType);
    List<Goods> getAllGoods(int start,int pageSize,SearchPojo searchPojo);
    int getAllGoodsCount(SearchPojo searchPojo);
    void underCarriage(String goods_id);
    void deleteGoods(String goods_id);
    void updateGoodsInfo(Goods goods);

}
