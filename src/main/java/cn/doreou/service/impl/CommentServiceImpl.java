package cn.doreou.service.impl;

import cn.doreou.mapper.CommentMapper;
import cn.doreou.model.Comment;
import cn.doreou.model.UserComment;
import cn.doreou.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    public void insertNewComment(Comment comment){
        commentMapper.insertNewComment(comment);
    }
    public List<UserComment> getAllCommentList(String goods_id){
        return commentMapper.getAllcomment(goods_id);
    }
}
