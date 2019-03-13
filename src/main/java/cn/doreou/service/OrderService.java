package cn.doreou.service;

import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;

import java.util.List;

public interface OrderService {
    //出售商品
    void sale(Goods goods);
    void buy(Goods goods);
    List<Goods> getMySale(String userid,String type);
    List<Goods> getMyBuy(String userid,String type);
    List<Goods> getSaleBySub(String subject);
    List<Goods> getBuyBySub(String subject);
    List<Goods> getAllSale();
    List<Goods> getAllBuy();
    List<GoodAndUser> getInfoById(String goods_id);
    List<Goods> SearchBuy(String key);
    List<Goods> SearchSale(String key);
    List<Goods> SearchBuyByPage(int start,int pagesize);
    List<Goods> SearchSaleByPage(int start,int pagesize);
    int getBuyCount();
    int getSaleCount();
}
