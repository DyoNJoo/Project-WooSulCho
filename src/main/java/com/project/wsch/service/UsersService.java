package com.project.wsch.service;

import java.util.List;

import com.project.wsch.vo.UserVO;


public interface UsersService {
	public List<UserVO> userList();
	void deleteUsers(String userid);
	
	public List<UserVO> findUsernameByEmail(String email);
	 public UserVO findPasswordByIdAndEmail(String id, String email);
}
