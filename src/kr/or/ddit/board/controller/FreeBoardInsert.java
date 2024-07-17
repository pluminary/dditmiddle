package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.FreeBoardServiceImpl;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/freeboard/insert.do")
public class FreeBoardInsert extends HttpServlet {

	private FreeBoardServiceImpl service = (FreeBoardServiceImpl) FreeBoardServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/board/freeinsert.jsp").forward(req, resp);
	}
	
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String title = req.getParameter("title");
    	MemberVO user = (MemberVO) req.getSession().getAttribute("user");
		String content = req.getParameter("content");
		int memNo = user.getMemNo();
		int bclassNo = 2;
		
		FreeBoardVO board = new FreeBoardVO();
		board.setBoardTitle(title);
		board.setBoardContent(content);
		board.setMemNo(memNo);
		board.setBclassNo(bclassNo);
		
		service.insertBoard(board);
		
		// 등록 후 목록 페이지로 리다이렉트
		resp.sendRedirect(req.getContextPath() + "/freeboard/list.do");
    }
}
