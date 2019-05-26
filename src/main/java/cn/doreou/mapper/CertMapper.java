package cn.doreou.mapper;

import cn.doreou.model.Cert;
import cn.doreou.model.SearchPojo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CertMapper {
    void insertNewCert(Cert cert);
    List<Cert> isExist(String user_id);
    List<Cert> getAllCert(@Param("start") int start, @Param("pageSize") int pageSize, @Param("searchpojo")SearchPojo searchPojo);
    int getCertCount(@Param("searchpojo") SearchPojo searchPojo);
    List<Cert> getOneCert(@Param("cert_id") int cert_id);
    void deleteCert(@Param("cert_id") int cert_id);
    void updateCertStatus(Cert cert);
}
