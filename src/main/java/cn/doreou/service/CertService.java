package cn.doreou.service;

import cn.doreou.model.Cert;

import java.util.List;

public interface CertService {
    void insertNewCert(Cert cert);
    boolean isExist(String user_id);
    List<Cert> getAllCert(int start,int pageSize);
    int getCertCount();
    List<Cert> getOneCert(int cert_id);
    void deleteCert(int cert_id);
    void updateCertStatus(Cert cert);
}
