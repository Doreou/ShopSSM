package cn.doreou.mapper;

import cn.doreou.model.Comment;
import cn.doreou.model.UserComment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper{
    void insertNewComment(Comment comment);
    //拿到所有评论 但不包含回复/回复的回复
    List<UserComment> getAllcomment(@Param("goods_id") String goods_id);
}
