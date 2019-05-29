package cn.doreou.mapper;

import cn.doreou.model.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminMapper {
    List<Admin> isLogin(Admin admin);
    Admin getByAdminID(String id);
    void RegisterAdmin(Admin admin);
    List<Book> getAllSubject(@Param("start") int start,@Param("pageSize") int pageSize,@Param("subject") String subject);
    int getSubjectCount();
    void deleteSubject(@Param("subject") String subject);
    void updateSubject(Book book);
    void addNewSubject(Book book);

    List<Applyer> getAllApply(@Param("start") int start,@Param("pageSize") int pageSize,@Param("searchpojo") SearchPojo searchPojo);
    int getAllApplyCount(@Param("searchpojo") SearchPojo searchPojo);

    List<User> getAllUser();
    List<Applyer> getOneApply(@Param("apply_id") int apply_id);
    //-1拒绝 0待审核 1通过
    void ApplyPass(Applyer applyer);
    void ApplyRefused(Applyer applyer);

    List<Admin> getAllAdmin(@Param("start") int start,@Param("pageSize") int pageSize,@Param("searchpojo") SearchPojo searchPojo);
    int getAllAdminCount(@Param("searchpojo") SearchPojo searchPojo);

    List<AdminType> getAllAdminType();
    List<Carousel> getAllCarousel(@Param("start") int start,@Param("pageSize") int pageSize,@Param("searchpojo") SearchPojo searchPojo);
    int getAllCarouselCount(@Param("searchpojo") SearchPojo searchPojo);
    void addNewCarousel(Carousel carousel);

    void deleteCarousel(@Param("carousel_id") int carousel_id);
    void updateCarousel(Carousel carousel);

    void updateAdminInfo(Admin admin);
    List<AdminType> getPermission(@Param("type") String type);
    int getUserCountOfMan();
    int getUserCountOfWoman();
    int getUserCountOfNoRecord();

    List<User> getAllUserInfo(@Param("start") int start,@Param("pageSize") int pageSize,@Param("searchpojo") SearchPojo searchPojo);
    int getAllUserInfoOfCount(@Param("searchpojo") SearchPojo searchPojo);

    List<AdminType> getAllAdminTypePage(@Param("start") int start,@Param("pageSize") int pageSize);
    int getAllCountOfAdminType();
    void updatePermission(AdminType adminType);

    List<Goods> getAllGoods(@Param("start") int start,@Param("pageSize") int pageSize,@Param("searchpojo") SearchPojo searchPojo);
    int getAllGoodsCount(@Param("searchpojo") SearchPojo searchPojo);

//    商品管理
    void underCarriage(@Param("goods_id") String goods_id);
    void deleteGoods(@Param("goods_id") String goods_id);

    void updateGoodsInfo(Goods goods);
}
