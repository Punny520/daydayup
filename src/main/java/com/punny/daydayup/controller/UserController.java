package com.punny.daydayup.controller;

import com.punny.daydayup.pojo.Result;
import com.punny.daydayup.pojo.User;
import com.punny.daydayup.service.UserService;
import com.punny.daydayup.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

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

    /**
     * 个人资料Controller
     * @param request
     * @return
     */
    @RequestMapping("/profile")
    public Result userProfile(HttpServletRequest request){
        String token = request.getHeader("token");//获取请求头token
        Map<String, Object> claims;
        claims = JwtUtils.JwtParse(token);
        return Result.success("token解析成功",claims);
    }
}
