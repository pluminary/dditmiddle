package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;

@WebServlet("/mate/boardDelete.do")
public class MateBoardDelete extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int cbNo = Integer.parseInt(req.getParameter("no"));
		IMateBoardService service = MateBoardServiceImpl.getInstance();
		service.boardDeleteFile(cbNo);
		service.boardDelete(cbNo);
		String clubNo = req.getParameter("clubNo");
		resp.sendRedirect(req.getContextPath()+"/mate/boardList.do?clubNo="+clubNo);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
