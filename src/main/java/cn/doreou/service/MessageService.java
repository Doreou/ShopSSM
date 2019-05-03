package cn.doreou.service;

import cn.doreou.model.Message;

import java.util.List;

public interface MessageService {
    void sendMessage(Message message);
    List<Message> getAllMessage(int start,int pageSize);
    int getAllMessageCount();
    void deleteMessage(int message_id);
}
