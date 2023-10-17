package com.punny.daydayup.filt;
import com.alibaba.fastjson.JSONObject;
import com.punny.daydayup.pojo.Result;
import com.punny.daydayup.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@Slf4j
@WebFilter(urlPatterns = "/*")
public class userFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("拦截到了请求。");
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String URL = request.getRequestURL().toString();//获取请求URL
        log.info("URL = "+URL);
        if(URL.contains("register")||URL.contains("login")){//如果是注册和登录，直接放行
            log.info("直接放行");
            filterChain.doFilter(servletRequest,servletResponse);
            return ;
        }

        String token = request.getHeader("token");//从请求头获取token
        log.info("token = "+token);
        if(token == null){
            Result result = Result.error("token is null", null);
            String jsonString = JSONObject.toJSONString(result);
            response.getWriter().write(jsonString);
            return ;
        }
        try {
            JwtUtils.JwtParse(token);//解析token
        }catch (Exception e){
            e.printStackTrace();
            log.info("解析失败");
            Result result = Result.error("parse failed",null);
            String jsonString = JSONObject.toJSONString(result);
            response.getWriter().write(jsonString);
            return ;
        }
        filterChain.doFilter(servletRequest,servletResponse);
    }
}
