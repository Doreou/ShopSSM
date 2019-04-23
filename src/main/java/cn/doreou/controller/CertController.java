package cn.doreou.controller;

import cn.doreou.model.Cert;
import cn.doreou.model.PojoToJson;
import cn.doreou.model.User;
import cn.doreou.service.AdminService;
import cn.doreou.service.CertService;
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
    public Object gerAllCert(@RequestParam("curr") int start, @RequestParam("nums") int pageSize){
        List certList=adminService.getAllCert((start-1)*pageSize, pageSize);
        int totalCount=adminService.getCertCount();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,certList)));
        return jsonObject;
    }

    @RequestMapping("getOneCert")
    @ResponseBody
    public Object getOneCert(@RequestParam("certid") int cert_id){
        List certInfo=adminService.getOneCert(cert_id);
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",1,certInfo)));
        return jsonObject;
    }
    @RequestMapping("deleteCert")
    @ResponseBody
    public String deleteCert(@RequestParam("certid") int cert_id){
        adminService.deleteCert(cert_id);
        return "您已成功拒绝该用户的请求";
    }

    @RequestMapping("updateCertStatus")
    @ResponseBody
    public String updateCertStatus(@RequestParam("certid") int cert_id){
        adminService.updateCertStatus(cert_id);
        return "操作完成";
    }


}
