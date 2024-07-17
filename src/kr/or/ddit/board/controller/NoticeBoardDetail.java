package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.FreeBoardServiceImpl;
import kr.or.ddit.board.service.IFreeBoardService;
import kr.or.ddit.board.service.INoticeBoardService;
import kr.or.ddit.board.service.NoticeBoardServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;

@WebServlet("/noticeboard/detail.do")
public class NoticeBoardDetail extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파라미터로 게시글 번호를 받아옵니다.
		int noticeNo = Integer.parseInt(req.getParameter("no"));
		
		// 서비스 인스턴스를 가져옵니다.
		INoticeBoardService noticeBoardService = NoticeBoardServiceImpl.getInstance();
		
		// 게시글 번호에 해당하는 상세 정보를 가져옵니다.
		NoticeBoardVO notice = noticeBoardService.getNoticeDetail(noticeNo);
		
		// 상세 정보를 request 객체에 속성으로 저장합니다.
		req.setAttribute("notice", notice);
		
		// 상세 정보를 보여줄 JSP로 포워드합니다.
		req.getRequestDispatcher("/views/board/noticedetail.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
