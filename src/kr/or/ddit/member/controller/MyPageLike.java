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

import com.google.gson.Gson;

import kr.or.ddit.common.PageVO;
import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.IMyPageService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.service.MyPageServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/member/like.do")
public class MyPageLike extends HttpServlet {
    private IMemberService memberService = MemberServiceImpl.getInstance();
    private IMateService mateService = MateServiceImpl.getInstance();
    private IMyPageService myPageService = MyPageServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        MemberVO loggedInUser = (MemberVO) session.getAttribute("user");

        if (loggedInUser == null) {
            session.setAttribute("redirectURL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }

        int currentPage = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memNo", loggedInUser.getMemNo());
        
        int totalCount = mateService.countList(paramMap);
        req.setAttribute("totalCount", totalCount);
        
		PageVO pageVO = new PageVO(totalCount, currentPage, 10);
		req.setAttribute("pageVO", pageVO);

        List<MateVO> likeList = mateService.likeList(paramMap);
        req.setAttribute("likeList", likeList);

        req.getRequestDispatcher("/views/member/mypagelike.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
        MemberVO loggedInUser = (MemberVO) session.getAttribute("user");

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }

        String action = req.getParameter("action");
        String clubNo = req.getParameter("clubNo");

        boolean isSuccess = false;
        if ("like".equals(action)) {
            // 좋아요 로직 수행
            isSuccess = true; // 결과에 따라 변경
        } else if ("unlike".equals(action)) {
            // 좋아요 취소 로직 수행
            isSuccess = true; // 결과에 따라 변경
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("success", isSuccess);
        resultMap.put("message", isSuccess ? "찜 상태가 변경되었습니다." : "찜 상태 변경에 실패하였습니다.");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new Gson().toJson(resultMap));
    }
}
