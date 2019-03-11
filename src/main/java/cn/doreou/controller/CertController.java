package cn.doreou.controller;

import cn.doreou.model.Cert;
import cn.doreou.model.User;
import cn.doreou.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Cert")
public class CertController {
    @Autowired
    private CertService certService;

    @RequestMapping("newcert")
    public String NewCert(HttpSession session, @RequestParam("name") String name,@RequestParam("cardnum") String id){
        List<User> userList=(List<User>) session.getAttribute("user");
        if(id.equals(userList.get(0).getUser_id())) {
            if (!certService.isExist(id)) {
                Cert cert = new Cert();
                String code = session.getAttribute("code").toString();
                cert.setUser_id(id);
                cert.setUsername(name);
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
                cert.setCert_pic(code);
                //0未认证 1 已认证
                cert.setStatus(0);
                certService.insertNewCert(cert);
                String errmsg = "提交成功，请等待管理员审核";
                session.setAttribute("errmsg", errmsg);
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
        session.setAttribute("code",code);
        session.setAttribute("name",name);
        session.setAttribute("id",id);
        String errmsg="上传成功";
        session.setAttribute("errmsg",errmsg);
        return "checkinfo_nextstep";
    }


}
