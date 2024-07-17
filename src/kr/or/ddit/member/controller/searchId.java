package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/searchId.do")
public class searchId extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/views/login/searchId.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String membername = req.getParameter("membername");
		membername = URLDecoder.decode(membername, "UTF-8"); 
		String memtel = req.getParameter("phone");

		System.out.println("입력한 이름: " + membername);
		System.out.println("입력한 전화번호: " + memtel);

		// 사용자가 입력한 정보를 담을 객체
		MemberVO mv = new MemberVO();
		// 사용자가 아이디를 찾을 결과를 담을 객체
		MemberVO vo = new MemberVO();

		mv.setMemName(membername);
		mv.setMemPhone(memtel);

		IMemberService memService = MemberServiceImpl.getInstance();

		// 사용자가 입력한 정보를 기준으로 회원을 검색
		vo = memService.searchId(mv);
		String memId = "";

		if (vo != null) {
			memId = vo.getMemId();
		}

		// 검색된 회원 아이디를 콘솔에 출력
		System.out.println("가져온 memId : " + memId);

		// 검색 결과를 JSP 페이지로 전달하기 위해 request 객체에 속성으로 설정
		req.setAttribute("memId", memId);

		PrintWriter out = resp.getWriter();
		
		out.print("{\"memId\": \"" + memId + "\"}");
		
		
	}

}
