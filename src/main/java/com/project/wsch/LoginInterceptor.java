package com.project.wsch;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// interceptor 클래스는 HandlerInterceptorAdapter를 상속 받아야 함.
public class LoginInterceptor extends HandlerInterceptorAdapter {
	// 컨트롤러가 호출되기 전에 실행하는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		//로그인 유무 확인하여 로그인 된 경우 호출한 매핑 주소로 이동
		//로그인 안 된 경우 로그인 폼으로 이동하도록 실행을 변경
		
		HttpSession session =request.getSession();
		
		// null or "Y"
		String logStatus = (String)session.getAttribute("logStatus");
		
		if(logStatus == null || !logStatus.equals("Y")) {// 로그인이 안 된 경우 -> 가던 길을 멈추고 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/account/logIn");
			return false;
		}
		// 반환형이 true이면 원래 맵핑으로 지속하고
		// 			false이면 새로운 주소로 이동한다.
		return true;
	}
	// 컨트롤러를 실행 후 view 페이지로 이동하기 전에 실행되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			@Nullable ModelAndView mav)throws Exception {
	}
	// 컨트롤러가 실행 후 호출되는 메소드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable Exception e)throws Exception{
		
	}
}
