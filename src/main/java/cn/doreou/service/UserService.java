package cn.doreou.service;

import cn.doreou.model.Applyer;
import cn.doreou.model.GoodAndUser;
import cn.doreou.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface UserService {
    void insertUser(User user);
    boolean isLogin(User user);
    boolean queryById(String userid);
    List<User> getById(String userid);
    void updateInfoById(User user);
    void updateHeadPic(User user);
    List<GoodAndUser> getInfoByGoods();
    void applyJob(Applyer applyer);
    boolean checkApply(String user_id);
    void collectThis(String goods_id, String userid, Date collect_time);
}
