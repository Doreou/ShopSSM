package cn.doreou.controller;

import cn.doreou.model.*;
import cn.doreou.service.AdminService;
import cn.doreou.service.BookService;
import cn.doreou.service.OrderService;
import cn.doreou.service.UserService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.faces.annotation.RequestMap;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
    @Autowired
    private BookService bookService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("adminLogin")
    @ResponseBody
    public String login(@RequestParam("admin_id") String id, @RequestParam("admin_pwd") String pwd, @RequestParam("code") String code) {
        Admin admin = new Admin();
        admin.setAdmin_id(id);
        admin.setAdmin_password(pwd);
        if (session.getAttribute("verifyCodeValue").toString().toUpperCase().equals(code.toUpperCase())) {
            if (adminService.getByAdminID(id) != null) {
                if (adminService.isLogin(admin)) {
                    //存放管理员信息
                    session.setAttribute("admin", adminService.getByAdminID(id));
                    return "success";
                } else {
                    return "用户名或密码错误";
                }
            } else {
                return "账号不存在";
            }
        }
        return "验证码错误";
    }

    @RequestMapping("getAllSubject")
    @ResponseBody
    public Object getAllSubject(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,@RequestParam(value = "subject",required = false) String subject) {
        List bookList = adminService.getAllSubject((start - 1) * pageSize, pageSize,subject);
        int totalCount = adminService.getSubjectCount();
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", totalCount, bookList)));
        return jsonObject;
    }

    @RequestMapping("getSubject")
    @ResponseBody
    public Object getAllSubject() {
        List<Book> bookList = bookService.getAllSubject();
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", bookList.size(), bookList)));
        return jsonObject;
    }

    @RequestMapping("deleteSubject")
    @ResponseBody
    public String deleteSubject(@RequestParam("subject") String subject) {
        adminService.deleteSubject(subject);
        return "删除完成";
    }

    @RequestMapping("updateSubject")
    @ResponseBody
    public String updateSubject(@RequestParam("subject_id") int subject_id, @RequestParam("subject") String subject, @RequestParam("fileLocation1") String fileLocation) {
        Book book = new Book();
        book.setIcon(fileLocation);
        book.setSubject(subject);
        book.setSubject_id(subject_id);
        adminService.updateSubject(book);
        return "修改成功";
    }

    @RequestMapping("uploadIcon")
    @ResponseBody
    public Object addNewSubject(@RequestParam("file") MultipartFile file, Model model) {
        String imgFilePath = "D:\\img\\webpic\\" + file.getOriginalFilename();
        List data = new ArrayList();
        try {
            file.transferTo(new File(imgFilePath));
            data.add(imgFilePath.substring(2));
        } catch (IOException e) {
            e.printStackTrace();
            return "500";
        }
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", data.size(), data)));
        return jsonObject;
    }

    @RequestMapping("addNewSubject")
    @ResponseBody
    public String addNewSubject(@RequestParam("newsubject") String subject, @RequestParam("fileLocation") String fileLocation) {
        Book book = new Book();
        book.setSubject(subject);
        book.setIcon(fileLocation);
        adminService.addNewSubject(book);
        return "上传成功";
    }

    @RequestMapping("getAllApply")
    @ResponseBody
    public Object getAllApply(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,SearchPojo searchPojo) {
        List applyList = adminService.getAllApply((start - 1) * pageSize, pageSize,searchPojo);
        int totalCount = adminService.getAllApplyCount(searchPojo);
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", totalCount, applyList)));
        System.out.println(jsonObject);
        return jsonObject;
    }

    @RequestMapping("getOneApply")
    @ResponseBody
    public Object getOneApply(@RequestParam("apply_id") int apply_id) {
        List applyList = adminService.getOneApply(apply_id);
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", 1, applyList)));
        return jsonObject;
    }

    @RequestMapping("ApplyPass")
    public String ApplyPass(@RequestParam("apply_id") int apply_id, @RequestParam("reciever") String user_id, @RequestParam(value = "message_title", required = false, defaultValue = "null") String title, @RequestParam(value = "message_content", required = false, defaultValue = "null") String content, @RequestParam(value = "message_tip", required = false, defaultValue = "null") String tip) {
        Admin admin = (Admin) session.getAttribute("admin");
        User user = userService.getById(user_id).get(0);
        Date date = new Date();
        //如果是默认通知
        if (title.equals("null") && content.equals("null")) {
            title = "兼职申请已通过！";
            content = "您好！" + user.getUsername() + "\n" + "恭喜你通过我社的初步审核,请在3日内到XXX进一步面试，期待你能成为我们中的一员！";
        }
        //打包message
        Message message = new Message();
        //如果是自定义通知且有备注
        if (!tip.equals("")) {
            message.setTip(tip);
        }
        message.setMessage_title(title);
        message.setMessage_content(content);
        message.setIsRead(0);
        message.setMessage_type("系统通知");
        message.setSend_time(date);
        message.setReciever(user_id);
        message.setSender(admin.getAdmin_id());
        session.setAttribute("message", message);
        //修改申请表信息
        Applyer applyer = new Applyer();
        applyer.setApply_id(apply_id);
        applyer.setApply_adm(admin.getAdmin_id());
        applyer.setCheck_time(date);
        applyer.setReply_title(title);
        applyer.setReply(content);
        adminService.ApplyPass(applyer);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("ApplyRefused")
    public String ApplyRefused(@RequestParam("apply_id") int apply_id, @RequestParam("reciever") String user_id, @RequestParam(value = "message_title", required = false, defaultValue = "null") String title, @RequestParam(value = "message_content", required = false, defaultValue = "null") String content, @RequestParam(value = "message_tip", required = false, defaultValue = "null") String tip) {
        Admin admin = (Admin) session.getAttribute("admin");
        User user = userService.getById(user_id).get(0);
        Date date = new Date();
        if (title.equals("null") && title.equals("null")) {
            title = "抱歉，您不符合我社要求，您的申请被拒绝。";
            content = "您好！" + user.getUsername() + "\n" + "很抱歉的通知您，您未通过我社网络筛选，希望您继续努力！";
        }
        //打包message
        Message message = new Message();
        message.setMessage_title(title);
        message.setMessage_content(content);
        message.setIsRead(0);
        message.setMessage_type("系统通知");
        message.setSend_time(date);
        message.setReciever(user_id);
        message.setSender(admin.getAdmin_id());
        session.setAttribute("message", message);
        //修改申请表信息
        Applyer applyer = new Applyer();
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
    public Object getAllAdmin(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,SearchPojo searchPojo) {
        List adminList = adminService.getAllAdmin((start - 1) * pageSize, pageSize,searchPojo);
        int totalCount = adminService.getAllAdminCount(searchPojo);
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", totalCount, adminList)));
        return jsonObject;
    }

    @RequestMapping("getAllAdminType")
    @ResponseBody
    public Object getAllAdminType() {
        List adminTypeList = adminService.getAllAdminType();
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", adminTypeList.size(), adminTypeList)));
        return jsonObject;
    }

    @RequestMapping("RegisterAdmin")
    @ResponseBody
    public String RegisterAdmin(@RequestParam("admin_type") String admin_type, @RequestParam("admin_id") String admin_id, @RequestParam("admin_name") String name, @RequestParam("admin_pwd") String pwd) {
        Admin admin = new Admin();
        admin.setAdmin_password(pwd);
        admin.setAdmin_id(admin_id);
        admin.setAdmin_name(name);
        admin.setAdmin_type(admin_type);
        adminService.RegisterAdmin(admin);
        return "注册成功";
    }

    @RequestMapping("getAllCarousel")
    @ResponseBody
    public Object getAllCarousel(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,SearchPojo searchPojo) {
        List CarouselList = adminService.getAllCarousel((start - 1) * pageSize, pageSize,searchPojo);
        int totalCount = adminService.getAllCarouselCount(searchPojo);
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "", totalCount, CarouselList)));
        return jsonObject;
    }

    @RequestMapping("addNewCarousel")
    @ResponseBody
    public String addNewCarousel(@RequestParam("fileLocation") String fileLocation, @RequestParam("start") String start,
                                 @RequestParam("end") String end, @RequestParam("visible") String visible, @RequestParam("info") String info) {
        Carousel carousel = new Carousel();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date start_date = sdf.parse(start);
            Date end_date = sdf.parse(end);
            carousel.setCarousel_end(end_date);
            carousel.setCarousel_start(start_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        carousel.setCarousel_pic(fileLocation);
        if (visible.equals("可见")) {
            carousel.setCarousel_visible(1);
        } else {
            carousel.setCarousel_visible(0);
        }
        carousel.setCarousel_info(info);
        adminService.addNewCarousel(carousel);
        return "添加完成";
    }

    @RequestMapping("uploadCarousel")
    @ResponseBody
    public Object uploadCarousel(@RequestParam("file") MultipartFile file, Model model) {
        ;
        String imgFilePath = "D:\\img\\carouselpic\\" + file.getOriginalFilename();
        List data = new ArrayList();
        try {
            file.transferTo(new File(imgFilePath));
            data.add(imgFilePath.substring(2));
        } catch (IOException e) {
            e.printStackTrace();
            return "500";
        }
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", data.size(), data)));
        return jsonObject;
    }

    @RequestMapping("deleteCarousel")
    @ResponseBody
    public String deleteSubject(@RequestParam("carousel_id") int id) {
        adminService.deleteCarousel(id);
        return "删除完成";
    }

    @RequestMapping("updateCarousel")
    @ResponseBody
    public String updateCarousel(@RequestParam("carousel_id") int carousel_id, @RequestParam("carousel_info1") String info, @RequestParam("fileLocation1") String fileLocation,
                                 @RequestParam("start1") String start, @RequestParam("visible1") String visible, @RequestParam("end1") String end) {
        Carousel carousel = new Carousel();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date start_date = sdf.parse(start);
            Date end_date = sdf.parse(end);
            carousel.setCarousel_end(end_date);
            carousel.setCarousel_start(start_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        carousel.setCarousel_info(info);
        carousel.setCarousel_id(carousel_id);
        carousel.setCarousel_pic(fileLocation);
        if (visible.equals("可见")) {
            carousel.setCarousel_visible(1);
        } else {
            carousel.setCarousel_visible(0);
        }
        adminService.updateCarousel(carousel);
        return "修改成功";
    }

    @RequestMapping("uploadHeadPic")
    @ResponseBody
    public Object uploadHeadPic(@RequestParam("file") MultipartFile file, Model model) {
        String imgFilePath = "D:\\img\\adminheadpic\\" + file.getOriginalFilename();
        List data = new ArrayList();
        try {
            file.transferTo(new File(imgFilePath));
            data.add(imgFilePath.substring(2));
            model.addAttribute("fileLocation", imgFilePath.substring(2));
        } catch (IOException e) {
            e.printStackTrace();
            return "500";
        }
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", data.size(), data)));
        return jsonObject;
    }

    @RequestMapping("updateAdminInfo")
    @ResponseBody
    public String updateAdminInfo(@RequestParam("fileLocation") String fileLocation, @RequestParam("location") String location,
                                  @RequestParam("sex") String sex, @RequestParam("phone") String phone, @RequestParam("email") String email,
                                  @RequestParam("wechat") String wechat) {
        Admin currentAdmin = (Admin) session.getAttribute("admin");
        Admin admin = new Admin();
        admin.setAdmin_wechat(wechat);
        admin.setAdmin_sex(sex);
        admin.setAdmin_phone(phone);
        admin.setAdmin_location(location);
        admin.setAdmin_email(email);
        admin.setAdmin_icon(fileLocation);
        admin.setAdmin_id(currentAdmin.getAdmin_id());
        adminService.updateAdminInfo(admin);
        session.setAttribute("admin",adminService.getByAdminID(currentAdmin.getAdmin_id()));
        return "修改成功";
    }

    @RequestMapping("getAdmin")
    @ResponseBody
    public Object getById() {
        Admin admin = (Admin) session.getAttribute("admin");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("type", admin.getAdmin_type());
        jsonObject.put("username", admin.getAdmin_name());
        jsonObject.put("id", admin.getAdmin_id());
        jsonObject.put("email",admin.getAdmin_email());
        jsonObject.put("location",admin.getAdmin_location());
        jsonObject.put("phone",admin.getAdmin_phone());
        jsonObject.put("icon",admin.getAdmin_icon());
        jsonObject.put("wechat",admin.getAdmin_wechat());
        jsonObject.put("sex",admin.getAdmin_sex());
        return jsonObject;
    }

    @RequestMapping("getPermission")
    @ResponseBody
    public Object getPermission() {
        Admin admin = (Admin) session.getAttribute("admin");
        List permissionList = adminService.getPermission(admin.getAdmin_type());
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", permissionList.size(), permissionList)));
        return jsonObject;


    }

    @RequestMapping("getSubjectAnalysis")
    @ResponseBody
    public Object getSubjectAnalysis() {
        List subjectList = new ArrayList();
        List countList = new ArrayList();
        List<Book> AllSubject = bookService.getAllSubject();
        JSONObject jsonObject = new JSONObject();
        for (int i = 0; i < AllSubject.size(); i++) {
            subjectList.add(AllSubject.get(i).getSubject());
            countList.add(orderService.getCountBySub(AllSubject.get(i).getSubject()));
        }
        jsonObject.put("subject", subjectList);
        jsonObject.put("count", countList);
        return jsonObject;
    }

    @RequestMapping("getSexCount")
    @ResponseBody
    public Object getSexCount() {
        int man = adminService.getUserCountOfMan();
        int woman = adminService.getUserCountOfWoman();
        int norecord = adminService.getUserCountOfNoRecord();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("man", man);
        jsonObject.put("woman", woman);
        jsonObject.put("norecord", norecord);
        return jsonObject;
    }

    @RequestMapping("getAllUserInfo")
    @ResponseBody
    public Object getAllUserInfo(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,SearchPojo searchPojo) {
        List userInfo = adminService.getAllUserInfo((start - 1) * pageSize, pageSize,searchPojo);
        int totalCount = adminService.getAllUserInfoOfCount(searchPojo);
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", totalCount, userInfo)));
        return jsonObject;
    }

    //权限管理页
    @RequestMapping("getAllAdminTypePage")
    @ResponseBody
    public Object getAllAdminType(@RequestParam("curr") int start, @RequestParam("nums") int pageSize) {
        List adminTypeList = adminService.getAllAdminTypePage((start - 1) * pageSize, pageSize);
        int totalCount = adminService.getAllCountOfAdminType();
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", totalCount, adminTypeList)));
        return jsonObject;
    }

    @RequestMapping("updatePermission")
    @ResponseBody
    public String updatePermission(@RequestParam("userstatus") int user, @RequestParam("carouselstatus") int carousel,
                                   @RequestParam("subjectstatus") int subject, @RequestParam("sendmsgstatus") int sendmsg, @RequestParam("messagestatus") int message,
                                   @RequestParam("certstatus") int cert, @RequestParam("admstatus") int adm, @RequestParam("reportstatus") int report,
                                   @RequestParam("permissionstatus") int permission, @RequestParam("jobstatus") int job, @RequestParam("id") int id, @RequestParam("type") String type,
                                   @RequestParam("goodsstatus") int goods) {
        System.out.println(user);
        AdminType adminType = new AdminType();
        adminType.setUser_permission(user);
        adminType.setAdm_permission(adm);
        adminType.setCarousel_permission(carousel);
        adminType.setCert_permission(cert);
        adminType.setJob_permission(job);
        adminType.setMessage_permission(message);
        adminType.setPermission(permission);
        adminType.setReport_permission(report);
        adminType.setSendmsg_permission(sendmsg);
        adminType.setSubject_permission(subject);
        adminType.setGoods_permission(goods);
        adminType.setType(type);
        adminType.setType_id(id);
        adminService.updatePermission(adminType);
        return "修改成功";
    }

    @RequestMapping("getAllGoods")
    @ResponseBody
    public Object getAllGoods(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,SearchPojo searchPojo) {
        List goodsList = adminService.getAllGoods((start - 1) * pageSize, pageSize,searchPojo);
        int totalCount = adminService.getAllGoodsCount(searchPojo);
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", totalCount, goodsList)));
        return jsonObject;
    }

    @RequestMapping("underCarriage")
    public String underCarriage(@RequestParam("goods_id") int goods_id, @RequestParam("reason") String reason) {
        Admin admin = (Admin) session.getAttribute("admin");
        List<GoodAndUser> infoList = orderService.getInfoById(String.valueOf(goods_id));
        adminService.underCarriage(String.valueOf(goods_id));
        Message message = new Message();
        message.setSender(admin.getAdmin_id());
        message.setIsRead(0);
        message.setMessage_title("商品下架通知");
        message.setMessage_content(reason + "，商品名称为：" + infoList.get(0).getGoods_title());
        message.setMessage_type("下架通知");
        message.setSend_time(new Date());
        message.setReciever(infoList.get(0).getUser_id());
        session.setAttribute("message", message);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("deleteGoods")

    public String deleteGoods(@RequestParam("goods_id") int goods_id, @RequestParam("reason") String reason) {
        Admin admin = (Admin) session.getAttribute("admin");
        List<GoodAndUser> infoList = orderService.getInfoById(String.valueOf(goods_id));
        adminService.deleteGoods(String.valueOf(goods_id));
        Message message = new Message();
        message.setSender(admin.getAdmin_id());
        message.setIsRead(0);
        message.setMessage_title("商品删除通知");
        message.setMessage_content(reason + "，商品名称为：" + infoList.get(0).getGoods_title());
        message.setMessage_type("删除通知");
        message.setSend_time(new Date());
        message.setReciever(infoList.get(0).getUser_id());
        session.setAttribute("message", message);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("updateGoodsInfo")
    public String updateGoodsInfo(@RequestParam("goods_id") int goods_id, @RequestParam("goods_title") String title, @RequestParam("introduce") String introduce,
                                  @RequestParam("subject") String subject, @RequestParam("cover") String cover, @RequestParam("reason") String reason) {
        Admin admin = (Admin) session.getAttribute("admin");
        List<GoodAndUser> infoList = orderService.getInfoById(String.valueOf(goods_id));
        Goods goods = new Goods();
        goods.setGoods_title(title);
        goods.setGoods_id(goods_id);
        goods.setIntroduce(introduce);
        goods.setSubject(subject);
        goods.setCover(cover);
        adminService.updateGoodsInfo(goods);
        Message message = new Message();
        message.setSender(admin.getAdmin_id());
        message.setIsRead(0);
        message.setMessage_title("商品修改通知");
        message.setMessage_content(reason + "，商品名称为：" + infoList.get(0).getGoods_title() + "，已由后台更正！");
        message.setMessage_type("修改通知");
        message.setSend_time(new Date());
        message.setReciever(infoList.get(0).getUser_id());
        session.setAttribute("message", message);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("updateGoodsCover")
    @ResponseBody
    public Object updateGoodsCover(@RequestParam("file") MultipartFile file, Model model) {
        String imgFilePath = "D:\\img\\goodspic\\" + file.getOriginalFilename();
        List data = new ArrayList();
        try {
            file.transferTo(new File(imgFilePath));
            data.add(imgFilePath.substring(2));
        } catch (IOException e) {
            e.printStackTrace();
            return "500";
        }
        Gson gson = new Gson();
        JSONObject jsonObject = JSONObject.parseObject(gson.toJson(new PojoToJson(0, "上传成功", data.size(), data)));
        return jsonObject;
    }

    @RequestMapping("banUser")
    @ResponseBody
    public String banUser(@RequestParam("user_id") String user_id,@RequestParam("banDay") int banDay){
        Date ban_end=null;
        Date now=new Date();
        Date forever=null;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        try {
            forever=sdf.parse("2099-12-31");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Calendar calendar=Calendar.getInstance();
        calendar.setTime(now);
        if(banDay==1) {
            calendar.add(Calendar.DATE, 1);
            ban_end=calendar.getTime();
        }else if(banDay==7){
            calendar.add(Calendar.DATE,7);
            ban_end=calendar.getTime();
        }else if(banDay==365){
            calendar.add(Calendar.YEAR,1);
            ban_end=calendar.getTime();
        }else {
            ban_end=forever;
        }
        User user=new User();
        user.setBan_end(ban_end);
        user.setUser_id(user_id);
        adminService.updateUserStatus(user);
        return "操作成功";
    }
    @RequestMapping("cancelCert")
    public String cancelCert(@RequestParam("user_id") String user_id){
        Admin admin=(Admin) session.getAttribute("admin");
        Message message=new Message();
        message.setMessage_title("您的认证已被取消");
        message.setMessage_content("您的认证因为某些原因已经被取消，如有疑问，请致电我们。");
        message.setSender(admin.getAdmin_id());
        message.setMessage_type("系统提醒");
        message.setIsRead(0);
        message.setReciever(user_id);
        message.setSend_time(new Date());
        session.setAttribute("message",message);
        adminService.cancelCert(user_id);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("deleteAdmin")
    @ResponseBody
    public String deleteAdmin(@RequestParam("admin_id") String admin_id){
        adminService.deleteAdmin(admin_id);
        return "注销成功";
    }
    @RequestMapping("deleteUser")
    @ResponseBody
    public String deleteUser(@RequestParam("user_id") String user_id){
        adminService.deleteUser(user_id);
        return "注销成功";
    }


}
