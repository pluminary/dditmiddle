package kr.or.ddit.mate.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.vo.MBoardFileVO;
import kr.or.ddit.mate.vo.MateBoardVO;

@WebServlet("/mate/boardDetail.do")
public class MateBoardDetail extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int no = Integer.parseInt(req.getParameter("no"));
		IMateBoardService service = MateBoardServiceImpl.getInstance();
		service.boardIncreaseCount(no);
		List<MBoardFileVO> list = service.getFile(no);
		req.setAttribute("file", list);
		
		MateBoardVO boardList = service.getDetailBoard(no);
		req.setAttribute("bList", boardList);
		
		req.getRequestDispatcher("/views/mate/mateBoardDetail.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
