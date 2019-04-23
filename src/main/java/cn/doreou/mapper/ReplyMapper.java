package cn.doreou.mapper;

import cn.doreou.model.Reply;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReplyMapper {
    void insertNewReply(Reply reply);
    List<Reply> getAllReply(@Param("goods_id") String goods_id);
}
