package com.punny.daydayup.dao.mappers;

import com.punny.daydayup.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {
    @Insert("insert into users value(null,#{username},#{password})")
    int insertUser(User user);

    @Select("select * from users where username = #{username} AND password = #{password}")
    User selectUser(User user);
}
