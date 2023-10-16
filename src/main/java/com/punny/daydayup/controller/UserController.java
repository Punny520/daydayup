package com.punny.daydayup.controller;

import com.punny.daydayup.pojo.Result;
import com.punny.daydayup.pojo.User;
import com.punny.daydayup.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @PostMapping
    public Result insertUser(User user){

        Result res = Result.success(user);

        res = userService.insertUser(res);

        return res;
    }

    @GetMapping
    public Result userLogin(User user){
        System.out.println(user);
        Result res = Result.success(user);
        res = userService.selectUser(res);
        return res;
    }
}
