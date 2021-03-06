package cn.doreou.service.impl;

import cn.doreou.mapper.CertMapper;
import cn.doreou.model.Cert;
import cn.doreou.model.SearchPojo;
import cn.doreou.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CertServiceImpl implements CertService {
    @Autowired
    private CertMapper certMapper;

    public void insertNewCert(Cert cert){
        certMapper.insertNewCert(cert);
    }
    public boolean isExist(String user_id){
        List<Cert> result=certMapper.isExist(user_id);
        if(result.size()>0){
            return true;
        }
        return false;
    }
    public List<Cert> getAllCert(int start, int pageSize, SearchPojo searchPojo){
        return certMapper.getAllCert(start,pageSize,searchPojo);
    }
    public int getCertCount(SearchPojo searchPojo){
        return certMapper.getCertCount(searchPojo);
    }
    public List<Cert> getOneCert(int cert_id){
        return certMapper.getOneCert(cert_id);
    }
    public void deleteCert(int cert_id){
        certMapper.deleteCert(cert_id);
    }
    public void updateCertStatus(Cert cert){
        certMapper.updateCertStatus(cert);
    }
}
