package cn.doreou.service.impl;

import cn.doreou.mapper.AdminMapper;
import cn.doreou.model.Book;
import cn.doreou.model.Cert;
import cn.doreou.service.AdminService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;
    public int getSubjectCount(){
        return adminMapper.getSubjectCount();
    }

    public List<Book> getAllSubject(int start,int pageSize) {
        return adminMapper.getAllSubject((start-1)*pageSize,pageSize);
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
}
