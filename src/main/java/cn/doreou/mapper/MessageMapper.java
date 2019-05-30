package cn.doreou.mapper;

import cn.doreou.model.Message;
import cn.doreou.model.SearchPojo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageMapper {
    void sendMessage(Message message);
    List<Message> getAllMessage(@Param("start") int start, @Param("pageSize") int pageSize, @Param("searchpojo") SearchPojo searchPojo);
    int getAllMessageCount(@Param("searchpojo") SearchPojo searchPojo);
    void deleteMessage(@Param("message_id") int message_id);
    List<Message> getMessageType();
    void updateMessageByID(Message message);
}
