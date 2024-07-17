package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BuyBoardServiceImpl;
import kr.or.ddit.board.vo.BuyBoardVO;
import kr.or.ddit.member.vo.MemberVO;


//장터게시판 등록 페이지
@WebServlet("/buyboard/insert.do")					
public class BuyBoardInsert extends HttpServlet {

	private BuyBoardServiceImpl service = (BuyBoardServiceImpl) BuyBoardServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/board/buyinsert.jsp").forward(req, resp);
	}
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String title = req.getParameter("title");
		String content = req.getParameter("content");
		MemberVO user = (MemberVO) req.getSession().getAttribute("user");
		int memNo = user.getMemNo(); // 추후에 수정 필요
		int bclassNo = 1;
		
		BuyBoardVO board = new BuyBoardVO();
		board.setBoardTitle(title);
		board.setBoardContent(content);
		board.setMemNo(memNo);
		board.setBclassNo(bclassNo);
		
		service.insertBoard(board);
		
		// 등록 후 목록 페이지로 리다이렉트
		resp.sendRedirect(req.getContextPath() + "/buyboard/list.do");
    }
}