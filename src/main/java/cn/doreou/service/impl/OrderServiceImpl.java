package cn.doreou.service.impl;

import cn.doreou.mapper.OrderMapper;
import cn.doreou.model.Goods;
import cn.doreou.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public List<Goods> getMyBuy(String userid,String type){
        return orderMapper.getMyBuy(userid,type);
    }
    public List<Goods> getMySale(String userid,String type){
        return orderMapper.getMySale(userid,type);
    }
    public List<Goods> getSaleBySub(String subject){
        return orderMapper.getSaleBySub(subject);
    }
    public List<Goods> getBuyBySub(String subject){
        return orderMapper.getBuyBySub(subject);
    }
    public List<Goods> getAllSale(){
        return orderMapper.getAllSale();
    }
    public List<Goods> getAllBuy(){
        return orderMapper.getAllBuy();
    }
}
