package cn.doreou.controller;

import cn.doreou.model.PojoToJson;
import cn.doreou.service.BookService;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

@Controller
@RequestMapping("aaa")
public class BookController {
    @Autowired
    private BookService bookService;
    @RequestMapping("test")
    @ResponseBody
    public Object Gotest(){
        List bookList=bookService.getAllSubject();
        System.out.println(bookList);
        Gson gson=new Gson();
        JSONObject jsonObject=JSONObject.parseObject(gson.toJson(new PojoToJson(0,"",bookList.size(),bookList)));
        return jsonObject;
    }
}
