package kr.or.ddit.mate.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/mate/forceDelete.do")
public class MateForceDelete extends HttpServlet{
	
	IMateService service = MateServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String clubNo = req.getParameter("clubNo");
		String no = req.getParameter("no");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clubNo", clubNo);
		map.put("memNo", no);
		
		service.deleteMate(map);
		
		resp.sendRedirect(req.getContextPath()+"/mate/memberList.do?clubNo="+clubNo);
	}
}
