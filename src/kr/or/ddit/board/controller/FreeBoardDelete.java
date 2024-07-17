package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.FreeBoardServiceImpl;

@WebServlet("/freeboard/delete.do")
public class FreeBoardDelete extends HttpServlet {
	
	private FreeBoardServiceImpl serviceImpl = (FreeBoardServiceImpl) FreeBoardServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int boardNo = Integer.parseInt(req.getParameter("no"));

        // 공지사항 삭제 서비스 호출
        serviceImpl.deleteBoard(boardNo);

        // 삭제 후 목록 페이지로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/freeboard/list.do");
	}
	
}
