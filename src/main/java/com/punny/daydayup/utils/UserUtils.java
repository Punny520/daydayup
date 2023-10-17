package com.punny.daydayup.utils;

import com.punny.daydayup.pojo.User;

public class UserUtils {
    /**
     * 用于检查用户输入的账号密码格式是否正确
     * @param user
     * @return
     */
    public static boolean userFormatChecker(User user){
        String username = user.getUsername();
        String password = user.getPassword();
        if(username == null || password == null) return false;
        if(username.length() < 6 || username.length() > 20) return false;
        if(password.length() < 6 || password.length() > 20) return false;
        return username.matches("^[a-zA-Z0-9]*$") && password.matches("^[a-zA-Z0-9]*$");
    }
}
