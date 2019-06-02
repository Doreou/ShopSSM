package cn.doreou.service.impl;

import cn.doreou.mapper.AdminMapper;
import cn.doreou.mapper.OrderMapper;
import cn.doreou.model.*;
import cn.doreou.service.AdminService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private OrderMapper orderMapper;
    public boolean isLogin(Admin admin){
        if(adminMapper.isLogin(admin).size()>0){
            return true;
        }
        return false;
    }
    public Admin getByAdminID(String id){
        return adminMapper.getByAdminID(id);
    }
    public void RegisterAdmin(Admin admin){
        adminMapper.RegisterAdmin(admin);
    }
    public int getSubjectCount(){
        return adminMapper.getSubjectCount();
    }

    public List<Book> getAllSubject(int start,int pageSize,String subject) {
        return adminMapper.getAllSubject(start,pageSize,subject);
    }

    public void deleteSubject(String subject){
        adminMapper.deleteSubject(subject);
    }
    public void updateSubject(Book book){
        adminMapper.updateSubject(book);
    }
    public void addNewSubject(Book book){
        adminMapper.addNewSubject(book);
    }
    public List<Applyer> getAllApply(int start,int pageSize,SearchPojo searchPojo){
        return adminMapper.getAllApply(start, pageSize,searchPojo);
    }
    public int getAllApplyCount(SearchPojo searchPojo){
        return adminMapper.getAllApplyCount(searchPojo);
    }
    public List<User> getAllUser(){
        return adminMapper.getAllUser();
    }
    public List<Applyer> getOneApply(int apply_id){
        return adminMapper.getOneApply(apply_id);
    }
    public void ApplyPass(Applyer applyer){
        adminMapper.ApplyPass(applyer);
    }
    public void ApplyRefused(Applyer applyer){
        adminMapper.ApplyRefused(applyer);
    }

    public List<Admin> getAllAdmin(int start,int pageSize,SearchPojo searchPojo){
        return adminMapper.getAllAdmin(start, pageSize,searchPojo);
    }
    public int getAllAdminCount(SearchPojo searchPojo){
        return adminMapper.getAllAdminCount(searchPojo);
    }
    public List<AdminType> getAllAdminType(){
        return adminMapper.getAllAdminType();
    }
    public List<Carousel> getAllCarousel(int start,int pageSize,SearchPojo searchPojo){
        return adminMapper.getAllCarousel(start, pageSize,searchPojo);
    }
    public int getAllCarouselCount(SearchPojo searchPojo){
        return adminMapper.getAllCarouselCount(searchPojo);
    }
    public void addNewCarousel(Carousel carousel){
        adminMapper.addNewCarousel(carousel);
    }
    public void deleteCarousel(int carousel_id){
        adminMapper.deleteCarousel(carousel_id);
    }
    public void updateCarousel(Carousel carousel){
        adminMapper.updateCarousel(carousel);
    }
    public void updateAdminInfo(Admin admin){
        adminMapper.updateAdminInfo(admin);
    }
    public List<AdminType> getPermission(String type){
        return adminMapper.getPermission(type);
    }
    public int getUserCountOfMan(){
        return adminMapper.getUserCountOfMan();
    }
    public int getUserCountOfWoman(){
        return adminMapper.getUserCountOfWoman();
    }
    public int getUserCountOfNoRecord(){
        return adminMapper.getUserCountOfNoRecord();
    }
    public List<User> getAllUserInfo(int start,int pageSize,SearchPojo searchPojo){
        return adminMapper.getAllUserInfo(start, pageSize,searchPojo);
    }
    public int getAllUserInfoOfCount(SearchPojo searchPojo){
        return adminMapper.getAllUserInfoOfCount(searchPojo);
    }
    public List<AdminType> getAllAdminTypePage(int start,int pageSize){
        return adminMapper.getAllAdminTypePage(start,pageSize);
    }
    public int getAllCountOfAdminType(){
        return adminMapper.getAllCountOfAdminType();
    }
    public void updatePermission(AdminType adminType){
        adminMapper.updatePermission(adminType);
    }

    public List<Goods> getAllGoods(int start,int pageSize,SearchPojo searchPojo){
        return adminMapper.getAllGoods(start, pageSize,searchPojo);
    }
    public int getAllGoodsCount(SearchPojo searchPojo){
        return adminMapper.getAllGoodsCount(searchPojo);
    }
    public void underCarriage(String goods_id){
        adminMapper.underCarriage(goods_id);
    }
    public void deleteGoods(String goods_id){
        adminMapper.deleteGoods(goods_id);
    }
    public void updateGoodsInfo(Goods goods){
        adminMapper.updateGoodsInfo(goods);
    }
    public void updateUserStatus(User user){
            adminMapper.updateUserStatus(user);
    }
    public void cancelCert(String user_id){
        adminMapper.cancelCert(user_id);
    }
    public void deleteAdmin(String admin_id){
        adminMapper.deleteAdmin(admin_id);
    }
    public void deleteUser(String user_id){
        adminMapper.deleteUser(user_id);
    }

    public int getCertCount(){
        return adminMapper.getCertCount();
    }
    public int getUnCertCount(){
        return adminMapper.getUnCertCount();
    }
}
