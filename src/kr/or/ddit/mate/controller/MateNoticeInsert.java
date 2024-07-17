package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateNoticeVO;
import kr.or.ddit.mate.vo.MateVO;

@WebServlet("/mate/noticeInsert.do")
public class MateNoticeInsert extends HttpServlet{
	
	IMateBoardService service = MateBoardServiceImpl.getInstance();
	IMateService ms = MateServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String cbNo = req.getParameter("clubNo");
		
		MateVO m = ms.getMateDetail(cbNo);
		req.setAttribute("m", m);
		
		req.getRequestDispatcher("/views/mate/mateNoticeInsert.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String cbNo = req.getParameter("cbno");
		int mno = Integer.parseInt(req.getParameter("mno"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		MateNoticeVO mv = new MateNoticeVO(title, content, cbNo, mno);
		
		service.noticeInsert(mv);
		
		resp.sendRedirect(req.getContextPath()+"/mate/noticelist.do?clubNo="+cbNo);
	}
}
