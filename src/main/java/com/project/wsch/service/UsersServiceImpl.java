package com.project.wsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.wsch.mapper.UsersMapper;
import com.project.wsch.vo.UserVO;

@Service
public class UsersServiceImpl implements UsersService {

    @Autowired
    private UsersMapper mapper;

    @Override
    public List<UserVO> userList() {
        return mapper.userList();
    }

    @Transactional
    @Override
    public void deleteUsers(String userid) {
        mapper.deleteUsers(userid);
    }

    // 이메일을 기반으로 아이디를 찾는 메서드 구현
    @Override
    public  List<UserVO> findUsernameByEmail(String email) {
        // 사용자를 찾았으면 아이디 반환, 없으면 null 반환 또는 예외 처리
        return mapper.findUserByEmail(email);
    }
    //비밀번호 찾기
    @Override
	public UserVO findPasswordByIdAndEmail(String id, String email) {
	    return mapper.findPasswordByIdAndEmail(id, email);
	}

}