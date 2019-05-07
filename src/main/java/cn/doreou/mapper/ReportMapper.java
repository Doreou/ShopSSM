package cn.doreou.mapper;

import cn.doreou.model.Report;
import cn.doreou.model.ReportType;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportMapper {
    List<ReportType> getAllReportType();
    void NewReport(Report report);
    List<Report> getAllReport(@Param("start") int start,@Param("pageSize") int pageSize);
    int getAllReportCount();
}