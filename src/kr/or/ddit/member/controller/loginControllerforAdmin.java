package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.adminVO;

@WebServlet("/admin/login.do")
public class loginControllerforAdmin extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.getRequestDispatcher("/views/login/adminLoginform.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	    
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		System.out.println("id>>>>>>>>>>>>>>>"+username);
		System.out.println("pw>>>>>>>>>>>>>>>"+password);
		IMemberService memService = MemberServiceImpl.getInstance();
			
		// 해당 회원정보 가져오기
		adminVO av = memService.getAdmin(username);
		
		boolean isAdmin = false;
		
		if(av != null) {
			if(password.equals(av.getAdminPw())) {
				isAdmin = true;
			}
		}
		
		req.setAttribute("loginok", isAdmin);
		System.out.println(isAdmin);
		
		if(isAdmin) {
			req.getSession().setAttribute("admin", av);
			
			resp.sendRedirect(req.getContextPath() + "/place/gymlist.do");
		} else {
			req.getRequestDispatcher("/views/login/adminLoginform.jsp").forward(req, resp);
		}
		
	
	}
}
