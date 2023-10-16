package com.punny.daydayup.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 用来处理页面跳转
 */
@Controller
public class GuideController {
    @RequestMapping("/")
    public String homePage(){
        return "homePage";
    }

    @RequestMapping("/register")
    public String register(){
        return "register";
    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/profile")
    public String profile(){
        return "profile";
    }
}
