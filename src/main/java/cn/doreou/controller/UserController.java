package cn.doreou.controller;

import cn.doreou.model.Book;
import cn.doreou.model.User;
import cn.doreou.service.BookService;
import cn.doreou.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
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

    //登陆/注册验证码
    @RequestMapping("getVerifyCode")
    public void generate(HttpServletResponse response, HttpSession session) {
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
                    session.setAttribute("user",userList);
                    session.setAttribute("AllSubject", bookList);
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
        return "redirect:/Page/info";
    }


}
