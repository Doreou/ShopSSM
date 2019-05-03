package cn.doreou.service.impl;

import cn.doreou.mapper.ReportMapper;
import cn.doreou.model.Report;
import cn.doreou.model.ReportType;
import cn.doreou.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private ReportMapper reportMapper;
    public List<ReportType> getAllReportType(){
        return reportMapper.getAllReportType();
    }
    public void NewReport(Report report){
        reportMapper.NewReport(report);
    }
    public List<Report> getAllReport(int start,int pageSize){
        return reportMapper.getAllReport(start,pageSize);
    }
    public int getAllReportCount(){
        return reportMapper.getAllReportCount();
    }
}
