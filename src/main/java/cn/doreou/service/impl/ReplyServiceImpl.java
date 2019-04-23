package cn.doreou.service.impl;

import cn.doreou.mapper.ReplyMapper;
import cn.doreou.model.Reply;
import cn.doreou.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    private ReplyMapper replyMapper;

    public void insertNewReply(Reply reply){
        replyMapper.insertNewReply(reply);
    }

    public List<Reply> getAllReply(String goods_id){
        return  replyMapper.getAllReply(goods_id);
    }
}
