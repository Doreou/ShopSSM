package cn.doreou.controller;

import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;
import cn.doreou.model.PojoToJson;
import cn.doreou.model.User;
import cn.doreou.service.OrderService;
import cn.doreou.service.UserService;
import com.google.gson.Gson;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Order")
public class OrderController {
    //订单控制器
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;

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
        Date now = new Date();
        Date jointime = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(sdf);
        try {
            jointime=sdf.parse(sdf.format(now));
        }catch (ParseException e){
            e.printStackTrace();
        }
        goods.setTime(jointime);
        goods.setType("出售");
        goods.setIsundercarriage(1);
        orderService.sale(goods);
        String errmsg="发布成功";
        session.setAttribute("errmsg",errmsg);
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
        Date now = new Date();
        Date jointime = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(sdf);
        try {
            jointime=sdf.parse(sdf.format(now));
        }catch (ParseException e){
            e.printStackTrace();
        }
        goods.setTime(jointime);
        goods.setType("购入");
        goods.setIsundercarriage(1);
        orderService.sale(goods);
        String errmsg="发布成功";
        session.setAttribute("errmsg",errmsg);
        return "buygoods";
    }

    @RequestMapping("getMyBuy")
    public String getMyBuy(HttpSession session, Model model,@RequestParam(value = "page",required = false,defaultValue = "1") String start){
            List<User> userList = (List<User>) session.getAttribute("user");
            List<Goods> mybuy = orderService.getMyBuy(userList.get(0).getUser_id(), "购入", (Integer.parseInt(start)-1)*5, 5);
            model.addAttribute("mybuycount", orderService.getMyBuyCount(userList.get(0).getUser_id(), "购入"));
            model.addAttribute("currpage", start);
            session.setAttribute("mybuy", mybuy);
            return "mybuy";

    }

    @RequestMapping("getMySale")
    public String getMySale(HttpSession session,Model model,@RequestParam(value = "page",required = false,defaultValue = "1") String start){
        List<User> userList=(List<User>) session.getAttribute("user");
        List<Goods> mysale=orderService.getMySale(userList.get(0).getUser_id(),"出售",(Integer.parseInt(start)-1)*5,5);
        model.addAttribute("mysalecount", orderService.getMySaleCount(userList.get(0).getUser_id(), "出售"));
        model.addAttribute("currpage", start);
        session.setAttribute("mysale",mysale);
        return "mysale";
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
        String errmsg="上传成功";
        session.setAttribute("errmsg",errmsg);
        return "salegoods";
    }

    @RequestMapping("querysalebysub")
    public String QuerySaleBySub(HttpSession session,Model model,@RequestParam("select") String subject,@RequestParam(value = "page",required = false,defaultValue = "1") int start){
        List<Goods> result=orderService.getSaleBySub(subject,(start-1)*8,8);
        model.addAttribute("salecount",orderService.getCountBySub(subject));
        model.addAttribute("currpage",start);
        session.setAttribute("AllSaleGoodsList",result);
        return "sale";
    }
    @RequestMapping("querybuybysub")
    public String QueryBuyBySub(HttpSession session,Model model,@RequestParam("select") String subject,@RequestParam(value = "page",required = false,defaultValue = "1") int start){
        List<Goods> result=orderService.getBuyBySub(subject,(start-1)*10,10);
        model.addAttribute("buycount",orderService.getCountBySub(subject));
        model.addAttribute("currpage",start);
        session.setAttribute("AllBuyGoodsList",result);
        return "buy";
    }
    @RequestMapping("getAllSale")
    public String getAllSale(HttpSession session){
        List<Goods> result=orderService.getAllSale();
        session.setAttribute("AllSaleGoodsList",result);
        return "sale";
    }
    @RequestMapping("getAllBuy")
    public String getAllBuy(HttpSession session){
        List<Goods> result=orderService.getAllBuy();
        session.setAttribute("AllBuyGoodsList",result);
        return "buy";
    }

    @RequestMapping("getgoodsinfo")
    public String getGoodsInfo(HttpSession session,@RequestParam("id") String id){
        List<GoodAndUser> ResultList=orderService.getInfoById(id);
        session.setAttribute("goodsinfo",ResultList);
        return "goodsinfo";
    }
    @RequestMapping("searchbuy")
    public String SearchBuy(HttpSession session,Model model,@RequestParam("keyword") String key,@RequestParam(value = "page",required = false,defaultValue = "1") int start){
        List<Goods> result=orderService.SearchBuy(key,(start-1)*10,10);
        model.addAttribute("buycount",orderService.getSearchBuyCount(key));
        model.addAttribute("currpage",start);
        session.setAttribute("AllBuyGoodsList",result);
        return "buy";
    }

    @RequestMapping("searchsale")
    public String SearchSale(HttpSession session,Model model,@RequestParam("keyword") String key,@RequestParam(value = "page",required = false,defaultValue = "1") int start){
        List<Goods> result=orderService.SearchSale(key,(start-1)*8,8);
        model.addAttribute("salecount",orderService.getSearchSaleCount(key));
        model.addAttribute("currpage",start);
        session.setAttribute("AllSaleGoodsList",result);
        return "sale";
    }
    @RequestMapping(value = "searchbuybypage")
    public String SearchByPage(HttpSession session,Model model,@RequestParam("page") int start){
        List<Goods> result=orderService.SearchAllBuyByPage((start-1)*10,10);
        model.addAttribute("currpage",start);
        model.addAttribute("buycount",orderService.getBuyCount());
        session.setAttribute("AllBuyGoodsList",result);
        return "buy";
    }
    @RequestMapping("searchsalebypage")
    public String SearchSaleByPage(HttpSession session,Model model,@RequestParam("page") int start){
        List<Goods> result=orderService.SearchAllSaleByPage((start-1)*8,8);
        model.addAttribute("currpage",start);
        model.addAttribute("salecount",orderService.getSaleCount());
        session.setAttribute("AllSaleGoodsList",result);
        return "sale";
    }

    //下架商品
    @RequestMapping("undercarriage")
    @ResponseBody
    public Object undercarriage(HttpSession session, Model model, @RequestParam(value = "page",required = false,defaultValue = "1") String start, @RequestParam("goods_id") int goods_id,@RequestParam("choice") int choice){
        //0代表下架 1上架
        orderService.isundercarriage(goods_id,choice);
        getMySale(session,model,start);
        return "true";
    }

    //删除商品
    @RequestMapping("deletegoods")
    @ResponseBody
    public Object deleteGoods(HttpSession session, Model model, @RequestParam(value = "page",required = false,defaultValue = "1") String start, @RequestParam("goods_id") int goods_id) {
        orderService.deleteGoods(goods_id);
        getMySale(session,model,start);
        return "true";
    }

}
