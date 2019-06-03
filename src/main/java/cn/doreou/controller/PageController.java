package cn.doreou.controller;


import cn.doreou.model.*;
import cn.doreou.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    @Autowired
    private AdminService adminService;
    @Autowired
    HttpSession session;
    @RequestMapping("index")
    public String Goindex(){
        return "index";
    }
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
        List<Carousel> CarouselList=orderService.getAllCarousel();
        session.setAttribute("Carousel",CarouselList);
        if(session.getAttribute("subject")!=null){
            session.removeAttribute("subject");
        }
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
        return "redirect:/Order/getMyNews";

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
            System.out.println(userList.get(0).getMember_status());
            if(userList.get(0).getMember_status()==0) {
                String errmsg = "您已提交过申请，请等待管理员审核";
                session.setAttribute("errmsg", errmsg);
            }else {
                String errmsg = "您已是认证用户！";
                session.setAttribute("errmsg", errmsg);
            }
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
    @RequestMapping("updatesale")
    public String updatesale(){
        return  "updatesale";
    }
    public boolean isLogin(){
        if(session.getAttribute("admin")==null){
            return false;
        }
        return true;
    }
    @RequestMapping("admin_Subject")
    public String Admin_Subject(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Subject";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_Carousel")
    public String Admin_Carousel(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Carousel";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_Job")
    public String Admin_Job(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Job";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_Cert")
    public String Admin_Cert(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Cert";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_MessageToUser")
    public String admin_MessageToUser(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_MessageToUser";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_MessageToAll")
    public String admin_MessageToAll(Model model){
        if(isLogin()) {
            model.addAttribute("admin", (Admin) session.getAttribute("admin"));
            return "admin_MessageToAll";
        }
        else
            return "admin_login";
    }
    @RequestMapping("adminlogin")
    public String admin_login(){
        session.removeAttribute("admin");
        return "admin_login";
    }

    @RequestMapping("admin_MessageCenter")
    public String admin_MessageCenter(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_MessageCenter";
        }
        else
            return "admin_login";
    }

    @RequestMapping("admin_AdmList")
    public String admin_AdmList(Model model){
        if(isLogin()) {
            model.addAttribute("admin", (Admin) session.getAttribute("admin"));
            return "admin_AdmList";
        }
        else
            return "admin_login";
    }

    @RequestMapping("admin_Register")
    public String admin_Register(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Register";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_Report")
    public String admin_Report(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Report";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_info")
    public String admin_info(Model model){
        if(isLogin()){
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_info";

        }else{
            return "admin_login";
        }
    }
    @RequestMapping("bookData")
    public String bookDataAnalysis(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "bookData";
        }
        else
            return "admin_login";
    }
    @RequestMapping("userData")
    public String userDataAnalysis(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "userData";
        }
        else
            return "admin_login";
    }
    @RequestMapping("hotData")
    public String hotDataAnalysis(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "hotData";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_userinfo")
    public String userInfo(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_userinfo";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_Permission")
    public String Permission(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_Permission";
        }
        else
            return "admin_login";
    }
    @RequestMapping("admin_goodsinfo")
    public String Goods(Model model){
        if(isLogin()) {
            model.addAttribute("admin",(Admin)session.getAttribute("admin"));
            return "admin_goodsinfo";
        }
        else
            return "admin_login";
    }

    @RequestMapping("getTotal")
    @ResponseBody
    public int getTotal(){
        return userService.getTotal();
    }

    @RequestMapping("getMySaleCount")
    @ResponseBody
    public int getMySaleCount(@RequestParam("user_id") String user_id){
        return orderService.getMySaleCount(user_id,"出售");
    }

    @RequestMapping("getMyBuyCount")
    @ResponseBody
    public int getMyBuyCount(@RequestParam("user_id") String user_id){
        return orderService.getMyBuyCount(user_id,"购入");
    }

    @RequestMapping("getMyFinishedOrderCount")
    @ResponseBody
    public int getMyFinishedOrderCount(@RequestParam("user_id") String user_id){
        return orderService.getMyFinishedOrderCount(user_id);
    }

}
