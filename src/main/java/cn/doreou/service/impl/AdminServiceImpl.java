package cn.doreou.service.impl;

import cn.doreou.mapper.AdminMapper;
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

    public List<Book> getAllSubject(int start,int pageSize) {
        return adminMapper.getAllSubject(start,pageSize);
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
    public List<Applyer> getAllApply(int start,int pageSize){
        return adminMapper.getAllApply(start, pageSize);
    }
    public int getAllApplyCount(){
        return adminMapper.getAllApplyCount();
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

    public List<Admin> getAllAdmin(int start,int pageSize){
        return adminMapper.getAllAdmin(start, pageSize);
    }
    public int getAllAdminCount(){
        return adminMapper.getAllAdminCount();
    }
    public List<AdminType> getAllAdminType(){
        return adminMapper.getAllAdminType();
    }
    public List<Carousel> getAllCarousel(int start,int pageSize){
        return adminMapper.getAllCarousel(start, pageSize);
    }
    public int getAllCarouselCount(){
        return adminMapper.getAllCarouselCount();
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
}
