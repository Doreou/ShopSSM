package cn.doreou.controller;

import cn.doreou.model.Comment;
import cn.doreou.model.User;
import cn.doreou.model.UserComment;
import cn.doreou.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @RequestMapping("newComment")
    @ResponseBody
    public String newComment(HttpSession session, @RequestParam("id") int id,@RequestParam("content") String content){
        List<User> user=(List<User>) session.getAttribute("user");
        if(user!=null) {
            Comment comment = new Comment();
            comment.setComment_goodsid(id);
            comment.setContent(content);
            comment.setFrom_uid(user.get(0).getUser_id());
            comment.setTime(new Date());
            commentService.insertNewComment(comment);
            List<UserComment> commentList = commentService.getAllCommentList(String.valueOf(id));
            session.setAttribute("AllComment",commentList);
            return "回复成功";
        }else{
            return "请先登录";
        }
    }
}
