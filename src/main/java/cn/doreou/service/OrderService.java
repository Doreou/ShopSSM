package cn.doreou.service;

import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;

import java.util.List;

public interface OrderService {
    //出售商品
    void sale(Goods goods);
    void buy(Goods goods);
    List<Goods> getMySale(String userid,String type,int start,int pagesize);
    List<Goods> getMyBuy(String userid,String type,int start,int pagesize);
    List<Goods> getSaleBySub(String subject,int start,int pagesize);
    List<Goods> getBuyBySub(String subject,int start,int pagesize);
    List<Goods> getAllSale();
    List<Goods> getAllBuy();
    List<GoodAndUser> getInfoById(String goods_id);
    List<Goods> SearchBuy(String key,int start,int pagesize);
    List<Goods> SearchSale(String key,int start,int pagesize);
    List<Goods> SearchAllBuyByPage(int start,int pagesize);
    List<Goods> SearchAllSaleByPage(int start,int pagesize);
    int getBuyCount();
    int getSaleCount();
    int getMyBuyCount(String userid,String type);
    int getMySaleCount(String userid,String type);
    int getCountBySub(String subject);
    int getSearchSaleCount(String key);
    int getSearchBuyCount(String key);
    void isundercarriage(int goods_id,int choice);
    int goodsStatus(int goods_id);
    void deleteGoods(int goods_id);
    List<Goods> orderByTime(int start,int pagesize,String way);
    List<Goods> orderByHot(int start,int pagesize,String way);
    List<Goods> orderByPrice(int start,int pagesize,String way);
}
