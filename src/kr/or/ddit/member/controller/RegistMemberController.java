package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

//@WebServlet("/member/memjoin.do")
@WebServlet("/member/regist.do")
public class RegistMemberController extends HttpServlet{

	private MemberServiceImpl service = (MemberServiceImpl) MemberServiceImpl.getInstance();
	private MemberDaoImpl dao = (MemberDaoImpl) MemberDaoImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 회원 가입 폼을 보여줌
		req.getRequestDispatcher("/views/member/memjoin.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // 세션에서 아이디 중복 확인 결과 가져오기
	    Integer idCheckResult = (Integer) req.getSession().getAttribute("idCheckResult");

	    // 닉네임 중복 확인 결과 가져오기
	    Integer nickCheckResult = (Integer) req.getSession().getAttribute("nickCheckResult");
	    
	    // 닉네임 중복 확인 결과 가져오기
	    Integer emailCheckResult = (Integer) req.getSession().getAttribute("emailCheckResult");
	    
	    // 아이디 중복 확인 결과가 null이면 처리
	    if (idCheckResult == null ) {
	        // 처리할 내용 작성
	    }
	    // 중복 확인 결과에 따라 처리
	    else if (idCheckResult > 0) {
	        // 이미 사용 중인 아이디 처리
	        req.setAttribute("error", "이미 사용 중인 아이디입니다");
	        req.getRequestDispatcher("/views/member/memjoin.jsp").forward(req, resp);
	        return;
	    } 
	    // 닉네임 중복 확인 결과에 따라 처리
	    else if (nickCheckResult != null && nickCheckResult > 0) {
	        // 이미 사용 중인 닉네임 처리
	        req.setAttribute("error", "이미 사용 중인 닉네임입니다");
	        req.getRequestDispatcher("/views/member/memjoin.jsp").forward(req, resp);
	        return;
	    }
	    // 이메일 중복 확인 결과에 따라 처리
	    else if (emailCheckResult != null && emailCheckResult > 0) {
	        // 이미 사용 중인 이메일 처리
	        req.setAttribute("error", "이미 사용 중인 이메일입니다");
	        req.getRequestDispatcher("/views/member/memjoin.jsp").forward(req, resp);
	        return;
	    }
	    	// 아이디와 닉네임 , 이메일 모두 중복이 아닌 경우 회원 등록 수행 
	    	else {
	        // 회원 가입 데이터 처리 로직
	        String memId = req.getParameter("memId");
	        String memPw = req.getParameter("memPw");	
	        String memPw2 = req.getParameter("memPw2");	
	        String memName = req.getParameter("memName");
	        String memBirth = req.getParameter("memBirth");
	        LocalDate memBirth2 = LocalDate.parse(memBirth);
	        String memPhone = req.getParameter("memPhone");	
//	        String memPhone2 = req.getParameter("memPhone2");	
//	        String memPhone3 = req.getParameter("memPhone3");	
	        String memEmail = req.getParameter("memEmail");				
	        String memEmail2 = req.getParameter("memEmail2");			
	        String tEmail = memEmail + '@' + memEmail2;					
	        String memNick = req.getParameter("memNick");
	        int levelNo = Integer.parseInt(req.getParameter("levelNo"));
	        
	        // 비밀번호와 비밀번호 확인이 일치하는지 확인
            if (!memPw.equals(memPw2)) {
                req.setAttribute("error", "비밀번호와 비밀번호 확인이 일치하지 않습니다");
                req.getRequestDispatcher("/views/member/memjoin.jsp").forward(req, resp);
                return;
            }
	       

	        MemberVO memberVO = new MemberVO();
	        
	        memberVO.setMemId(memId);
	        memberVO.setMemPw(memPw);
	        memberVO.setMemName(memName);
	        memberVO.setMemBirth(memBirth2);
	        memberVO.setMemPhone(memPhone);
	        memberVO.setMemEmail(tEmail);
	        memberVO.setMemNick(memNick);
	        memberVO.setLevelNo(levelNo);
	        
	        try {
	            // 회원 가입 서비스 호출
	            service.insertMember(memberVO);
	            
	            
	            // 성공적으로 가입되었으면 회원가입 환영페이지
	            //resp.sendRedirect(req.getContextPath() + "/login.do");
	            req.getRequestDispatcher("/views/member/registok.jsp").forward(req, resp);
	        } catch (Exception e) {
	            // 회원 가입 실패 시 다시 회원가입 폼으로 돌아가기
	            req.setAttribute("errorMessage", "회원 가입에 실패했습니다.");
	            req.getRequestDispatcher("/views/member/regist.do").forward(req, resp);
	        }
	    }
	}
}