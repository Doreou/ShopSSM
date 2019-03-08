package cn.doreou.controller;


import cn.doreou.model.Book;
import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;
import cn.doreou.model.User;
import cn.doreou.service.BookService;
import cn.doreou.service.OrderService;
import cn.doreou.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

//页面跳转控制器

@Controller
@RequestMapping("Page")
public class PageController {
    @Autowired
    private BookService bookService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;
//    购买二手
    @RequestMapping("buy")
    public String Gobuy(HttpSession session){
        List<Goods> result=orderService.getAllSale();
        session.setAttribute("AllSaleGoodsList",result);
        List<Goods> result1=orderService.getAllBuy();
        session.setAttribute("AllBuyGoodsList",result1);
        List<GoodAndUser> goodAndUsers=userService.getInfoByGoods();
        session.setAttribute("userinfo",goodAndUsers);
        List<Book> bookList=bookService.getAllSubject();
        session.setAttribute("AllSubject",bookList);
        return "buy";
    }
//    出售二手
    @RequestMapping("sale")
    public String Gosale(HttpSession session){
        Gobuy(session);
        return "sale";
    }
//    加入我们
    @RequestMapping("joinus")
    public String JoinUs(){
        return "joinus";
    }
//    我要登陆
    @RequestMapping("login")
    public String Login(){
        return "login";
    }
//    我要注册
    @RequestMapping("register")
    public String Register(){
        return "register";
    }
//    关于我们
    @RequestMapping("contact")
    public String Contact(){
        return "contact";
    }
    //我的信息
    @RequestMapping("info")
    public String Myinfo(){
        return "info";
    }
    @RequestMapping("mysale")
    public String Mysale(){
        return "mysale";
    }
    @RequestMapping("mybuy")
    public String Mybuy(){
        return "mybuy";
    }
    @RequestMapping("mynews")
    public String Mynews(){
        return "mynews";

    }
    @RequestMapping("checkinfo")
    public String CheckInfo(){
        return "checkinfo";

    }
    @RequestMapping("mycollect")
    public String Mycollect() {
        return "mycollect";
    }
    @RequestMapping("salegoods")
    public String Salegoods(HttpSession session){
        session.setAttribute("title","");
        session.setAttribute("status","");
        session.setAttribute("detail","");
        session.setAttribute("count","");
        session.setAttribute("price","");
        session.setAttribute("pricost","");
        session.setAttribute("address","");
        session.setAttribute("type","");
        return "salegoods";
    }

    @RequestMapping("buygoods")
    public String Buygoods(){
        return "buygoods";
    }

    @RequestMapping("checkinfo_nextstep")
    public String Checkinfo_nextstep(){
        return "checkinfo_nextstep";
    }
}
