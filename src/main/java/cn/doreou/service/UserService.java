package cn.doreou.service;

import cn.doreou.model.GoodAndUser;
import cn.doreou.model.User;

import java.util.List;

public interface UserService {
    void insertUser(User user);
    boolean isLogin(User user);
    boolean queryById(String userid);
    List<User> getById(String userid);
    void updateInfoById(User user);
    void updateHeadPic(User user);
    List<GoodAndUser> getInfoByGoods();
}
