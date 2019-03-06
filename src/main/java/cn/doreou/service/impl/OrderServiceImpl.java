package cn.doreou.service.impl;

import cn.doreou.mapper.OrderMapper;
import cn.doreou.model.Goods;
import cn.doreou.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    public void sale(Goods goods){
        orderMapper.sale(goods);
    }
    public void buy(Goods goods){
        orderMapper.buy(goods);
    }

}
