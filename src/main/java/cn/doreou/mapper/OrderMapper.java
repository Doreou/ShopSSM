package cn.doreou.mapper;

import cn.doreou.model.Goods;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderMapper {
//    发布求购
    void buy(Goods goods);
//    发布商品
    void sale(Goods goods);

}
