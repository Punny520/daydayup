package com.punny.daydayup.utils;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.Map;

public class JwtUtils {
    private static String key = "punny";//自定义key

    public static String JwtGenerate(Map<String,Object> data){//将数据以key,value的形式加密保存在jwt中
        Date date = new Date(System.currentTimeMillis() + 3600 * 1000);//自定义过期时间为1小时
        String jwt = Jwts.builder()
                .signWith(SignatureAlgorithm.HS256,key)
                .setClaims(data)
                .setExpiration(date)
                .compact();
        return jwt;
    }
    public static Map<String,Object> JwtParse(String jwt){//将数据解密返回一个map集合
        Map<String, Object> claims = Jwts.parser()
                .setSigningKey(key)
                .parseClaimsJws(jwt)
                .getBody();
        return claims;
    }

}
