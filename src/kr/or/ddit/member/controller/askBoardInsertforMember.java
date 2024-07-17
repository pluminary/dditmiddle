package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.askBoardServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.askVO;

@WebServlet("/member/askinsert.do")
public class askBoardInsertforMember extends HttpServlet{
	
	private askBoardServiceImpl askService = (askBoardServiceImpl) askBoardServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		req.getRequestDispatcher("/views/member/askinsertforMember.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title"); 
		String content = req.getParameter("content");
		String cars = req.getParameter("cars");
		MemberVO mv = (MemberVO) req.getSession().getAttribute("user");
		int memNo = mv.getMemNo();
		int adminNo = 1;
		
		askVO ask = new askVO();
		ask.setAskTitle(title);
		ask.setAskContent(content);
		ask.setMemNo(memNo);
		ask.setAskClass(cars);
		ask.setAdminNo(1);
		
		askService.insertAsk(ask);
		
		resp.sendRedirect(req.getContextPath() + "/member/askList.do");
	
	
	}
}
