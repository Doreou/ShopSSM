package cn.doreou.service;

import cn.doreou.model.Report;
import cn.doreou.model.ReportType;

import java.util.List;

public interface ReportService {
    List<ReportType> getAllReportType();
    void NewReport(Report report);
    List<Report> getAllReport(int start,int pageSize);
    int getAllReportCount();
}
