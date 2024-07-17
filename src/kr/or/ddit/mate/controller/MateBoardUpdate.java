package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.vo.MateBoardVO;

@WebServlet("/mate/boardUpdate.do")
public class MateBoardUpdate extends HttpServlet{
	
	IMateBoardService service = MateBoardServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int cbNo = Integer.parseInt(req.getParameter("no"));
		MateBoardVO mv = service.getDetailBoard(cbNo);
		req.setAttribute("mv", mv);
		
		req.getRequestDispatcher("/views/mate/mateBoardUpdate.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		int no = Integer.parseInt(req.getParameter("no"));
		String clubNo = req.getParameter("clubNo");
		
		MateBoardVO mv = new MateBoardVO();
		mv.setCbNo(no);
		mv.setCbContent(content);
		mv.setCbTitle(title);
		
		service.boardUpdate(mv);
		
		resp.sendRedirect(req.getContextPath()+"/mate/boardList.do?clubNo="+clubNo);
	}
}
