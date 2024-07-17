package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/member/delete.do")
public class DeleteMemberController extends HttpServlet{

	private MemberServiceImpl service = (MemberServiceImpl) MemberServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	// MyPage에서 현재 로그인된 사용자의 정보를 가져옴
 	   	HttpSession session = req.getSession();
 	   	MemberVO user = (MemberVO) session.getAttribute("user");
 	   
 	   	// 로그인된 사용자의 정보가 없을 경우 로그인 페이지로 이동
 	    if (user == null) {
 	        resp.sendRedirect(req.getContextPath() + "/login.do");
 	        return;
 	    }

    	
    	// 회원 탈퇴 페이지로 이동
 	    req.setAttribute("user", user);
        req.getRequestDispatcher("/views/member/memdelete.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 현재 로그인된 사용자의 정보를 가져옴
        HttpSession session = req.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");

        // 로그인된 사용자의 정보가 없을 경우 로그인 페이지로 이동
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }

        // 탈퇴 페이지에서 입력한 비밀번호 가져오기
        String inputPw = req.getParameter("password");
        
        // 현재 로그인된 사용자의 비밀번호와 입력한 비밀번호가 일치하는지 확인
        if (!user.getMemPw().equals(inputPw)) {
            // 비밀번호가 일치하지 않는 경우
            resp.sendRedirect(req.getContextPath() + "/member/delete.do");
            return;
        }

        // 비밀번호가 일치하면 회원 삭제 처리
        String memId = user.getMemId();
        int delete = service.delMember(memId);

        // 회원 삭제 성공 여부에 따라 액션 수행
        if (delete > 0) {
            // 세션에서 로그인 정보 삭제
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login.do");
        } else {
            // 실패 시 메인페이지? 어디로 갈까요오오
            resp.sendRedirect(req.getContextPath() + "/update.do");
        }
    }
}