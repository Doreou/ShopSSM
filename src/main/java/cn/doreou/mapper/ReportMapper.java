package cn.doreou.mapper;

import cn.doreou.model.Report;
import cn.doreou.model.ReportType;
import cn.doreou.model.SearchPojo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportMapper {
    List<ReportType> getAllReportType();
    void NewReport(Report report);
    List<Report> getAllReport(@Param("start") int start,@Param("pageSize") int pageSize,@Param("searchpojo")SearchPojo searchPojo);
    int getAllReportCount(@Param("searchpojo") SearchPojo searchPojo);
    void deleteReport(@Param("report_id") int report_id);
}
