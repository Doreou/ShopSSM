package cn.doreou.mapper;

import cn.doreou.model.Cert;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CertMapper {
    void insertNewCert(Cert cert);
    List<Cert> isExist(String user_id);
}
