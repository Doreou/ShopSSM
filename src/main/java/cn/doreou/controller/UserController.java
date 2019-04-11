package cn.doreou.controller;

import cn.doreou.model.Applyer;
import cn.doreou.model.Book;
import cn.doreou.model.Goods;
import cn.doreou.model.User;
import cn.doreou.service.BookService;
import cn.doreou.service.OrderService;
import cn.doreou.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;


import javax.imageio.ImageIO;
import javax.jws.WebParam;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

//用户信息管理控制器
@Controller
@RequestMapping("User")
public class UserController {

    //    @RequestMapping("addUser")
//    public void insertUser(int id){
//        userService.insertUser(id);
//
//    }
    @Autowired
    private UserService userService;
    @Autowired
    private BookService bookService;
    @Autowired
    private OrderService orderService;

    //登陆/注册验证码
    @RequestMapping("getVerifyCode")
    public void generate(HttpServletResponse response, HttpSession session, Model model) {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        String verifyCodeValue = drawImg(output);
        // 将校验码保存到session中
        session.setAttribute("verifyCodeValue", verifyCodeValue);
        try {
            ServletOutputStream out = response.getOutputStream();
            output.writeTo(out);
        } catch (IOException e) {
            e.printStackTrace();

        }
    }

    /* 绘制验证码 */
    private String drawImg(ByteArrayOutputStream output) {
        String code = "";
        // 随机产生4个字符
        for (int i = 0; i < 4; i++) {
            code += randomChar();
        }
        int width = 70;
        int height = 25;
        BufferedImage bi = new BufferedImage(width, height,
                BufferedImage.TYPE_3BYTE_BGR);
        Font font = new Font("Times New Roman", Font.PLAIN, 20);
        // 调用Graphics2D绘画验证码
        Graphics2D g = bi.createGraphics();
        g.setFont(font);
        Color color = new Color(66, 2, 82);
        g.setColor(color);
        g.setBackground(new Color(226, 226, 240));
        g.clearRect(0, 0, width, height);
        FontRenderContext context = g.getFontRenderContext();
        Rectangle2D bounds = font.getStringBounds(code, context);
        double x = (width - bounds.getWidth()) / 2;
        double y = (height - bounds.getHeight()) / 2;
        double ascent = bounds.getY();
        double baseY = y - ascent;
        g.drawString(code, (int) x, (int) baseY);
        g.dispose();
        try {
            ImageIO.write(bi, "jpg", output);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return code;
    }

    /* 获取随机参数 */
    private char randomChar() {
        Random r = new Random();
        String s = "ABCDEFGHJKLMNPRSTUVWXYZ0123456789";
        return s.charAt(r.nextInt(s.length()));
    }

    @RequestMapping("register")
    public String insertUser(HttpSession session, @RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("email") String email, @RequestParam("stuid") String stuid, @RequestParam("passcode") String passcode) {
        String errmsg;
        if (!passcode.toUpperCase().equals(session.getAttribute("verifyCodeValue").toString().toUpperCase())) {
            errmsg = "验证码错误";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/register";
        } else if (userService.queryById(stuid)) {
            errmsg = "该用户已存在";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/register";
        } else {
            User user = new User();
            Date now = new Date();
            Date jointime = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            System.out.println(sdf);
            try {
                jointime=sdf.parse(sdf.format(now));
            }catch (ParseException e){
                e.printStackTrace();
            }
            System.out.println(jointime);
            user.setEmail(email);
            user.setPassword(password);
            user.setUser_id(stuid);
            user.setUsername(username);
            user.setJointime(jointime);
            //注册后完成身份验证
            user.setMember_status(0);
            userService.insertUser(user);
            errmsg = "注册成功！3秒后跳转到登陆页面...";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/register";
        }
    }

    @RequestMapping("login")
    public String toLogin(HttpSession session, @RequestParam("userid") String userid, @RequestParam("password") String password, @RequestParam("passcode") String passcode) {
        String errmsg;
        if (!passcode.toUpperCase().equals(session.getAttribute("verifyCodeValue").toString().toUpperCase())) {
            errmsg = "验证码错误";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/login";
        } else {
            User user = new User();
            user.setUser_id(userid);
            user.setPassword(password);
            boolean isExist = userService.queryById(userid);
            if (isExist) {
                boolean result = userService.isLogin(user);
                if (result) {
                    List<User> userList=userService.getById(userid);
                    List<Book> bookList = bookService.getAllSubject();
                    List<Goods> goodsList=orderService.getAllSale();
//                    session.setAttribute("AllGoodsList",goodsList);
                    session.setAttribute("user",userList);
//                    session.setAttribute("AllSubject", bookList);
                    return "redirect:/Page/sale";
                } else {
                    //返回错误信息
                    errmsg = "密码错误";
                    session.setAttribute("errmsg", errmsg);
                    return "redirect:/Page/login";
                }
            } else {
                //返回错误信息
                errmsg = "您尚未注册";
                session.setAttribute("errmsg", errmsg);
                return "redirect:/Page/login";
            }
        }
    }

    @RequestMapping("logout")
    public String quit(HttpSession session){
        // 销毁用户session
        session.removeAttribute("user");
        return "redirect:/Page/login";
    }

    @RequestMapping("editinfo")
    public String updateInfo(HttpSession session,@RequestParam("nickname") String username,@RequestParam("age") int age,@RequestParam("qq") String qq,@RequestParam("wechat") String wechat,@RequestParam("phone") String phone,@RequestParam("qianming") String label,@RequestParam("email") String email){
        List<User> userList=(List<User>) session.getAttribute("user");
        User user=new User();
        user.setUser_id(userList.get(0).getUser_id());
        user.setUsername(username);
        user.setEmail(email);
        user.setAge(age);
        user.setPhone(phone);
        user.setQq(qq);
        user.setWechat(wechat);
        user.setLabel(label);
        System.out.println(user.toString());
        userService.updateInfoById(user);
        //更新用户当前信息
        userList=userService.getById(userList.get(0).getUser_id());
        session.setAttribute("user",userList);
        String errmsg="修改成功";
        session.setAttribute("errmsg",errmsg);
        return "redirect:/Page/info";
    }

    @RequestMapping("upload")
    @ResponseBody
    public String upload(HttpSession session, @RequestParam("code") String code) {
        String PicCode=code.substring(22);
        System.out.println(PicCode);
        BASE64Decoder decoder = new BASE64Decoder();
        try
        {
            //Base64解码
            byte[] b = decoder.decodeBuffer(PicCode);
            for(int i=0;i<b.length;++i)
            {
                if(b[i]<0)
                {
                    //调整异常数据
                    b[i]+=256;
                }
            }
            //生成png图片
            String imgFilePath="D:\\img\\headpic\\"+System.currentTimeMillis()+".png";
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(b);
            out.flush();
            out.close();
            List<User> userList = (List<User>) session.getAttribute("user");
            User user = new User();
            user.setUser_id(userList.get(0).getUser_id());
            user.setIcon(imgFilePath.substring(2));
            userService.updateHeadPic(user);
            //更新用户信息
            userList=userService.getById(userList.get(0).getUser_id());
            session.setAttribute("user",userList);
            String errmsg="上传成功";
            session.setAttribute("errmsg",errmsg);
            return "true";
        }
        catch (Exception e)
        {
            System.out.println(e);
            return "500";
        }
    }

    @RequestMapping("applyjob")
    public String applyJob(HttpSession session,@RequestParam("name") String name,@RequestParam("contacttype") String conn_type,@RequestParam("school") String school,@RequestParam("major") String major,@RequestParam("description") String job,@RequestParam("info") String info,@RequestParam("contactnum") String conn_way){
        String errmsg="";
        List<User> userList = (List<User>) session.getAttribute("user");
        if(userService.checkApply(userList.get(0).getUser_id())) {
            Applyer applyer = new Applyer();
            applyer.setUser_id(userList.get(0).getUser_id());
            applyer.setName(name);
            applyer.setMajor(major);
            applyer.setJob(job);
            applyer.setInfo(info);
            applyer.setConn_type(conn_type);
            applyer.setConn_way(conn_way);
            applyer.setLocation(school);
            applyer.setStatus(0);
            userService.applyJob(applyer);
            errmsg= "提交成功，你将在个人信息页--我的消息或通过您留下的联系方式查看管理员的回复";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/apply";
        }else {
            errmsg="您已提交过申请，请等待管理员回复";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/apply";
        }
    }

    //收藏
    @RequestMapping("collect")
    @ResponseBody
    public String collectThis(HttpSession session,@Param("id") String id){
        if(session.getAttribute("user")!=null) {
            List<User> user = (List<User>) session.getAttribute("user");
            userService.collectThis(id, user.get(0).getUser_id(), new Date());
            return "收藏成功!";
        }else {
            return "请先登录";
        }
    }




}
