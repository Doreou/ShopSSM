package cn.doreou.service;

import cn.doreou.model.Goods;

import java.util.List;

public interface OrderService {
    //出售商品
    void sale(Goods goods);
    void buy(Goods goods);
    List<Goods> getMySale(String userid,String type);
    List<Goods> getMyBuy(String userid,String type);
}
