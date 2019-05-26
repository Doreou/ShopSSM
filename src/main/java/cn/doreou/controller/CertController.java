package cn.doreou.controller;

import cn.doreou.model.*;
import cn.doreou.service.AdminService;
import cn.doreou.service.CertService;
import cn.doreou.service.MessageService;
import cn.doreou.service.UserService;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Cert")
public class CertController {
    @Autowired
    private CertService certService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private MessageService messageService;
    @Autowired
    HttpSession session;
    @Autowired
    private UserService userService;

    @RequestMapping("newcert")
    public String NewCert(HttpSession session, @RequestParam("name") String name,@RequestParam("cardnum") String id){
        List<User> userList=(List<User>) session.getAttribute("user");
        if(id.equals(userList.get(0).getUser_id())) {
            if (!certService.isExist(id)) {
                Cert cert = new Cert();
                String code = session.getAttribute("CertPic").toString();
                //截断无用前缀
                String PicCode=code.substring(22);
                System.out.println(PicCode);
                //对base64解码 转存为图片
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
                    String imgFilePath="D:\\img\\certpic\\"+System.currentTimeMillis()+".png";
                    OutputStream out = new FileOutputStream(imgFilePath);
                    cert.setUser_id(id);
                    cert.setUser_name(name);
                    Date now = new Date();
                    Date jointime = null;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    System.out.println(sdf);
                    try {
                        jointime = sdf.parse(sdf.format(now));
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                    cert.setUp_time(jointime);
                    cert.setCert_pic(imgFilePath.substring(2));
                    //0未认证 1 已认证
                    cert.setStatus(0);
                    certService.insertNewCert(cert);
                    String errmsg = "提交成功，请等待管理员审核";
                    session.setAttribute("errmsg", errmsg);
                    out.write(b);
                    out.flush();
                    out.close();
                }
                catch (Exception e)
                {
                    System.out.println(e);
                    return "500";
                }
            } else {
                String errmsg = "您已提交过申请，请等待管理员审核";
                session.setAttribute("errmsg", errmsg);
            }
        }else{
            String errmsg = "您输入的ID与登陆账户不符，请更改您登陆的账户ID或检查您的输入";
            session.setAttribute("errmsg", errmsg);
        }
        return "redirect:/Page/checkinfo_nextstep";
    }
    @RequestMapping("upload")
    public String getCode(HttpSession session,@RequestParam("code") String code, @RequestParam("name") String name,@RequestParam("cardnum") String id){
        session.setAttribute("CertPic",code);
        session.setAttribute("name",name);
        session.setAttribute("id",id);
        String errmsg="上传成功";
        session.setAttribute("errmsg",errmsg);
        return "checkinfo_nextstep";
    }

    @RequestMapping("getAllCert")
    @ResponseBody
    public Object getAllCert(@RequestParam("curr") int start, @RequestParam("nums") int pageSize,SearchPojo searchPojo){
        List certList=certService.getAllCert((start-1)*pageSize, pageSize,searchPojo);
        int totalCount=certService.getCertCount(searchPojo);
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,certList)));
        return jsonObject;
    }

    @RequestMapping("getOneCert")
    @ResponseBody
    public Object getOneCert(@RequestParam("certid") int cert_id){
        List certInfo=certService.getOneCert(cert_id);
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",1,certInfo)));
        return jsonObject;
    }
    @RequestMapping("deleteCert")
    public String deleteCert(@RequestParam("certid") int cert_id,
                             @RequestParam(value = "message_title",required = false,defaultValue = "null") String message_title,
                             @RequestParam(value = "message_content",required = false,defaultValue = "null") String message_content,
                             @RequestParam(value = "message_tip",required = false,defaultValue = "null") String message_tip,
                             @RequestParam("reciever") String reciever){
        Admin admin=(Admin) session.getAttribute("admin");
        User user=userService.getById(reciever).get(0);
        if(message_title.equals("null")&&message_content.equals("null")){
            message_title="抱歉！您的申请被驳回";
            message_content="您好！"+user.getUsername()+"，我们很遗憾的通知您，因为一些原因，我们无法认证您的身份。请检查您的身份信息并注意"+"\n"+"1.确保您的学号与学生证身份相对应。"+"\n"+"2.确保您上传的证件信息清晰规范。"+"\n"+"如需帮助，请通过网页下方联系方式联系我们，我们将竭诚为您服务!";
        }
        Message message=new Message();
        message.setTip(message_tip);
        message.setSend_time(new Date());
        message.setIsRead(0);
        message.setMessage_type("系统通知");
        message.setMessage_content(message_content);
        message.setMessage_title(message_title);
        message.setSender(admin.getAdmin_id());
        message.setReciever(reciever);
        session.setAttribute("message",message);
        certService.deleteCert(cert_id);
        return "redirect:/Message/AutoSend";
    }

    @RequestMapping("updateCertStatus")
    public String updateCertStatus(@RequestParam("certid") int cert_id,
                                   @RequestParam(value = "message_title",required = false,defaultValue = "null") String message_title,
                                   @RequestParam(value = "message_content",required = false,defaultValue = "null") String message_content,
                                   @RequestParam(value = "message_tip",required = false,defaultValue = "null") String message_tip,
                                   @RequestParam("reciever") String reciever){
        Date time=new Date();
        Admin admin=(Admin) session.getAttribute("admin");
        User user=userService.getById(reciever).get(0);
        if(message_title.equals("null")&&message_content.equals("null")){
            message_title="恭喜！您已通过认证";
            message_content="您好！"+user.getUsername()+"，您已通过身份认证！同时请您规范社区行为，违规事件可能会导致您的身份认证被收回。希望您为我们的交易社区的和谐氛围贡献力量！";
        }
        Message message=new Message();
        message.setTip(message_tip);
        message.setSend_time(time);
        message.setIsRead(0);
        message.setMessage_type("系统通知");
        message.setMessage_content(message_content);
        message.setMessage_title(message_title);
        message.setSender(admin.getAdmin_id());
        message.setReciever(reciever);
        session.setAttribute("message",message);
        Cert cert=new Cert();
        cert.setAdm_id(admin.getAdmin_id());
        cert.setAdm_time(time);
        cert.setCert_id(cert_id);
        //0为未认证 1为已认证
        certService.updateCertStatus(cert);
        return "redirect:/Message/AutoSend";
    }


}
