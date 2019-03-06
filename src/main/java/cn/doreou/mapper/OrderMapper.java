package cn.doreou.mapper;

import cn.doreou.model.Goods;
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

}
