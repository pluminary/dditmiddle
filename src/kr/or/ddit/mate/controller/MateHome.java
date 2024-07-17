package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/mate/home.do")
public class MateHome extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IMateService service = MateServiceImpl.getInstance();
		
		String clubNo = req.getParameter("clubNo");
		MateVO mv = service.getMateDetail(clubNo);
		int no = Integer.parseInt(mv.getMemNo());
		System.out.println(no);
		
		MemberVO leader = service.getLeaderInfo(no);
		req.setAttribute("leader", leader);
		
		req.setAttribute("mv", mv);
		
		req.getRequestDispatcher("/views/mate/mateHome.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
