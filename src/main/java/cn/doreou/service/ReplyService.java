package cn.doreou.service;

import cn.doreou.model.Reply;

import java.util.List;

public interface ReplyService {
    void insertNewReply(Reply reply);
    List<Reply> getAllReply(String goods_id);
}
