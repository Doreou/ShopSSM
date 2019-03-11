package cn.doreou.service;

import cn.doreou.model.Cert;

import java.util.List;

public interface CertService {
    void insertNewCert(Cert cert);
    boolean isExist(String user_id);
}
