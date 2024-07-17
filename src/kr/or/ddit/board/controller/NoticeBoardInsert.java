package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.NoticeBoardServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;

@WebServlet("/noticeboard/insert.do")
public class NoticeBoardInsert extends HttpServlet {

	private NoticeBoardServiceImpl serviceImpl = (NoticeBoardServiceImpl) NoticeBoardServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/board/noticeinsert.jsp").forward(req, resp);
	}
	
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		NoticeBoardVO notice = new NoticeBoardVO();
		notice.setNoticeTitle(title);	// 사용자 입력값
		notice.setNoticeContent(content);	// 사용자 입력값
		notice.setAdminNo(1); // ADMIN 테이블에 존재하는 유효한 ADMIN_NO 값으로 설정. 추후 로그인한 관리자번호를 받아오는 것으로 변경 필요함
		
		serviceImpl.insertNotice(notice);
		
		// 등록 후 목록 페이지로 리다이렉트
		resp.sendRedirect(req.getContextPath() + "/noticeboard/list.do");
    }
}
