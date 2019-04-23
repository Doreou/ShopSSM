package cn.doreou.controller;

import cn.doreou.model.Book;
import cn.doreou.model.Cert;
import cn.doreou.model.PojoToJson;
import cn.doreou.service.AdminService;
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

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("Admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("getAllSubject")
    @ResponseBody
    public Object getAllSubject(@RequestParam("curr") int start, @RequestParam("nums") int pageSize){
        List bookList=adminService.getAllSubject(start,pageSize);
        int totalCount=adminService.getSubjectCount();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,bookList)));
        return jsonObject;
    }

    @RequestMapping("deleteSubject")
    @ResponseBody
    public String deleteSubject(@RequestParam("subject") String subject){
        adminService.deleteSubject(subject);
        return "删除完成";
    }
    @RequestMapping("updateSubject")
    @ResponseBody
    public String updateSubject(@RequestParam("subject_id") int subject_id,@RequestParam("subject") String subject,@RequestParam("fileLocation1") String fileLocation){
        Book book=new Book();
        book.setIcon(fileLocation);
        book.setSubject(subject);
        book.setSubject_id(subject_id);
        adminService.updateSubject(book);
        return "修改成功";
    }
    @RequestMapping("uploadIcon")
    @ResponseBody
    public Object addNewSubject(@RequestParam("file") MultipartFile file,Model model){
        String imgFilePath="D:\\img\\webpic\\"+file.getOriginalFilename();
        List data=new ArrayList();
        try {
            file.transferTo(new File(imgFilePath));
            data.add(imgFilePath.substring(2));
            model.addAttribute("fileLocation",imgFilePath.substring(2));
        } catch (IOException e) {
            e.printStackTrace();
            return "500";
        }
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"上传成功",data.size(),data)));
        return jsonObject;
    }
    @RequestMapping("addNewSubject")
    @ResponseBody
    public String addNewSubject(@RequestParam("newsubject") String subject,@RequestParam("fileLocation") String fileLocation){
        Book book=new Book();
        book.setSubject(subject);
        book.setIcon(fileLocation);
        adminService.addNewSubject(book);
        return "上传成功";
    }

}
