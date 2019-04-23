package cn.doreou.service.impl;

import cn.doreou.mapper.MessageMapper;
import cn.doreou.model.Message;
import cn.doreou.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;

    public void sendMessage(Message message){
        messageMapper.sendMessage(message);
    }
}
