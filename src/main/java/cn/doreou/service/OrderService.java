package cn.doreou.service;

import cn.doreou.model.*;
import org.apache.ibatis.annotations.Param;

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
    List<Goods> orderByTime(int start,int pagesize,String way,String type,String sub);
    List<Goods> orderByHot(int start,int pagesize,String way,String type,String sub);
    List<Goods> orderByPrice(int start,int pagesize,String way,String type,String sub);
    void refresh(Goods goods);
    void refreshbuy(Goods goods);
    List<Goods> getMyCollect(String userid);
    void undoCollect(String userid,int goods_id);
    boolean isCollected(String userid,int goods_id);
    List<Message> getMyNews(String user_id);
    void AlreadyRead(int message_id,int status);
    List<Carousel> getAllCarousel();
    void InsertOrder(Order order);
    int getMaxMessageID();
    Order getByMessageID(int message_id);
    void updateGoodsNumById(int number,int goods_id);
    void OwnerConfirm(int order_id);
}
