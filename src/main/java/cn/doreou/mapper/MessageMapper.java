package cn.doreou.mapper;

import cn.doreou.model.Message;
import org.springframework.stereotype.Repository;

@Repository
public interface MessageMapper {
    void sendMessage(Message message);
}
