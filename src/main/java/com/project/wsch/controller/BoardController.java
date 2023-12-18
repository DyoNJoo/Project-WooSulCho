package com.project.wsch.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.project.wsch.vo.BoardDAO;
import com.project.wsch.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
    /*/wsch/board/board_list*/
    @GetMapping("/board_list")
    public String boardList() {
        // 로직 처리
        return "/board/board_list";
    }
    @GetMapping("/board_view")
    public String boardView() {
        // 로직 처리
        return "/board/board_view";
    }
    @GetMapping("/board_write")
    public String boardWrite() {
        // 로직 처리
        return "/board/board_write";
    }
    
    @GetMapping("/board_del")
    public String board_del() {
       return "/board/board_del";
    }
    @PostMapping("/board_edit_ok")
    public String boardEditOk(HttpServletRequest request) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 1. 전페이지(글수정폼)에 입력한 값을 서버로 가져온다.(request)
        BoardVO vo = new BoardVO();
        vo.setNo(Integer.parseInt(request.getParameter("no")));  // 수정할 글 번호
        vo.setSubject(request.getParameter("subject"));  // 제목
        vo.setContent(request.getParameter("content"));  // 글 내용
        vo.setStartDate(request.getParameter("start_date"));  // 시작 날짜
        vo.setEndDate(request.getParameter("end_date"));  // 종료 날짜
        vo.setLocation(request.getParameter("location"));  // 장소
        vo.setFee(Integer.parseInt(request.getParameter("fee")));  // 참가비용

        // 2. DB에 update 한다.
        BoardDAO dao = new BoardDAO();
        int result = dao.boardEditOk(vo);

        // 3. update 결과에 따른 실행이동한다.
        // 성공시 : 글 수정, 게시글 보기로 이동
        // 실패시 : 글 수정 폼으로 이동
        if(result > 0) {
            return "redirect:/board/board_view?no=" + vo.getNo();
        } else {
            return "/board/board_edit";
        }
    }
    @GetMapping("/board_edit")
    public String board_edit() {
       return "/board/board_edit";
    }
    
    @Autowired
    ServletContext servletContext;

    @PostMapping("/board_write_ok")
    public String boardWriteOk(HttpServletRequest request, @RequestParam("poster") MultipartFile poster) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        BoardVO vo = new BoardVO();

        // form 데이터
        vo.setSubject(request.getParameter("subject"));
        vo.setContent(request.getParameter("content"));
        vo.setStartDate(request.getParameter("start_date"));
        vo.setEndDate(request.getParameter("end_date"));
        vo.setLocation(request.getParameter("location"));

        // String을 int로 변환하여 fee 설정
        String feeString = request.getParameter("fee");
        int fee = 0;
        try {
            fee = Integer.parseInt(feeString);
        } catch (NumberFormatException e) {}
        vo.setFee(fee);

        // 파일 업로드 처리
        if (poster != null && !poster.isEmpty()) {
            String originalFileName = poster.getOriginalFilename();  // 원본 파일명

            String rootPath = servletContext.getRealPath("/");  // 웹 애플리케이션 루트 경로
            String filePath = rootPath + "uploadfile/" + originalFileName;  // 저장될 파일 경로

            try {
                poster.transferTo(new File(filePath));  // 파일 저장
            } catch (Exception e) {
                e.printStackTrace();
            }

            vo.setPoster("uploadfile/" + originalFileName);  // 파일 경로를 Board 객체에 저장
        }

        // session 글쓴이
        HttpSession session = request.getSession();
        vo.setUserid((String)session.getAttribute("logId"));

        // 클라이언트 ip
        vo.setIp(request.getRemoteAddr());

        // 2. DB에 insert한다.
        BoardDAO dao = new BoardDAO();
        int result = dao.boardInsert(vo);

        // 3. insert 결과에 따른 실행이동한다.
        // 성공시 : 글등록, 게시판 목록으로 이동
        // 실패시 : 글 등록 폼으로 이동
        if(result > 0) {
            return "redirect:/board/board_list";
        } else {
            return "/board/board_write";
        }
    }

}
