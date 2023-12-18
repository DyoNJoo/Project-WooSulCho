package com.project.wsch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.wsch.vo.UserVO;

public interface UsersMapper {
    List<UserVO> userList();
    void deleteUsers(String userid);
    // 이메일을 기반으로 사용자를 찾는 메서드 추가
    
    public List<UserVO> findUserByEmail(String email);
    
    UserVO findPasswordByIdAndEmail(@Param("id") String id, @Param("email") String email);
}
