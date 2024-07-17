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

@WebServlet("/admin/reply.do")
public class askAnswerController extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int askNo = Integer.parseInt(req.getParameter("askNo"));
		String askAns = req.getParameter("askAnswer");
		
		askVO ans = new askVO();
		ans.setAskNo(askNo);
		ans.setAskAns(askAns);
		
		askBoardService askService = askBoardServiceImpl.getInstance();
		askService.updateAnswer(ans);
		resp.sendRedirect(req.getContextPath() + "/admin/askList.do");
		
	}
}