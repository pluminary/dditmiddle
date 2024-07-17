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

@WebServlet("/member/checkid.do")
public class CheckIdController extends HttpServlet{
	
	private MemberServiceImpl service = (MemberServiceImpl) MemberServiceImpl.getInstance();
	private MemberDaoImpl dao = (MemberDaoImpl) MemberDaoImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// ajax 요청에서 전달된 memId 파라미터 값 받기
		String memId = req.getParameter("memId");
		
		// 서비스를 통해 가져온 ID가 존재하는 체크해야함.
		int idCk = dao.idCheck(memId);
		
		// 세션에 중복 확인 결과 저장
	    req.getSession().setAttribute("idCheckResult", idCk);
        
        // 응답 데이터 설정
        resp.setContentType("application/json;charset=UTF-8");
		
		
		PrintWriter out = resp.getWriter();
//		out.print("{\"result\": \"ok\"}");
		
		//중복된 ID가 있으면 1을, 없으면 0을 응답
        if (idCk > 0) {
            out.print("{\"idCheckResult\": \"fail\"}");
        } else {
            out.print("{\"idCheckResult\": \"success\"}");
        }
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
