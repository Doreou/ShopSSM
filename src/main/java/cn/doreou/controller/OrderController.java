package cn.doreou.controller;

import cn.doreou.model.Goods;
import cn.doreou.model.User;
import cn.doreou.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("Order")
public class OrderController {
    //订单控制器
    @Autowired
    private OrderService orderService;

    @RequestMapping("salegoods")
    public String SaleGoods(HttpSession session,@RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status,@RequestParam("count") int number,@RequestParam("pricost") float pri_cost, @RequestParam("price") float expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject){
        List<User> userList=(List<User>) session.getAttribute("user");
        String code=(String) session.getAttribute("code");
        Goods goods=new Goods();
        goods.setGoods_title(title);
        goods.setIntroduce(introduce);
        goods.setStatus(status);
        goods.setNumber(number);
        goods.setOwner_id(userList.get(0).getUser_id());
        goods.setPri_cost(pri_cost);
        goods.setCover(code);
        goods.setExpt_price(expt_price);
        goods.setSubject(subject);
        goods.setType("出售");
        orderService.sale(goods);
        return "redirect:/Page/salegoods";
    }

    @RequestMapping("buygoods")
    public String BuyGoods(HttpSession session,@RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status,@RequestParam("count") int number,@RequestParam("price") float expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject){
        List<User> userList=(List<User>) session.getAttribute("user");
        Goods goods=new Goods();
        goods.setGoods_title(title);
        goods.setIntroduce(introduce);
        goods.setStatus(status);
        goods.setNumber(number);
        goods.setOwner_id(userList.get(0).getUser_id());
        goods.setExpt_price(expt_price);
        goods.setSubject(subject);
        goods.setType("购入");
        orderService.sale(goods);
        return "buygoods";
    }

    @RequestMapping("getMyBuy")
    public String getMyBuy(HttpSession session){
        List<User> userList=(List<User>) session.getAttribute("user");
        List<Goods> mybuy=orderService.getMyBuy(userList.get(0).getUser_id(),"购入");
        session.setAttribute("mybuy",mybuy);
        return "redirect:/Page/mybuy";
    }

    @RequestMapping("getMySale")
    public String getMySale(HttpSession session){
        List<User> userList=(List<User>) session.getAttribute("user");
        List<Goods> mysale=orderService.getMySale(userList.get(0).getUser_id(),"出售");
        session.setAttribute("mysale",mysale);
        return "redirect:/Page/mysale";
    }

    @RequestMapping("upload")
    public String getCode(HttpSession session,@RequestParam("code") String code,@RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status,@RequestParam("count") String number,@RequestParam("pricost") String pri_cost,@RequestParam("price") String expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject){
        session.setAttribute("code",code);
        session.setAttribute("title",title);
        session.setAttribute("status",status);
        session.setAttribute("detail",introduce);
        session.setAttribute("count",number);
        session.setAttribute("pricost",pri_cost);
        session.setAttribute("price",expt_price);
        session.setAttribute("address",give_place);
        session.setAttribute("type",subject);
        return "salegoods";
    }
}
