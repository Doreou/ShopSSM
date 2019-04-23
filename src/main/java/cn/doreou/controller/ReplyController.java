package cn.doreou.controller;

import cn.doreou.model.Reply;
import cn.doreou.model.User;
import cn.doreou.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("Reply")
public class ReplyController {
    @Autowired
    private ReplyService replyService;
    @RequestMapping("insertNewReply")
    @ResponseBody
    public String insertNewReply(HttpSession session,@RequestParam("replyto_id") int replyto_id,@RequestParam("to_uid") String to_uid, @RequestParam("replyContent") String replyContent){
        List<User> user=(List<User>) session.getAttribute("user");
        if(user!=null) {
            Reply reply = new Reply();
            reply.setContent(replyContent);
            reply.setMy_uid(user.get(0).getUser_id());
            reply.setReplyto_id(replyto_id);
            reply.setTo_uid(to_uid);
            reply.setReply_type("0");
            replyService.insertNewReply(reply);
            return "回复成功";
        }else{
            return "请先登录";
        }
    }
}
