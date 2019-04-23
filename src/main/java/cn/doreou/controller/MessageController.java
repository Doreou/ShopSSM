package cn.doreou.controller;

import cn.doreou.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("Message")
public class MessageController {
    @Autowired
    private MessageService messageService;
    @RequestMapping("sendMessage")
    @ResponseBody
    public String sendMessage(){
        return "发送成功";
    }
}
