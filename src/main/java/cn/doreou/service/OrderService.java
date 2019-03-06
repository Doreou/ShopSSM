package cn.doreou.service;

import cn.doreou.model.Goods;

public interface OrderService {
    //出售商品
    void sale(Goods goods);
    void buy(Goods goods);
}
