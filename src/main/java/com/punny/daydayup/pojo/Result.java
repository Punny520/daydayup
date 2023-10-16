package com.punny.daydayup.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Result {
    private Integer code;
    private String msg;
    private Object data;
    static public Result success(Object data){
        return new Result(1,"success",data);
    }
    static public Result error(){
        return new Result(0,"error",null);
    }
}
