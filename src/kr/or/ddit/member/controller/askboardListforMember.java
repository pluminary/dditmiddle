package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.board.service.FreeBoardServiceImpl;
import kr.or.ddit.board.service.IFreeBoardService;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.common.PageVO;
import kr.or.ddit.member.service.askBoardService;
import kr.or.ddit.member.service.askBoardServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.askVO;

@WebServlet("/member/askList.do")
public class askboardListforMember extends HttpServlet {
		
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		// 전체 게시물 갯수
		askBoardService askService = askBoardServiceImpl.getInstance();
		MemberVO user = (MemberVO) req.getSession().getAttribute("user");
		// 사용자가 로그인하지 않았다면 로그인 페이지로 리다이렉션합니다.
        if (user == null) {
            session.setAttribute("redirectURL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
		int memNo = user.getMemNo();

		List<askVO> askList = askService.getMydata(memNo);
		req.setAttribute("askList", askList);
		req.getRequestDispatcher("/views/member/askListforMember.jsp").forward(req, resp); 
   
	}
    
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
