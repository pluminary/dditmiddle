package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.askBoardService;
import kr.or.ddit.member.service.askBoardServiceImpl;
import kr.or.ddit.member.vo.askVO;

@WebServlet("/member/askupdate.do")
public class askBoardUpdateforMember extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청 파라미터로부터 게시글 번호를 얻습니다.
		int boardNo = Integer.parseInt(req.getParameter("no"));
		System.out.println(boardNo);

	    // 비즈니스 로직을 처리할 서비스 인스턴스를 얻습니다.
		askBoardService askService = askBoardServiceImpl.getInstance();
		
	    // 게시글 번호에 해당하는 게시글 상세 정보를 조회합니다.
		askVO ask = askService.detailAsk(boardNo);
		
	    // 조회된 게시글 정보를 request 객체에 속성으로 저장합니다.
		req.setAttribute("board", ask);
		
	    // 수정 페이지로 포워드
		req.getRequestDispatcher("/views/member/askUpdateforMember.jsp").forward(req, resp);

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청 파라미터 얻기
		int askNo = Integer.parseInt(req.getParameter("no"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");

        // 비즈니스 로직 처리
		askVO ask = new askVO();
		ask.setAskNo(askNo);
		ask.setAskTitle(title);
		ask.setAskContent(content);
		
		askBoardService askService = askBoardServiceImpl.getInstance();
		askService.updateAsk(ask);
		
        // 등록 후 목록 페이지로 리다이렉트
		resp.sendRedirect(req.getContextPath() + "/member/askList.do");
		
		req.getSession().setAttribute("message", "수정완료");
	
	}
}
