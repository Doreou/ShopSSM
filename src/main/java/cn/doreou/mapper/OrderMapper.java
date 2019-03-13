package cn.doreou.mapper;

import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;
import cn.doreou.model.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderMapper {
//    发布求购
    void buy(Goods goods);
//    发布商品
    void sale(Goods goods);
    List<Goods> getMySale(String userid,String type);
    List<Goods> getMyBuy(String userid,String type);
    List<Goods> getSaleBySub(String subject);
    List<Goods> getBuyBySub(String subject);
    List<Goods> getAllSale();
    List<Goods> getAllBuy();
    List<GoodAndUser> getInfoByid(String goods_id);
    List<Goods> SearchSale(String key);
    List<Goods> SearchBuy(String key);
    List<Goods> SearchBuyByPage(int start,int pagesize);
    List<Goods> SearchSaleByPage(int start,int pagesize);
    int getBuyCount();
    int getSaleCount();

}
