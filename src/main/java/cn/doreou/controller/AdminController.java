package cn.doreou.controller;

import cn.doreou.model.*;
import cn.doreou.service.AdminService;
import cn.doreou.service.UserService;
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
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    @Autowired
    private UserService userService;
    @Autowired
    HttpSession session;

    @RequestMapping("adminLogin")
    @ResponseBody
    public String login(@RequestParam("admin_id") String id,@RequestParam("admin_pwd") String pwd){
        Admin admin=new Admin();
        admin.setAdmin_id(id);
        admin.setAdmin_password(pwd);
        if(adminService.getByAdminID(id)!=null) {
            if (adminService.isLogin(admin)) {
                //存放管理员信息
                session.setAttribute("admin",adminService.getByAdminID(id));
                return "success";
            } else {
                return "用户名或密码错误";
            }
        }else{
            return "账号不存在";
        }
    }

    @RequestMapping("getAllSubject")
    @ResponseBody
    public Object getAllSubject(@RequestParam("curr") int start, @RequestParam("nums") int pageSize){
        List bookList=adminService.getAllSubject((start-1)*pageSize,pageSize);
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

    @RequestMapping("getAllApply")
    @ResponseBody
    public Object getAllApply(@RequestParam("curr") int start, @RequestParam("nums") int pageSize){
        List applyList=adminService.getAllApply((start-1)*pageSize, pageSize);
        int totalCount=adminService.getAllApplyCount();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,applyList)));
        System.out.println(jsonObject);
        return jsonObject;
    }
    @RequestMapping("getOneApply")
    @ResponseBody
    public Object getOneApply(@RequestParam("apply_id") int apply_id){
        List applyList=adminService.getOneApply(apply_id);
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",1,applyList)));
        return jsonObject;
    }
    @RequestMapping("ApplyPass")
    public String ApplyPass(@RequestParam("apply_id") int apply_id,@RequestParam("reciever") String user_id,@RequestParam(value = "message_title" ,required = false,defaultValue = "null") String title,@RequestParam(value = "message_content",required = false,defaultValue = "null") String content,@RequestParam(value = "message_tip",required = false,defaultValue = "null") String tip){
        Admin admin=(Admin) session.getAttribute("admin");
        User user=userService.getById(user_id).get(0);
        Date date=new Date();
        //如果是默认通知
        if(title.equals("null")&&content.equals("null")) {
            title = "兼职申请已通过！";
            content = "您好！" + user.getUsername() + "\n" + "恭喜你通过我社的初步审核,请在3日内到XXX进一步面试，期待你能成为我们中的一员！";
        }
        //打包message
        Message message=new Message();
        //如果是自定义通知且有备注
        if(!tip.equals("")){
            message.setTip(tip);
        }
        message.setMessage_title(title);
        message.setMessage_content(content);
        message.setIsRead(0);
        message.setMessage_type("系统通知");
        message.setSend_time(date);
        message.setReciever(user_id);
        message.setSender(admin.getAdmin_id());
        session.setAttribute("message",message);
        //修改申请表信息
        Applyer applyer=new Applyer();
        applyer.setApply_id(apply_id);
        applyer.setApply_adm(admin.getAdmin_id());
        applyer.setCheck_time(date);
        applyer.setReply_title(title);
        applyer.setReply(content);
        adminService.ApplyPass(applyer);
        return "redirect:/Message/AutoSend";
    }
    @RequestMapping("ApplyRefused")
    public String ApplyRefused(@RequestParam("apply_id") int apply_id,@RequestParam("reciever") String user_id,@RequestParam(value = "message_title" ,required = false,defaultValue = "null") String title,@RequestParam(value = "message_content",required = false,defaultValue = "null") String content,@RequestParam(value = "message_tip",required = false,defaultValue = "null") String tip){
        Admin admin=(Admin) session.getAttribute("admin");
        User user=userService.getById(user_id).get(0);
        Date date=new Date();
        if(title.equals("null")&&title.equals("null")) {
            title = "抱歉，您不符合我社要求，您的申请被拒绝。";
            content = "您好！" + user.getUsername() + "\n" + "很抱歉的通知您，您未通过我社网络筛选，希望您继续努力！";
        }
        //打包message
        Message message=new Message();
        message.setMessage_title(title);
        message.setMessage_content(content);
        message.setIsRead(0);
        message.setMessage_type("系统通知");
        message.setSend_time(date);
        message.setReciever(user_id);
        message.setSender(admin.getAdmin_id());
        session.setAttribute("message",message);
        //修改申请表信息
        Applyer applyer=new Applyer();
        applyer.setApply_id(apply_id);
        applyer.setApply_adm(admin.getAdmin_id());
        applyer.setCheck_time(date);
        applyer.setReply_title(title);
        applyer.setReply(content);
        adminService.ApplyRefused(applyer);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("getAllAdmin")
    @ResponseBody
    public Object getAllAdmin(@RequestParam("curr") int start, @RequestParam("nums") int pageSize){
        List adminList=adminService.getAllAdmin((start-1)*pageSize, pageSize);
        int totalCount=adminService.getAllAdminCount();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,adminList)));
        return jsonObject;
    }
    @RequestMapping("getAllAdminType")
    @ResponseBody
    public Object getAllAdminType(){
        List adminTypeList=adminService.getAllAdminType();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",adminTypeList.size(),adminTypeList)));
        return jsonObject;
    }
    @RequestMapping("RegisterAdmin")
    @ResponseBody
    public String RegisterAdmin(@RequestParam("admin_type") String admin_type,@RequestParam("admin_id") String admin_id,@RequestParam("admin_name") String name,@RequestParam("admin_sex") String sex,@RequestParam("admin_email") String email,@RequestParam("admin_phone") String phone,@RequestParam("admin_location") String location,@RequestParam("admin_wechat") String wechat,@RequestParam("admin_pwd") String pwd){
        Admin admin=new Admin();
        admin.setAdmin_wechat(wechat);
        admin.setAdmin_password(pwd);
        admin.setAdmin_id(admin_id);
        admin.setAdmin_email(email);
        admin.setAdmin_location(location);
        admin.setAdmin_name(name);
        admin.setAdmin_phone(phone);
        admin.setAdmin_sex(sex);
        admin.setAdmin_type(admin_type);
        adminService.RegisterAdmin(admin);
        return "注册成功";
    }
    @RequestMapping("getAllCarousel")
    @ResponseBody
    public Object getAllCarousel(@RequestParam("curr") int start,@RequestParam("nums") int pageSize){
        List CarouselList=adminService.getAllCarousel((start-1)*pageSize, pageSize);
        int totalCount=adminService.getAllAdminCount();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,CarouselList)));
        return jsonObject;
    }
    @RequestMapping("addNewCarousel")
    @ResponseBody
    public String addNewCarousel(@RequestParam("fileLocation") String fileLocation,@RequestParam("start") String start,
                                 @RequestParam("end") String end,@RequestParam("info") String info){
        Carousel carousel=new Carousel();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date start_date=sdf.parse(start);
            Date end_date=sdf.parse(end);
            carousel.setCarousel_end(end_date);
            carousel.setCarousel_start(start_date);
        }catch (ParseException e){
            e.printStackTrace();
        }
        carousel.setCarousel_pic(fileLocation);
        carousel.setCarousel_visible(1);
        carousel.setCarousel_info(info);
        adminService.addNewCarousel(carousel);
        return "添加完成";
    }
    @RequestMapping("uploadCarousel")
    @ResponseBody
    public Object uploadCarousel(@RequestParam("file") MultipartFile file,Model model){
        String imgFilePath="D:\\img\\carouselpic\\"+file.getOriginalFilename();
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
    @RequestMapping("deleteCarousel")
    @ResponseBody
    public String deleteSubject(@RequestParam("carousel_id") int id){
        adminService.deleteCarousel(id);
        return "删除完成";
    }
    @RequestMapping("updateCarousel")
    @ResponseBody
    public String updateCarousel(@RequestParam("carousel_id") int carousel_id,@RequestParam("carousel_info1") String info,@RequestParam("fileLocation1") String fileLocation,
                                 @RequestParam("start1") String start,@RequestParam("end1") String end){
        Carousel carousel=new Carousel();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date start_date=sdf.parse(start);
            Date end_date=sdf.parse(end);
            carousel.setCarousel_end(end_date);
            carousel.setCarousel_start(start_date);
        }catch (ParseException e){
            e.printStackTrace();
        }
        carousel.setCarousel_info(info);
        carousel.setCarousel_id(carousel_id);
        carousel.setCarousel_pic(fileLocation);
        carousel.setCarousel_visible(1);
        adminService.updateCarousel(carousel);
        return "修改成功";
    }

}
