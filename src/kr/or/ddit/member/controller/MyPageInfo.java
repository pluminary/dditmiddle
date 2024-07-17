package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MyPageVO;

@WebServlet("/member/info.do")
public class MyPageInfo extends HttpServlet {
	
	private IMemberService service = MemberServiceImpl.getInstance();
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        MemberVO loggedInUser = (MemberVO) session.getAttribute("user");

        if (loggedInUser == null) {
            session.setAttribute("redirectURL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/login.do");
        } else {
            req.getRequestDispatcher("/views/member/mypageinfo.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        MemberVO loggedInUser = (MemberVO) session.getAttribute("user");

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }

        String currentPassword = req.getParameter("currentPw");
        boolean passwordMatches = service.verifyCurrentPassword(loggedInUser.getMemId(), currentPassword);

        if (passwordMatches) {
        	resp.sendRedirect(req.getContextPath() + "/member/update.do");
        } else {
        	req.setAttribute("errorMessage", "비밀번호를 다시 확인해주세요.");
        	req.getRequestDispatcher("/views/member/mypageinfo.jsp").forward(req, resp);
        }
    }
}