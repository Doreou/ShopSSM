package cn.doreou.mapper;


import cn.doreou.model.Applyer;
import cn.doreou.model.GoodAndUser;
import cn.doreou.model.Goods;
import cn.doreou.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface UserMapper {
    void insertUser(User user);//注册用户
    List<User> isLogin(User user);//用户登录
    List<User> queryById(String userid);
    void updateInfoById(User user);//修改用户信息
    void updateHeadPic(User user);
    String getHeadPic(String userid);
    List<GoodAndUser> getInfoByGoods();
    void applyJob(Applyer applyer);
    List<Applyer> checkApply(@Param("user_id") String user_id);
    void collectThis(@Param("goods_id") String goods_id, @Param("user_id") String userid, @Param("collect_time") Date collect_time);
}
