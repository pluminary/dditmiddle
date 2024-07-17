package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.vo.MateNoticeVO;

@WebServlet("/mate/noticeupdate.do")
public class MateNoticeUpdate extends HttpServlet{
	IMateBoardService service = MateBoardServiceImpl.getInstance();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int no = Integer.parseInt(req.getParameter("no"));
		String clubNo =req.getParameter("clubNo");
		MateNoticeVO mv = service.getDetailNotice(no);
		req.setAttribute("mv", mv);
		
		req.getRequestDispatcher("/views/mate/mateNoticeUpdate.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int no = Integer.parseInt(req.getParameter("no"));
		String title = req.getParameter("title");
        String content = req.getParameter("content");
        String clubNo = req.getParameter("clubNo");
        
        MateNoticeVO mv = new MateNoticeVO();
        mv.setCnoticeNo(no);
        mv.setCnoticeTitle(title);
        mv.setCnoticeContent(content);
        
        service.noticeUpdate(mv);
        
        resp.sendRedirect(req.getContextPath() + "/mate/noticelist.do?clubNo="+clubNo);
        
	}
}
