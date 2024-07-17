package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;

@WebServlet("/mate/noticeDelete.do")
public class MateNoticeDelete extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IMateBoardService service = MateBoardServiceImpl.getInstance();
		String clubNo = req.getParameter("clubNo");
		int no = Integer.parseInt(req.getParameter("no"));
		service.noticeDelete(no);
		
		resp.sendRedirect(req.getContextPath()+"/mate/noticelist.do?clubNo="+clubNo);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
