package com.punny.daydayup.service;

import com.punny.daydayup.pojo.Result;

public interface UserService {
    Result userRegister(Result res);
    Result userLogin(Result res);
}
