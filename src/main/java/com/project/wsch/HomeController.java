package com.project.wsch;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.wsch.vo.ItemDAO;
import com.project.wsch.vo.ItemVO;
import com.project.wsch.vo.UserDAO;
import com.project.wsch.vo.UserVO;
import com.project.wsch.vo.WishListVO;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "opening";
	}

	@GetMapping("/home")
	public String home(Model model) {
		// db에서 베스트 아이템 가져오기
		ItemDAO dao = new ItemDAO();
		
		List<ItemVO> bestList = dao.getBestItems();
		model.addAttribute("bestList", bestList);
		
		return "home";
	}
	@GetMapping("/usersForm")
	public String usersForm() {
		
		
		return "/users/usersForm";
	}
	@GetMapping("/idCheck")
	public String idCheck() {
		
		
		return "/users/idCheck";
	}
	@GetMapping("/mypage")
	public String mypage() {
		
		
		return "/users/mypage";
	}
	// 위시리스트 목록 보기
	@GetMapping("/wishList")
    public String wishList(Model model, HttpSession session) {
    	ItemDAO dao = new ItemDAO(); 	
    	
    	String userid = (String)session.getAttribute("logId");

    	List<WishListVO> wishList = dao.getAllWish(userid);
    	model.addAttribute("wishList", wishList);
    	
    	List<ItemVO> items = dao.getAllItems();
    	model.addAttribute("items", items);

        return "/users/wishList";
    }
	
	@GetMapping("/edit")
	public String edit() {
		
		
		return "/users/edit";
	}
	@GetMapping("/board_list")
	public String board_list() {
		
		
		return "/board/board_list";
	}
	@GetMapping("/wsch_intro")
	public String wsch_intro() {
		
		
		return "/board/wsch_intro";
	}
	
	@PostMapping("/editOk")
	@ResponseBody
	public String userEdit(@RequestBody UserVO requestBodyVO, HttpSession session) {
	    String userid = (String) session.getAttribute("logId");

	    // 기존 코드에서 중복된 UserVO 변수명을 requestBodyVO로 변경
	    requestBodyVO.setUserid(userid);
	    System.out.println(requestBodyVO.toString());
	    
	    UserDAO dao = new UserDAO();
	    int result = dao.userEdit(requestBodyVO);

	    if (result > 0) {
	        return "회원 정보가 성공적으로 수정되었습니다.";
	    } else {
	        return "회원 정보 수정에 실패하였습니다.";
	    }
	}
	@Inject
	JavaMailSenderImpl mailSender;

	@PostMapping("/sendEMail")
	@ResponseBody
	public String sendEmail(HttpSession session, String email) {
	    UUID random = UUID.randomUUID();
	    String uuid = random.toString();
	    String subject = "우슬초 회원가입 이메일 인증번호입니다."; // 메일제목
	    String content = "<div style='background:lightblue;border:1px solid gray;"
	            + "border-radius:5px 5px 5px 5px;margin:30px;padding:30px;width:80%'>"
	            + "<h1>이 이메일은 회원가입을 위한 인증코드입니다</h1>"
	            + "<p style='font-size:1.5em'>인증코드:<span style='color:#00f'>" + uuid + "</span></p>"
	            + "</div>";
	    try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	        messageHelper.setFrom("woosulchoproject@naver.com"); // 보내는 메일 주소
	        messageHelper.setTo(email); // 받는 메일 주소
	        messageHelper.setSubject(subject);
	        messageHelper.setText(content, true); // HTML 형식으로 메일 내용을 설정
	        mailSender.send(message);
	        session.setAttribute("emailUUID", uuid);
	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	    return uuid;
	}
}
