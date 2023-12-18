package com.project.wsch.vo;

import javax.servlet.http.HttpSession;

public class UserDAO extends DBConnection{
	
	//아이디 중복 체크
	public int idCheck(String inputId) {
		int result = 0;
		
		try {
			dbConnection();
			
			String sql = "SELECT count(*) FROM users where userid=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inputId);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return result;
	}
	
	
	//회원가입
	public int userInsert(UserVO vo) {
		int cnt = 0;
		try {
			dbConnection();
			
			String sql = "INSERT INTO users (userid, userpwd, email, addr, phonenum)" +
						"VALUES (?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getUserid());
			pstmt.setString(2, vo.getUserpwd());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getAddr());
			pstmt.setString(5, vo.getPhonenum());
			
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return cnt;
	}
	
	//로그인
	public String loginCheck(String userid, String userpwd) {
		String result = null;
		
		try {
			dbConnection();
			
			String sql = "SELECT userid, userpwd FROM users where userid=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(userid.equals(rs.getString("userid")) && userpwd.equals(rs.getString("userpwd"))) {
					result = rs.getString("userid");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return result;
	}
	
	//마이페이지
	public UserVO selectAll(HttpSession session) {
		String logId = (String) session.getAttribute("logId");
		
		UserVO vo = new UserVO();
		
		try {
			dbConnection();
			
			String sql = "SELECT userid, userpwd, email, addr, phonenum  FROM users where userid=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, logId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setUserid(rs.getString("userid"));
				vo.setUserpwd(rs.getString("userpwd"));
				vo.setEmail(rs.getString("email"));
				vo.setAddr(rs.getString("addr"));
				vo.setPhonenum(rs.getString("phonenum"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			dbClose();
		}
		return vo;
	}
	
	// 회원정보 수정
	public int userEdit(UserVO vo) {
	    int cnt = 0;
	    try {
	        dbConnection();
	        
	        String sql = "UPDATE users SET userpwd = ?, email = ?, addr = ?, phonenum = ? WHERE userid = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, vo.getUserpwd());  // 수정: getUserpwd()로 변경
	        pstmt.setString(2, vo.getEmail());
	        pstmt.setString(3, vo.getAddr());
	        pstmt.setString(4, vo.getPhonenum());
	        pstmt.setString(5, vo.getUserid());  // 수정: getUserid()로 변경
	        
	        cnt = pstmt.executeUpdate();
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        dbClose();
	    }
	    return cnt;
	}

}
