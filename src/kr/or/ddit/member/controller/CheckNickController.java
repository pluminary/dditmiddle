package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.MemberServiceImpl;

@WebServlet("/member/checknick.do")
public class CheckNickController extends HttpServlet {
	
	private MemberServiceImpl service = (MemberServiceImpl) MemberServiceImpl.getInstance();
	private MemberDaoImpl dao = (MemberDaoImpl) MemberDaoImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// ajax 요청에서 전달된 memNick 파라미터 값 받기
		String memNick = req.getParameter("memNick");
		
		// 서비스를 통해 가져온 ID가 존재하는 체크해야함.
		int nCk = dao.nickCheck(memNick);
        
		// 세션에 중복 확인 결과 저장
	    req.getSession().setAttribute("nickCheckResult", nCk);
		
        // 응답 데이터 설정
        resp.setContentType("application/json;charset=UTF-8");
		
		
		PrintWriter out = resp.getWriter();
//		out.print("{\"result\": \"ok\"}");
		
		//중복된 닉네임이 있으면 1을, 없으면 0을 응답
        if (nCk > 0) {
            out.print("{\"nkCkResult\": \"fail\"}");
        } else {
            out.print("{\"nkCkResult\": \"success\"}");
        }
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
