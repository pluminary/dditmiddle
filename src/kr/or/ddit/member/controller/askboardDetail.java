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

@WebServlet("/admin/askdetail.do")
public class askboardDetail extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	// 파라미터로 게시글 번호를 받아옵니다.
	int boardNo = Integer.parseInt(req.getParameter("no"));

	// 서비스 인스턴스를 가져옵니다.
	askBoardService askService = askBoardServiceImpl.getInstance();
	
	// 게시글 번호에 해당하는 상세 정보를 가져옵니다.
	askVO askboard = askService.detailAsk(boardNo);
	
	// 상세 정보를 request 객체에 속성으로 저장합니다.
	req.setAttribute("askboard", askboard);
	
	// 상세 정보를 보여줄 JSP로 포워드합니다.
	req.getRequestDispatcher("/views/member/askdetail.jsp").forward(req, resp);

	System.out.println(askboard);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
