package cn.doreou.controller;

import cn.doreou.model.*;
import cn.doreou.service.OrderService;
import cn.doreou.service.ReportService;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Report")
public class ReportController {
    @Autowired
    private ReportService reportService;
    @Autowired
    private OrderService orderService;
    @Autowired
    HttpSession session;
    @RequestMapping("getAllReportType")
    @ResponseBody
    public Object getAllReportType(){
        List reportTypeList=reportService.getAllReportType();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",reportTypeList.size(),reportTypeList)));
        return jsonObject;
    }
    @RequestMapping("uploadIcon")
    @ResponseBody
    public Object uploadIcon(@RequestParam("file") MultipartFile reportfile, Model model){
        String imgFilePath="D:\\img\\reportpic\\"+reportfile.getOriginalFilename();
        List report_data=new ArrayList();
        try {
            reportfile.transferTo(new File(imgFilePath));
            report_data.add(imgFilePath.substring(2));
            model.addAttribute("fileLocation",imgFilePath.substring(2));
        } catch (IOException e) {
            e.printStackTrace();
            return "500";
        }
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"上传成功",report_data.size(),report_data)));
        return jsonObject;
    }
    @RequestMapping("SaleReport")
    @ResponseBody
    public String SaleReport(@RequestParam("fileLocation") String fileLocation,@RequestParam("report_type") String report_type,@RequestParam("report_content") String report_content,@RequestParam("goods_id") int goods_id){
        if(session.getAttribute("user")==null){
            return "您尚未登陆，请登陆后再试";
        }
        System.out.println(report_content);
        List<User> user=(List<User>) session.getAttribute("user");
        List<GoodAndUser> list=orderService.getInfoById(String.valueOf(goods_id));
        Report report=new Report();
        report.setBereported_goodsid(goods_id);
        report.setReport_userid(user.get(0).getUser_id());
        report.setReport_content(report_content);
        report.setReport_pic(fileLocation);
        report.setReport_type(report_type);
        report.setReport_time(new Date());
        report.setBereported_userid(list.get(0).getUser_id());
        reportService.NewReport(report);
        return "举报成功";
    }
    @RequestMapping("isLogin")
    @ResponseBody
    public String isLogin(){
        if(session.getAttribute("user")!=null){
            List<User> users=(List<User>) session.getAttribute("user");
            return users.get(0).getUser_id();
        }
        else{
            return "请先登录";
        }
    }
    @RequestMapping("getAllReport")
    @ResponseBody
    public Object getAllReport(@RequestParam("curr") int start, @RequestParam("nums") int pageSize, SearchPojo searchPojo){
        List ReportList=reportService.getAllReport((start-1)*pageSize, pageSize,searchPojo);
        int totalCount=reportService.getAllReportCount(searchPojo);
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,ReportList)));
        return jsonObject;
    }
    @RequestMapping("ignoreReport")
    @ResponseBody
    public String ignoreReport(@RequestParam("report_id") int report_id){
        reportService.deleteReport(report_id);
        return "操作成功";
    }

}
