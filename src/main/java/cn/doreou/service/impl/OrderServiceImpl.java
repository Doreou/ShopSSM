package cn.doreou.service.impl;

import cn.doreou.mapper.OrderMapper;
import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;
import cn.doreou.service.OrderService;
import org.omg.CORBA.PUBLIC_MEMBER;
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
    public List<Goods> getMyBuy(String userid,String type,int start,int pagesize){
        return orderMapper.getMyBuy(userid,type,start,pagesize);
    }
    public List<Goods> getMySale(String userid,String type,int start,int pagesize){
        return orderMapper.getMySale(userid,type,start,pagesize);
    }
    public List<Goods> getSaleBySub(String subject,int start,int pagesize){
        return orderMapper.getSaleBySub(subject,start,pagesize);
    }
    public List<Goods> getBuyBySub(String subject,int start,int pagesize){
        return orderMapper.getBuyBySub(subject,start,pagesize);
    }
    public List<Goods> getAllSale(){
        return orderMapper.getAllSale();
    }
    public List<Goods> getAllBuy(){
        return orderMapper.getAllBuy();
    }
    public List<GoodAndUser> getInfoById(String goods_id){
        return orderMapper.getInfoByid(goods_id);
    }
    public List<Goods> SearchBuy(String key,int start,int pagesize){
        return orderMapper.SearchBuy(key,start,pagesize);
    }
    public List<Goods> SearchSale(String key,int start,int pagesize){
        return orderMapper.SearchSale(key,start,pagesize);
    }
    public List<Goods> SearchAllBuyByPage(int start,int pagesize){
        return orderMapper.SearchAllBuyByPage(start,pagesize);
    }
    public List<Goods> SearchAllSaleByPage(int start,int pagesize){
        return orderMapper.SearchAllSaleByPage(start,pagesize);
    }
    public int getBuyCount(){
        return orderMapper.getBuyCount();
    }
    public int getSaleCount(){
        return orderMapper.getSaleCount();
    }
    public int getMyBuyCount(String userid,String type){
        return orderMapper.getMyBuyCount(userid,type);
    }
    public int getMySaleCount(String userid,String type){
        return orderMapper.getMySaleCount(userid, type);
    }
    public int getCountBySub(String subject){
        return orderMapper.getCountBySub(subject);
    }
    public int getSearchSaleCount(String key){
        return  orderMapper.getSearchSaleCount(key);
    }
    public int getSearchBuyCount(String key){
        return  orderMapper.getSearchBuyCount(key);
    }
    public void isundercarriage(int goods_id,int choice){
        orderMapper.Isundercarriage(goods_id, choice);
    }
    public int goodsStatus(int goods_id){
        return  orderMapper.goodsStatus(goods_id);
    }
    public void deleteGoods(int goods_id){
        orderMapper.deleteGoods(goods_id);
    }
    public List<Goods> orderByTime(int start,int pagesize,String way,String type,String sub){
        return orderMapper.orderByTime(start,pagesize,way,type,sub);
    }
    public List<Goods> orderByHot(int start,int pagesize,String way,String type,String sub){
        return orderMapper.orderByHot(start,pagesize,way,type,sub);
    }
    public List<Goods> orderByPrice(int start,int pagesize,String way,String type,String sub){
        return orderMapper.orderByPrice(start,pagesize,way,type,sub);
    }
    public void refresh(Goods goods){
        orderMapper.refresh(goods);
    }
    public void refreshbuy(Goods goods){
        orderMapper.refreshbuy(goods);
    }

    public List<Goods> getMyCollect(String userid){
        return orderMapper.getMyCollect(userid);
    }
    public void undoCollect(String user_id,int goods_id){
        orderMapper.undoCollect(user_id,goods_id);
    }
    public boolean isCollected(String userid,int goods_id){
        if(orderMapper.isCollected(userid,goods_id).size()>0){
            return true;
        }else {
            return false;
        }
    }
}
