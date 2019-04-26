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
    public List<Cert> getAllCert(int start, int pageSize){
       return adminMapper.getAllCert(start,pageSize);
    }
    public int getCertCount(){
        return adminMapper.getCertCount();
    }
    public List<Cert> getOneCert(int cert_id){
        return adminMapper.getOneCert(cert_id);
    }
    public void deleteCert(int cert_id){
        adminMapper.deleteCert(cert_id);
    }
    public void updateCertStatus(int cert_id){
        adminMapper.updateCertStatus(cert_id);
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
}
