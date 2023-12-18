package com.project.wsch.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.wsch.service.UsersService;
import com.project.wsch.vo.UserDAO;
import com.project.wsch.vo.UserVO;


@Controller
@RequestMapping("/users")

public class UsersController {
	@Inject
	UsersService service;
	@GetMapping("/idpw_search")
	public String idpwsearch(){
		
		return "/users/idpw_search";
	}
	
	@GetMapping("/id_search")
	public String idsearch() {
	   
	   
	   return "/users/id_search";
	}

	@GetMapping("/pw_search")
	public String pwsearch() {
	   
	   
	   return "/users/pw_search";
	}

	@GetMapping("/id_searchOk")
	public String id_searchOk() {
	   
	   
	   return "/users/id_searchOk";
	}
	
	@GetMapping("/pw_searchOk")
	public String pwsearchOk() {
	   
	   
	   return "/users/pw_searchOk";
	}
	@GetMapping("/login")
	public String login() {
		
		
		return "/users/login";
	}
	//회원정보 수정
		@GetMapping("/configuration")
		public String userList(Model model) {
			List<UserVO> list = service.userList();
			model.addAttribute("list", list);
			return "/users/user_configuration";
		}
		
		@PostMapping("/deleteUsers")
		public String deleteUsers(@RequestBody List<String> checkedUsers) {
		    if (checkedUsers != null && !checkedUsers.isEmpty()) {
		        for (String userid : checkedUsers) {
		            // 여기서 실제로 회원을 탈퇴시키는 로직을 수행합니다.
		            // 이는 UsersServiceImpl에서 작성한 withdrawUser 메소드에 따라 동작합니다.
		            service.deleteUsers(userid);
		        }
		    }
		    // 탈퇴가 완료되면 회원 목록 페이지로 이동하도록 설정합니다.
		    return "redirect:/users/configuration";
		}
	//아이디 중복체크 ajax
	@PostMapping("/idCheck_ok")
	@ResponseBody
	public String idCheck(@RequestParam("inputId") String inputId) {		
		UserDAO dao = new UserDAO();
		int result = dao.idCheck(inputId);

		return String.valueOf(result);
	}
	
	
	//회원가입
	@PostMapping("/usersForm_ok")
	public String usersFormOk(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		UserVO vo = new UserVO();
		
		vo.setUserid(request.getParameter("userid"));
		vo.setUserpwd(request.getParameter("userpwd"));
		vo.setEmail(request.getParameter("email"));
		vo.setAddr(request.getParameter("addr"));
		vo.setPhonenum(request.getParameter("phonenum"));
		System.out.println(request.getParameter("userid"));
		UserDAO dao = new UserDAO();
		int result = dao.userInsert(vo);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			//회원가입 성공시 성공 메세지 띄우기
			out.println("<script>alert('"+request.getParameter("userid")+"님 환영합니다. 회원 가입이 완료되었습니다!'); location.href='login'; </script>");
			out.flush();
			return "redirect:/login";
		} else {
			//회원가입 실패시 실패 메세지
			out.println("<script>alert('회원 가입에 실패하였습니다.'); history.back(); </script>");
			out.flush();
			System.out.println(result);
			return "/users/usersFormResult";
		}
	}
	
	@PostMapping("/loginOk")
	public String loginOk(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		UserDAO dao = new UserDAO();
		String userid = dao.loginCheck(request.getParameter("userid"), request.getParameter("userpwd"));
		if(userid != null) {
			//로그인 성공, 세션 생성하기
			HttpSession session = request.getSession();
			session.setAttribute("logId", userid);
			session.setAttribute("logStatus", "Y");
			//admin 계정만 생성되는 세션
			if(userid.equals("admin")) {
				session.setAttribute("isAdmin", "Y");
			}
			session.setMaxInactiveInterval(1200);
			
			return "redirect:/home";
		}else {
			// 로그인 실패시 alert 띄우기
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아이디 또는 비밀번호를 다시 확인해주세요.'); history.back(); </script>");
			out.flush();
			return "redirect:/login";
		}
	}
	
	//로그아웃 질문
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		return "/users/logout";
	}
	
	//로그아웃 처리 세션 삭제 시간나면 post로 바꾸기
	@GetMapping("/logoutOk")
	public String logoutOk(HttpSession session) {
		session.invalidate();
		
		return "redirect:/home";
	}
	//아이디 찾기
	@RequestMapping(value = "/id_searchOk", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView id_searchOk(@RequestParam(required = true, value = "userEmail") String userEmail) {
			ModelAndView mav = new ModelAndView();
	        List<UserVO> uvo = service.findUsernameByEmail(userEmail);
	        
	        mav.addObject("uVO", uvo);
	        mav.setViewName("/users/id_searchOk");
	        return mav;

	}
	@Autowired
    private UsersService usersService;
	
	@PostMapping("/pw_search")
	public String findPassword(Model model, @RequestParam String id, @RequestParam String email, HttpServletResponse response) throws IOException {
	    UserVO uservo = usersService.findPasswordByIdAndEmail(id, email);
	    if(uservo != null) {
	        model.addAttribute("uservo", uservo);
	        return "/users/pw_searchOk";
	    } else {
	        // 비밀번호를 찾지 못했을 때의 메세지
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('입력한 아이디 또는 이메일로 등록된 계정이 없습니다.'); history.back();</script>");
	        out.flush();
	        return "pw_search";
	    }
	}
}
