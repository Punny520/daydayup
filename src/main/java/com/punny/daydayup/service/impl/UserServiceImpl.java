package com.punny.daydayup.service.impl;

import com.punny.daydayup.dao.mappers.UserMapper;
import com.punny.daydayup.pojo.Result;
import com.punny.daydayup.pojo.User;
import com.punny.daydayup.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public Result insertUser(Result res) {
        //需要验证数据完整性
        int row = userMapper.insertUser((User) res.getData());
        if(row > 0) res = Result.success(null);
        else res = Result.error();
        return res;
    }
    @Override
    public Result selectUser(Result res){
        User tempUser = userMapper.selectUser((User) res.getData());
        if(tempUser == null){
            return Result.error();
        }
        return Result.success(null);
    }
}
