package cn.doreou.mapper;

import cn.doreou.model.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;

@Repository
public interface OrderMapper {
//    发布求购
    void buy(Goods goods);
//    发布商品
    void sale(Goods goods);
//    获取我发布的
    List<Goods> getMySale(String userid,String type,int start,int pagesize);
    List<Goods> getMyBuy(String userid,String type,int start,int pagesize);
//    按照导航栏查询
    List<Goods> getSaleBySub(@Param("subject") String subject,int start,int pagesize);
    List<Goods> getBuyBySub(@Param("subject") String subject,int start,int pagesize);
//    获取全部商品信息
    List<Goods> getAllSale();
    List<Goods> getAllBuy();
//    通过商品ID获取用户/商品信息
    List<GoodAndUser> getInfoByid(String goods_id);
//    关键字查询分页
    List<Goods> SearchSale(@Param("key") String key,int start,int pagesize);
    List<Goods> SearchBuy(@Param("key") String key,int start,int pagesize);
//    查询全部结果并分页
    List<Goods> SearchAllBuyByPage(int start,int pagesize);
    List<Goods> SearchAllSaleByPage(int start,int pagesize);


//    查询总数
    int getBuyCount();
    int getSaleCount();
    int getMyBuyCount(String userid,String type);
    int getMySaleCount(String userid,String type);
    int getCountBySub(@Param("subject") String subject);
    int getSearchSaleCount(String key);
    int getSearchBuyCount(String key);

    //下架商品
    void Isundercarriage(@Param("goods_id") int goods_id,@Param("user_choice") int user_choice);
    int goodsStatus(@Param("goods_id") int goods_id);

    //删除商品记录
    void deleteGoods(@Param("goods_id") int goods_id);

    //排序
    List<Goods> orderByTime(@Param("start") int start,@Param("pagesize") int pagesize,@Param("way") String way,@Param("type") String type,@Param("sub") String sub);
    List<Goods> orderByHot(@Param("start") int start,@Param("pagesize") int pagesize,@Param("way") String way,@Param("type") String type,@Param("sub") String sub);
    List<Goods> orderByPrice(@Param("start") int start,@Param("pagesize") int pagesize,@Param("way") String way,@Param("type") String type,@Param("sub") String sub);

    //更新商品信息
    void refresh(Goods goods);
    void refreshbuy(Goods goods);

    //收藏
    List<Goods> getMyCollect(@Param("user_id") String userid);
    void undoCollect(@Param("user_id") String userid,@Param("goods_id") int goods_id);
    List<Goods> isCollected(@Param("user_id") String userid,@Param("goods_id") int goods_id);

    //消息
    List<Message> getMyNews(@Param("user_id") String user_id);
    void AlreadyRead(@Param("message_id") int Message_id, @Param("status") int status);

    List<Carousel> getAllCarousel();
}
