package cn.doreou.service;

import cn.doreou.model.Cert;
import cn.doreou.model.SearchPojo;

import java.util.List;

public interface CertService {
    void insertNewCert(Cert cert);
    boolean isExist(String user_id);
    List<Cert> getAllCert(int start, int pageSize, SearchPojo searchPojo);
    int getCertCount(SearchPojo searchPojo);
    List<Cert> getOneCert(int cert_id);
    void deleteCert(int cert_id);
    void updateCertStatus(Cert cert);
}
