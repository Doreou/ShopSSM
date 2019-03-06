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
        Goods goods=new Goods();
        goods.setGoods_title(title);
        goods.setIntroduce(introduce);
        goods.setStatus(status);
        goods.setNumber(number);
        goods.setOwner_id(userList.get(0).getUser_id());
        goods.setPri_cost(pri_cost);
        goods.setExpt_price(expt_price);
        goods.setSubject(subject);
        goods.setType("出售");
        orderService.sale(goods);
        return "salegoods";
    }


}
