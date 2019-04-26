package cn.doreou.service;


import cn.doreou.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminService {
    boolean isLogin(Admin admin);
    Admin getByAdminID(String id);
    List<Book> getAllSubject(int start,int pageSize);
    int getSubjectCount();
    void deleteSubject(String subject);
    void updateSubject(Book book);
    void addNewSubject(Book book);
    List<Cert> getAllCert(int start,int pageSize);
    int getCertCount();
    List<Cert> getOneCert(int cert_id);
    void deleteCert(int cert_id);
    void updateCertStatus(int cert_id);
    List<Applyer> getAllApply(int start,int pageSize);
    int getAllApplyCount();
    List<User> getAllUser();
}
