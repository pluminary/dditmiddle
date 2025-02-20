package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.FreeBoardServiceImpl;
import kr.or.ddit.board.service.IFreeBoardService;
import kr.or.ddit.board.vo.FreeBoardVO;

@WebServlet("/freeboard/detail.do")
public class FreeBoardDetail extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터로 게시글 번호를 받아옵니다.
		int boardNo = Integer.parseInt(req.getParameter("no"));
		
		// 서비스 인스턴스를 가져옵니다.
		IFreeBoardService freeBoardService = FreeBoardServiceImpl.getInstance();
		
		// 게시글 번호에 해당하는 게시글의 조회수를 1 증가시킵니다.
        freeBoardService.increaseViewCount(boardNo);
		
		// 게시글 번호에 해당하는 상세 정보를 가져옵니다.
		FreeBoardVO board = freeBoardService.detailBoard(boardNo);
		
		// 상세 정보를 request 객체에 속성으로 저장합니다.
		req.setAttribute("board", board);
		
		// 상세 정보를 보여줄 JSP로 포워드합니다.
		req.getRequestDispatcher("/views/board/freedetail.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
