package cn.doreou.service;

import cn.doreou.model.Comment;
import cn.doreou.model.UserComment;

import java.util.List;

public interface CommentService {
    void insertNewComment(Comment comment);
    List<UserComment> getAllCommentList(String goods_id);
}
