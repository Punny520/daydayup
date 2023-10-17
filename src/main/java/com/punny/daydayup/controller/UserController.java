package com.punny.daydayup.controller;

import com.punny.daydayup.pojo.Result;
import com.punny.daydayup.pojo.User;
import com.punny.daydayup.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * 用户注册Controller
     * @param user
     * @return
     */
    @RequestMapping("/register")
    public Result userRegister(User user){
        Result res = Result.success("Controller接收成功",user);
        res = userService.userRegister(res);
        return res;
    }

    /**
     * 用户登录Controller
     * @param user
     * @return
     */
    @RequestMapping("/login")
    public Result userLogin(User user){
        Result res = Result.success("Controller接收成功",user);
        res = userService.userLogin(res);
        return res;
    }

    @RequestMapping("/profile")
    public Result userProfile(){

    }
}
