package cn.doreou.controller;


import cn.doreou.model.Book;
import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;
import cn.doreou.model.User;
import cn.doreou.service.BookService;
import cn.doreou.service.CertService;
import cn.doreou.service.OrderService;
import cn.doreou.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    @Autowired
    private CertService certService;
//    购买二手
    @RequestMapping("buy")
    public String Gobuy(HttpSession session,Model model){
        List<Goods> result=orderService.SearchAllSaleByPage(0,8);
        session.setAttribute("AllSaleGoodsList",result);
        //获取数据量
        model.addAttribute("salecount",orderService.getSaleCount());
        //首次进入该页面默认加载10条数据
        List<Goods> result1=orderService.SearchAllBuyByPage(0,10);
        session.setAttribute("AllBuyGoodsList",result1);
        //重置初始页面
        model.addAttribute("currpage",1);
        //获取数据量
        model.addAttribute("buycount",orderService.getBuyCount());
        List<GoodAndUser> goodAndUsers=userService.getInfoByGoods();
        session.setAttribute("userinfo",goodAndUsers);
        List<Book> bookList=bookService.getAllSubject();
        session.setAttribute("AllSubject",bookList);
        return "buy";
    }
//    出售二手
    @RequestMapping("sale")
    public String Gosale(HttpSession session,Model model){
        Gobuy(session,model);
        return "sale";
    }
//    加入我们
    @RequestMapping("joinus")
    public String JoinUs(HttpSession session){
        List<Book> bookList=bookService.getAllSubject();
        session.setAttribute("AllSubject",bookList);
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
        if(session.getAttribute("user")!=null) {
            session.setAttribute("title", "");
            session.setAttribute("status", "");
            session.setAttribute("detail", "");
            session.setAttribute("count", "");
            session.setAttribute("price", "");
            session.setAttribute("pricost", "");
            session.setAttribute("address", "");
            session.setAttribute("type", "");
            session.setAttribute("code", null);
            return "salegoods";
        }else{
            String errmsg="您尚未登陆，请登陆后再进行操作";
            session.setAttribute("errmsg",errmsg);
            return "login";
        }
    }

    @RequestMapping("buygoods")
    public String Buygoods(HttpSession session){
        if(session.getAttribute("user")!=null) {
            return "buygoods";
        }else{
            String errmsg="您尚未登陆，请登陆后再进行操作";
            session.setAttribute("errmsg",errmsg);
            return "login";
        }
    }

    @RequestMapping("checkinfo_nextstep")
    public String Checkinfo_nextstep(HttpSession session){
        List<User> userList=(List<User>) session.getAttribute("user");
        if(certService.isExist(userList.get(0).getUser_id())){
            String errmsg="您已提交过申请，请等待管理员审核";
            session.setAttribute("errmsg",errmsg);
            return "redirect:/Page/checkinfo";
        }else {
            session.setAttribute("name", "");
            session.setAttribute("id", "");
            session.setAttribute("CertPic",null);
            return "checkinfo_nextstep";
        }
    }
    @RequestMapping("goodsinfo")
    public String GoodsInfo(){
        return "goodsinfo";
    }
    @RequestMapping("apply")
    public String Apply(HttpSession session){
        if(session.getAttribute("user")!=null){
            return "apply";
        }else{
            String errmsg="您尚未登陆，请登陆后再进行操作";
            session.setAttribute("errmsg",errmsg);
            return "login";
        }
    }

}
