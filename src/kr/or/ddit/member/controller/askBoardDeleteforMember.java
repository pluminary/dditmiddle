package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.askBoardServiceImpl;

@WebServlet("/member/askDelete.do")
public class askBoardDeleteforMember extends HttpServlet{

	private askBoardServiceImpl askImpl = (askBoardServiceImpl) askBoardServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int boardNo = Integer.parseInt(req.getParameter("no"));
	
		// 삭제
		askImpl.deleteAsk(boardNo);
		
		// 삭제후 목록페이지로
		resp.sendRedirect(req.getContextPath() + "/member/askList.do");
		
	}
	

	
}
