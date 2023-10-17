package com.punny.daydayup.service.impl;

import com.punny.daydayup.dao.mappers.UserMapper;
import com.punny.daydayup.pojo.Result;
import com.punny.daydayup.pojo.User;
import com.punny.daydayup.service.UserService;
import com.punny.daydayup.utils.JwtUtils;
import com.punny.daydayup.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户注册业务处理
     * @param res
     * @return
     */
    @Override
    public Result userRegister(Result res) {
        User user = (User) res.getData();
        if(!UserUtils.userFormatChecker(user)){//检查格式
            return Result.error("账号或密码无效",null);
        }

        int row = userMapper.insertUser((User) res.getData());//受影响的行数

        if(row > 0) res = Result.success("注册成功",null);
        else res = Result.error("注册失败",null);
        return res;
    }

    /**
     * 用户登录业务处理
     * @param res
     * @return
     */
    @Override
    public Result userLogin(Result res){
        User tempUser = userMapper.selectUser((User) res.getData());
        if(tempUser == null){
            return Result.error("账号或密码错误",null);
        }
        //创建token,并返回
        Map<String,Object> claims = new HashMap<>();
        claims.put("id",tempUser.getId());
        claims.put("username",tempUser.getUsername());
        String token = JwtUtils.JwtGenerate(claims);
        return Result.success("登录成功",token);
    }
}
