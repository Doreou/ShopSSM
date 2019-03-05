package cn.doreou.mapper;


import cn.doreou.model.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    void insertUser(User user);//注册用户
    List<User> isLogin(User user);//用户登录
    List<User> queryById(String userid);
    void updateInfoById(User user);//修改用户信息
    void updateHeadPic(User user);
}
