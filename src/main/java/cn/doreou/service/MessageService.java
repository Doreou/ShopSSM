package cn.doreou.service;

import cn.doreou.model.Message;
import cn.doreou.model.SearchPojo;

import java.util.List;

public interface MessageService {
    void sendMessage(Message message);
    List<Message> getAllMessage(int start, int pageSize, SearchPojo searchPojo);
    int getAllMessageCount(SearchPojo searchPojo);
    void deleteMessage(int message_id);
    List<Message> getMessageType();
}
