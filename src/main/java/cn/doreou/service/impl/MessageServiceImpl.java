package cn.doreou.service.impl;

import cn.doreou.mapper.MessageMapper;
import cn.doreou.model.Message;
import cn.doreou.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;

    public void sendMessage(Message message){
        messageMapper.sendMessage(message);
    }
    public  List<Message> getAllMessage(int start,int pageSize){
        return messageMapper.getAllMessage(start, pageSize);
    }
    public int getAllMessageCount(){
        return messageMapper.getAllMessageCount();
    }
    public void deleteMessage(int message_id){
        messageMapper.deleteMessage(message_id);
    }
}
