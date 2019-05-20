package cn.doreou.controller;

import cn.doreou.model.*;
import cn.doreou.service.CommentService;
import cn.doreou.service.OrderService;
import cn.doreou.service.ReplyService;
import cn.doreou.service.UserService;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sun.misc.BASE64Decoder;

import javax.persistence.Id;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Order")
public class OrderController {
    //订单控制器
    @Autowired
    private OrderService orderService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private ReplyService replyService;
    @Autowired
    private UserService userService;

    @RequestMapping("salegoods")
    public String SaleGoods(HttpSession session, @RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status, @RequestParam("count") int number, @RequestParam("pricost") float pri_cost, @RequestParam("price") float expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject) {
        String code = (String) session.getAttribute("code");
        String PicCode = code.substring(22);
        System.out.println(PicCode);
        BASE64Decoder decoder = new BASE64Decoder();
        try {
            //Base64解码
            byte[] b = decoder.decodeBuffer(PicCode);
            for (int i = 0; i < b.length; ++i) {
                if (b[i] < 0) {
                    //调整异常数据
                    b[i] += 256;
                }
            }
            //生成png图片
            String imgFilePath = "D:\\img\\goodspic\\" + System.currentTimeMillis() + ".png";
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(b);
            out.flush();
            out.close();
            List<User> userList = (List<User>) session.getAttribute("user");
            Goods goods = new Goods();
            goods.setGoods_title(title);
            goods.setIntroduce(introduce);
            goods.setStatus(status);
            goods.setNumber(number);
            goods.setOwner_id(userList.get(0).getUser_id());
            goods.setPri_cost(pri_cost);
            goods.setCover(imgFilePath.substring(2));
            goods.setExpt_price(expt_price);
            goods.setSubject(subject);
            Date now = new Date();
            Date jointime = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            System.out.println(sdf);
            try {
                jointime = sdf.parse(sdf.format(now));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            goods.setTime(jointime);
            goods.setType("出售");
            goods.setIsundercarriage(1);
            orderService.sale(goods);
            String errmsg = "发布成功";
            session.setAttribute("errmsg", errmsg);
            return "redirect:/Page/salegoods";
        } catch (Exception e) {
            System.out.println(e);
            return "500";
        }

    }

    @RequestMapping("buygoods")
    public String BuyGoods(HttpSession session, @RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status, @RequestParam("count") int number, @RequestParam("price") float expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject) {
        List<User> userList = (List<User>) session.getAttribute("user");
        Goods goods = new Goods();
        goods.setGoods_title(title);
        goods.setIntroduce(introduce);
        goods.setStatus(status);
        goods.setNumber(number);
        goods.setOwner_id(userList.get(0).getUser_id());
        goods.setCover("\\img\\auto\\logo.png");
        goods.setExpt_price(expt_price);
        goods.setSubject(subject);
        Date now = new Date();
        Date jointime = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(sdf);
        try {
            jointime = sdf.parse(sdf.format(now));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        goods.setTime(jointime);
        goods.setType("购入");
        goods.setIsundercarriage(1);
        orderService.sale(goods);
        String errmsg = "发布成功";
        session.setAttribute("errmsg", errmsg);
        return "buygoods";
    }

    @RequestMapping("getMyBuy")
    public String getMyBuy(HttpSession session, Model model, @RequestParam(value = "page", required = false, defaultValue = "1") String start) {
        List<User> userList = (List<User>) session.getAttribute("user");
        List<Goods> mybuy = orderService.getMyBuy(userList.get(0).getUser_id(), "购入", (Integer.parseInt(start) - 1) * 5, 5);
        model.addAttribute("mybuycount", orderService.getMyBuyCount(userList.get(0).getUser_id(), "购入"));
        model.addAttribute("currpage", start);
        session.setAttribute("mybuy", mybuy);
        return "mybuy";

    }

    @RequestMapping("getMySale")
    public String getMySale(HttpSession session, Model model, @RequestParam(value = "page", required = false, defaultValue = "1") String start) {
        List<User> userList = (List<User>) session.getAttribute("user");
        List<Goods> mysale = orderService.getMySale(userList.get(0).getUser_id(), "出售", (Integer.parseInt(start) - 1) * 5, 5);
        model.addAttribute("mysalecount", orderService.getMySaleCount(userList.get(0).getUser_id(), "出售"));
        model.addAttribute("currpage", start);
        session.setAttribute("mysale", mysale);
        return "mysale";
    }

    @RequestMapping("upload")
    public String getCode(HttpSession session, @RequestParam("code") String code, @RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status, @RequestParam("count") String number, @RequestParam("pricost") String pri_cost, @RequestParam("price") String expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject) {
        session.setAttribute("code", code);
        session.setAttribute("title", title);
        session.setAttribute("status", status);
        session.setAttribute("detail", introduce);
        session.setAttribute("count", number);
        session.setAttribute("pricost", pri_cost);
        session.setAttribute("price", expt_price);
        session.setAttribute("address", give_place);
        session.setAttribute("type", subject);
        String errmsg = "上传成功";
        session.setAttribute("errmsg", errmsg);
        return "salegoods";
    }

    @RequestMapping("update_upload")
    @ResponseBody
    public String uoload(HttpSession session,@RequestParam("code") String code){
        session.setAttribute("newcode",code);
        return "true";
    }

    @RequestMapping("querysalebysub")
    public String QuerySaleBySub(HttpSession session, Model model, @RequestParam("select") String subject, @RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.getSaleBySub(subject, (start - 1) * 8, 8);
        model.addAttribute("salecount", orderService.getCountBySub(subject));
        model.addAttribute("currpage", start);
        session.setAttribute("subject",subject);
        session.setAttribute("AllSaleGoodsList", result);
        return "sale";
    }

    @RequestMapping("querybuybysub")
    public String QueryBuyBySub(HttpSession session, Model model, @RequestParam("select") String subject, @RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.getBuyBySub(subject, (start - 1) * 10, 10);
        model.addAttribute("buycount", orderService.getCountBySub(subject));
        model.addAttribute("currpage", start);
        session.setAttribute("subject",subject);
        session.setAttribute("AllBuyGoodsList", result);
        return "buy";
    }

    @RequestMapping("getAllSale")
    public String getAllSale(HttpSession session) {
        List<Goods> result = orderService.getAllSale();
        session.setAttribute("AllSaleGoodsList", result);
        return "sale";
    }

    @RequestMapping("getAllBuy")
    public String getAllBuy(HttpSession session) {
        List<Goods> result = orderService.getAllBuy();
        session.setAttribute("AllBuyGoodsList", result);
        return "buy";
    }

    @RequestMapping("getgoodsinfo")
    public String getGoodsInfo(HttpSession session, Model model,@RequestParam("id") String id) {
        List<User> IdNameList=new ArrayList<>();
        List<GoodAndUser> ResultList = orderService.getInfoById(id);
        List<UserComment> commentList = commentService.getAllCommentList(id);
        List<Reply> replyList=replyService.getAllReply(id);
        for(Reply r:replyList){
            List<User> userinfo=userService.getById(r.getMy_uid());
            userinfo.add(userService.getById(r.getTo_uid()).get(0));
            for(int i=0;i<userinfo.size();i++) {
                IdNameList.add(userinfo.get(i));
            }
        }
        session.setAttribute("IdNameList",IdNameList);
        session.setAttribute("AllReply",replyList);
        session.setAttribute("AllComment",commentList);
        session.setAttribute("goodsinfo", ResultList);
        List<User> user=(List<User>) session.getAttribute("user");
        if(user!=null){
            if(orderService.isCollected(user.get(0).getUser_id(),Integer.parseInt(id))){
                model.addAttribute("isCollected","已收藏");
            }else {
                model.addAttribute("isCollected","收藏");
            }
        }else {
            model.addAttribute("isCollected","收藏");
        }
        return "goodsinfo";
    }

    @RequestMapping("searchbuy")
    public String SearchBuy(HttpSession session, Model model, @RequestParam("keyword") String key, @RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.SearchBuy(key, (start - 1) * 10, 10);
        model.addAttribute("buycount", orderService.getSearchBuyCount(key));
        model.addAttribute("currpage", start);
        session.setAttribute("AllBuyGoodsList", result);
        return "buy";
    }

    @RequestMapping("searchsale")
    public String SearchSale(HttpSession session, Model model, @RequestParam("keyword") String key, @RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.SearchSale(key, (start - 1) * 8, 8);
        model.addAttribute("salecount", orderService.getSearchSaleCount(key));
        model.addAttribute("currpage", start);
        session.setAttribute("AllSaleGoodsList", result);
        return "sale";
    }

    @RequestMapping(value = "searchbuybypage")
    public String SearchByPage(HttpSession session, Model model, @RequestParam("page") int start) {
        List<Goods> result = orderService.SearchAllBuyByPage((start - 1) * 10, 10);
        model.addAttribute("currpage", start);
        model.addAttribute("buycount", orderService.getBuyCount());
        if(session.getAttribute("subject")!=null) {
            session.removeAttribute("subject");
        }
        session.setAttribute("AllBuyGoodsList", result);
        return "buy";
    }

    @RequestMapping("searchsalebypage")
    public String SearchSaleByPage(HttpSession session, Model model, @RequestParam("page") int start) {
        List<Goods> result = orderService.SearchAllSaleByPage((start - 1) * 8, 8);
        model.addAttribute("currpage", start);
        model.addAttribute("salecount", orderService.getSaleCount());
        session.setAttribute("AllSaleGoodsList", result);
        return "sale";
    }

    //下架商品
    @RequestMapping("undercarriage")
    @ResponseBody
    public Object undercarriage(HttpSession session, Model model, @RequestParam(value = "page", required = false, defaultValue = "1") String start, @RequestParam("goods_id") int goods_id, @RequestParam("choice") int choice) {
        //0代表下架 1上架
        orderService.isundercarriage(goods_id, choice);
        getMySale(session, model, start);
        return "true";
    }

    //删除商品
    @RequestMapping("deletegoods")
    @ResponseBody
    public Object deleteGoods(HttpSession session, Model model, @RequestParam(value = "page", required = false, defaultValue = "1") String start, @RequestParam("goods_id") int goods_id) {
        orderService.deleteGoods(goods_id);
        getMySale(session, model, start);
        return "true";
    }

    public String AllOrderBychoice(HttpSession session, Model model, String way, String type,int start,List<Goods> result){
        if(type.equals("出售")) {
            model.addAttribute("currpage", start);
            model.addAttribute("salecount", orderService.getSaleCount());
            session.setAttribute("AllSaleGoodsList", result);
            return "salePart";
        }else{
            model.addAttribute("currpage", start);
            model.addAttribute("buycount", orderService.getBuyCount());
            session.setAttribute("AllBuyGoodsList", result);
            return "buyPart";
        }
    }

    public int getPageSize(String type){
        if(type.equals("出售")) {
           return 8;
        }else{
            return 10;
        }
    }

    //按时间排序
    @RequestMapping("orderbytime")
    public String orderByTime(HttpSession session, Model model, @RequestParam("way") String way, @RequestParam("type") String type,@RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.orderByTime((start - 1) * getPageSize(type), getPageSize(type), way,type,(String) session.getAttribute("subject"));
        session.setAttribute("way", way);
        return AllOrderBychoice(session,model,way,type,start,result);
    }


    //按热度排序
    @RequestMapping("orderbyhot")
    public String orderByHot(HttpSession session, Model model, @RequestParam("way") String way, @RequestParam("type") String type,@RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.orderByHot((start - 1) * getPageSize(type), getPageSize(type), way,type,(String) session.getAttribute("subject"));
        session.setAttribute("way", way);
        return AllOrderBychoice(session,model,way,type,start,result);
    }

    @RequestMapping("orderbyprice")
    public String orderByPrice(HttpSession session, Model model, @RequestParam("way") String way, @RequestParam("type") String type,@RequestParam(value = "page", required = false, defaultValue = "1") int start) {
        List<Goods> result = orderService.orderByPrice((start - 1) * getPageSize(type), getPageSize(type), way,type,(String) session.getAttribute("subject"));
        session.setAttribute("way", way);
        return AllOrderBychoice(session,model,way,type,start,result);
    }

    //获取要更新的商品当前信息
    @RequestMapping("getnowgoodsinfo")
    public String getNowGoodsInfo(HttpSession session, @Param("goods_id") String goods_id) {
        List<GoodAndUser> nowinfo = orderService.getInfoById(goods_id);
        session.setAttribute("nowinfo", nowinfo);
        return "updatesale";
    }

    @RequestMapping("getnowbuygoodsinfo")
    public String getNowBuyGoodsInfo(HttpSession session, @Param("goods_id") String goods_id) {
        List<GoodAndUser> nowbuyinfo = orderService.getInfoById(goods_id);
        session.setAttribute("nowbuyinfo", nowbuyinfo);
        return "updatebuy";
    }

    //更新商品信息
    @RequestMapping("refresh")
    public String reFresh(HttpSession session, Model model, @RequestParam(value = "page", required = false, defaultValue = "1") String start, @RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status, @RequestParam("count") int number, @RequestParam("pricost") float pri_cost, @RequestParam("price") float expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject, @Param("goods_id") int goods_id) {
        String code = (String) session.getAttribute("newcode");
        Goods goods = new Goods();
        if (code != null) {
            String PicCode = code.substring(22);
            System.out.println(PicCode);
            BASE64Decoder decoder = new BASE64Decoder();
            try {
                //Base64解码
                byte[] b = decoder.decodeBuffer(PicCode);
                for (int i = 0; i < b.length; ++i) {
                    if (b[i] < 0) {
                        //调整异常数据
                        b[i] += 256;
                    }
                }
                //生成png图片
                String imgFilePath = "D:\\img\\goodspic\\" + System.currentTimeMillis() + ".png";
                OutputStream out = new FileOutputStream(imgFilePath);
                goods.setCover(imgFilePath.substring(2));
                out.write(b);
                out.flush();
                out.close();
            } catch (Exception e) {
                System.out.println(e);
                return "500";
            }
        }
        goods.setGoods_id(goods_id);
        goods.setGoods_title(title);
        goods.setIntroduce(introduce);
        goods.setStatus(status);
        goods.setNumber(number);
        goods.setPri_cost(pri_cost);
        goods.setExpt_price(expt_price);
        goods.setSubject(subject);
        orderService.refresh(goods);
        String errmsg = "更新成功";
        session.setAttribute("errmsg", errmsg);
        List<User> userList = (List<User>) session.getAttribute("user");
        List<Goods> mysale = orderService.getMySale(userList.get(0).getUser_id(), "出售", (Integer.parseInt(start) - 1) * 5, 5);
        model.addAttribute("mysalecount", orderService.getMySaleCount(userList.get(0).getUser_id(), "出售"));
        model.addAttribute("currpage", start);
        session.setAttribute("mysale", mysale);
        //移除本次修改图片缓存
        session.removeAttribute("newcode");
        return "mysale";
    }

    @RequestMapping("refreshbuy")
    public String RefreshBuy(HttpSession session,Model model, @RequestParam(value = "page", required = false, defaultValue = "1") String start, @RequestParam("title") String title, @RequestParam("detail") String introduce, @RequestParam("status") String status, @RequestParam("count") int number, @RequestParam("price") float pri_cost, @RequestParam("price") float expt_price, @RequestParam("address") String give_place, @RequestParam("type") String subject, @Param("goods_id") int goods_id){
        Goods goods=new Goods();
        goods.setGoods_id(goods_id);
        goods.setGoods_title(title);
        goods.setIntroduce(introduce);
        goods.setStatus(status);
        goods.setNumber(number);
        goods.setPri_cost(pri_cost);
        goods.setExpt_price(expt_price);
        goods.setSubject(subject);
        orderService.refreshbuy(goods);
        String errmsg = "更新成功";
        session.setAttribute("errmsg", errmsg);
        List<User> userList = (List<User>) session.getAttribute("user");
        List<Goods> mybuy = orderService.getMyBuy(userList.get(0).getUser_id(), "购入", (Integer.parseInt(start) - 1) * 5, 5);
        model.addAttribute("mybuycount", orderService.getMyBuyCount(userList.get(0).getUser_id(), "购入"));
        model.addAttribute("currpage", start);
        session.setAttribute("mybuy", mybuy);
        return "mybuy";
    }


    @RequestMapping("getMycollect")
    public String getMyCollect(HttpSession session){
        List<User> user = (List<User>) session.getAttribute("user");
        List<Goods> result=orderService.getMyCollect(user.get(0).getUser_id());
        session.setAttribute("mycollect",result);
        return "mycollect";
    }

    @RequestMapping("undocollect")
    public String undoCollect(HttpSession session,@Param("id") int id){
        List<User> user = (List<User>) session.getAttribute("user");
        orderService.undoCollect(user.get(0).getUser_id(),id);
        String errmsg = "取消收藏成功";
        session.setAttribute("errmsg", errmsg);
        return getMyCollect(session);
    }

    @RequestMapping("getMyNews")
    public String getMyNews(HttpSession session){
        List<User> user = (List<User>) session.getAttribute("user");
        List<Message> myNewsList=orderService.getMyNews(user.get(0).getUser_id());
        session.setAttribute("myNewsList",myNewsList);
        return "mynews";
    }
    @RequestMapping("AlreadyRead")
    @ResponseBody
    public String AdleadyRead(HttpSession session,@RequestParam("message_id") int message_id,@RequestParam("status") int status){
        orderService.AlreadyRead(message_id,status);
        getMyNews(session);
        if(status==1)
            return "已标记为已读";
        else
            return "以标记为未读";
    }

    @RequestMapping("Buy")
    public String Buy(@RequestParam("price") float price,@RequestParam("time") String time,
                    @RequestParam("number") int number,@RequestParam("content") String content,
                    @RequestParam("place") String place, @RequestParam("pay_way") String pay_way,
                    HttpSession session,@RequestParam("goods_id") int goods_id){
        if(session.getAttribute("user")==null){
            return "请先登录";
        }else {
            List<User> user = (List<User>) session.getAttribute("user");
            List<GoodAndUser> infoList= orderService.getInfoById(String.valueOf(goods_id));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            int message_id=orderService.getMaxMessageID()+1;
            Order order = new Order();
            order.setBuyer_get(0);
            order.setBuyer_id(user.get(0).getUser_id());
            order.setGive_place(place);
            try {
                order.setGive_time(sdf.parse(time));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            order.setGoods_id(goods_id);
            order.setLeavewords(content);
            order.setNumber(number);
            order.setMessage_id(message_id);
//        0进行中 1已达成
            order.setOrder_status(0);
            order.setOwner_confirm(0);
            order.setOrder_time(new Date());
            order.setPay_type(pay_way);
            //0未支付 1已支付
            order.setPay_status(0);
            order.setPrice(price);
            order.setOwner_get(0);
            orderService.InsertOrder(order);
            //向持有者发送消息
            Message message=new Message();
            message.setReciever(infoList.get(0).getUser_id());
            message.setSend_time(new Date());
            message.setIsRead(0);
            message.setMessage_type("购买通知");
            message.setMessage_title("有人收购你的书籍啦！");
            message.setMessage_content("您好！"+infoList.get(0).getUsername()+",您的书籍"+infoList.get(0).getGoods_title()+"被"+user.get(0).getUsername()+"购买啦！"+"快去查看交易信息吧！TA还给您留言："+content);
            message.setSender("root");
            session.setAttribute("message",message);
            return "redirect:/Message/AutoSend";
        }
    }

    @RequestMapping("agree")
    public String agree(HttpSession session,@RequestParam("message_id") int message_id){
//        List<User> user=(List<User>)session.getAttribute("user");
        Order order= orderService.getByMessageID(message_id);
        //图书数量减持
        orderService.updateGoodsNumById(order.getNumber(),order.getGoods_id());
        //持有人确认
        orderService.OwnerConfirm(order.getOrder_id());
        Message message=new Message();
        message.setSend_time(new Date());
        message.setIsRead(0);
        message.setReciever(order.getBuyer_id());
        message.setMessage_type("系统提醒");
        message.setMessage_content("您好！卖家已经同意了您的购买请求，请按照约定线下交易。请注意安全！");
        message.setSender("root");
        message.setMessage_title("卖家确认通知");
        session.setAttribute("message",message);

        //判断存量是否为0
//        List<GoodAndUser> infoList=orderService.getInfoById(String.valueOf(order.getGoods_id()));
//        if(infoList.get(0).getNumber()==0){
//            //是 应用下架
//            //发送通知
//            orderService.isundercarriage(order.getGoods_id(),0);
//            Message message=new Message();
//            message.setSender("root");
//            message.setMessage_title("应用下架通知");
//            message.setMessage_content("尊敬的"+user.getUsername()+"，我们注意到您的商品在出售后存货量变为0，系统已经对商品做下架处理，如您还有多余，请修改持有量后重新上架商品。感谢您的理解！");
//            message.setMessage_type("系统提醒");
//            message.setReciever(user.getUser_id());
//            message.setIsRead(0);
//            message.setSend_time(new Date());
//            session.setAttribute("message",message);
//            return "redirect:/Message/AutoSend";
//        }else{
            return "redirect:/Message/AutoSend";
//        }
    }
    @RequestMapping("disagree")
    public String disagree(HttpSession session,@RequestParam("message_id") int message_id,@RequestParam("content") String content){
        Order order= orderService.getByMessageID(message_id);
        if(content.equals("")){
           content="卖家未说明原因";
        }
        Message message=new Message();
        message.setSend_time(new Date());
        message.setIsRead(0);
        message.setReciever(order.getBuyer_id());
        message.setMessage_type("系统提醒");
        message.setMessage_content("您好！卖家拒绝您的购买请求！理由为："+content+"，再和卖家谈谈吧！");
        message.setSender("root");
        message.setMessage_title("卖家拒绝通知");
        session.setAttribute("message",message);
        return "redirect:/Message/AutoSend";
    }


}
