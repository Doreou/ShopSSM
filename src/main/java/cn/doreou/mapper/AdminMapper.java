package cn.doreou.mapper;

import cn.doreou.model.Book;
import cn.doreou.model.Cert;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminMapper {
    List<Book> getAllSubject(@Param("start") int start,@Param("pageSize") int pageSize);
    int getSubjectCount();
    void deleteSubject(@Param("subject") String subject);
    void updateSubject(Book book);
    void addNewSubject(Book book);

    List<Cert> getAllCert(@Param("start") int start,@Param("pageSize") int pageSize);
    int getCertCount();
    List<Cert> getOneCert(@Param("cert_id") int cert_id);
    void deleteCert(@Param("cert_id") int cert_id);
    void updateCertStatus(@Param("cert_id") int cert_id);
}
