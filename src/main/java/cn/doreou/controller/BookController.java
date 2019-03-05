package cn.doreou.controller;

import cn.doreou.model.Book;
import cn.doreou.service.BookService;
import cn.doreou.service.impl.BookServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("aaa")
public class BookController {
    @Autowired
    private BookService bookService;
    @RequestMapping("test")
    public void Gotest(HttpServletRequest request,HttpServletResponse response){
        HttpSession session=request.getSession();
        List<Book> bookList=bookService.getAllSubject();
//        存放所有的分类供页面跳转时加载
        session.setAttribute("AllSubject",bookList);
    }
}
