package cn.doreou.controller;

import cn.doreou.model.Admin;
import cn.doreou.model.Message;
import cn.doreou.model.PojoToJson;
import cn.doreou.model.User;
import cn.doreou.service.AdminService;
import cn.doreou.service.MessageService;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Message")
public class MessageController {
    @Autowired
    private MessageService messageService;
    @Autowired
    private AdminService adminService;
    @Autowired
    HttpSession session;
    @RequestMapping(value = "sendMessageToOne")
    @ResponseBody
    public String sendMessageToOne(@RequestParam("messageTitle") String messageTitle, @RequestParam("messageContent") String messageContent, @RequestParam("reciever") String reviever,@RequestParam("sendTime") String sendTime){
        Admin admin=(Admin) session.getAttribute("admin");
        Message message=new Message();
        message.setMessage_title(messageTitle);
        message.setMessage_content(messageContent);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date time=sdf.parse(sendTime);
            message.setSend_time(time);
        } catch (ParseException e) {
            e.printStackTrace();
            return "500";
        }
        message.setReciever(reviever);
        message.setSender(admin.getAdmin_id());
        message.setMessage_type("系统提醒");
        message.setIsRead(0);
        messageService.sendMessage(message);
        return "发送成功";
    }
    @RequestMapping("AutoSend")
    @ResponseBody
    public String AutoSend(){
        Message message=(Message) session.getAttribute("message");
        if(message!=null){
            messageService.sendMessage(message);
            return "操作完成";
        }else{
            return "请求失败";
        }

    }

    @RequestMapping(value = "sendMessageToAll")
    @ResponseBody
    public String sendMessageToAll(@RequestParam("messageTitle") String messageTitle, @RequestParam("messageContent") String messageContent, @RequestParam("reciever") String reviever,@RequestParam("sendTime") String sendTime,@RequestParam("ischeck") String ischecked){
        List<User> userList = adminService.getAllUser();
        System.out.println(ischecked);
        //如果勾选仅发送已认证
        if(ischecked.equals("true")){
            for(int i=userList.size()-1;i>=0;i--){
                if(userList.get(i).getMember_status()==0){
                    userList.remove(i);
                }
            }
            System.out.println(userList.size());
        }
        //移除所有女性和未填写性别的人
        if(reviever.equals("男")){
            for(int i=userList.size()-1;i>=0;i--){
                if(userList.get(i).getSex().equals("女")){
                    userList.remove(i);
                }
            }
        }else if(reviever.equals("女")){
            //移除所有男性和未填写性别的人
            for(int i=userList.size()-1;i>=0;i--){
                if(userList.get(i).getSex().equals("男")){
                    userList.remove(i);
                }
            }
        }
        Admin admin=(Admin) session.getAttribute("admin");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        for(int i=0;i<userList.size();i++) {
            Message message = new Message();
            try {
                Date time = sdf.parse(sendTime);
                message.setSend_time(time);
            } catch (ParseException e) {
                System.out.println(e);
                return "500";
            }
            message.setMessage_title(messageTitle);
            message.setMessage_content(messageContent);
            message.setReciever(userList.get(i).getUser_id());
            message.setSender(admin.getAdmin_id());
            message.setMessage_type("全服提醒");
            message.setIsRead(0);
            messageService.sendMessage(message);
        }
        return "发送成功";
    }
    @RequestMapping("getAllMessage")
    @ResponseBody
    public Object getAllMessage(@RequestParam("curr") int start, @RequestParam("nums") int pageSize){
        List messageList=messageService.getAllMessage((start-1)*pageSize, pageSize);
        int totalCount=messageService.getAllMessageCount();
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",totalCount,messageList)));
        return jsonObject;
    }
    @RequestMapping("deleteMessage")
    @ResponseBody
    public String deleteMessage(@RequestParam("message_id") int message_id){
        messageService.deleteMessage(message_id);
        return "消息已撤回";
    }


}
