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

import kr.or.ddit.member.service.IMyPageService;
import kr.or.ddit.member.service.MyPageServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MyPageVO;
import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.common.PageVO;
import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateVO;

@WebServlet("/member/mypage.do")
public class MyPage extends HttpServlet {
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 동호회 정보를 관리하는 서비스 객체를 가져옵니다.
	    IMateService mateService = MateServiceImpl.getInstance();
	    // 플레이스 서비스 객체 가져옵니다.
	    IPlaceService placeService = PlaceServiceImpl.getInstance();
		
	    HttpSession session = req.getSession();
	    // 웹 브라우저가 보낸 요청에서 세션 정보를 확인하여 로그인한 사용자 정보를 가져옵니다.
	    MemberVO loggedInUser = (MemberVO) req.getSession().getAttribute("user");
	    
	    // 사용자가 로그인하지 않았다면 로그인 페이지로 리다이렉션합니다.
        if (loggedInUser == null) {
            session.setAttribute("redirectURL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
	    // 로그인 여부를 확인합니다. 사용자 정보가 있으면 로그인한 것으로 간주합니다.
	    boolean isLoggedIn = (loggedInUser != null);
	    
		int currentPage = 1;
		currentPage = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
		
		IMyPageService myPageService = MyPageServiceImpl.getInstance();
		String sortOption = req.getParameter("sort");
		MemberVO user = (MemberVO) req.getSession().getAttribute("user");
		int memNo = user.getMemNo(); // 추후에 수정 필요
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("sort", sortOption);
		paramMap.put("memNo", memNo);

		int totalCount = myPageService.countList(paramMap);
		PageVO pageVO = new PageVO(totalCount, currentPage, 10);
		
		int start = pageVO.getStart();
		int end = pageVO.getEnd();
		paramMap.put("start", start);
		paramMap.put("end", end);

		List<MyPageVO> boardList = myPageService.boardList(paramMap);
		req.setAttribute("boardList", boardList);
		req.setAttribute("pageVO", pageVO);
		
		// 설정된 범위에 해당하는 동호회 목록을 가져옵니다.
	    List<MateVO> mates = mateService.getAllMate(paramMap);
	
	    // 로그인한 사용자가 각 동호회에 대해 '찜'을 눌렀는지 확인합니다.
	    if (isLoggedIn) {
	        for (MateVO mate : mates) {
	            // 사용자가 동호회를 좋아하는지 확인합니다.
	            boolean isLiked = mateService.isClubLikedByUser(loggedInUser.getMemNo(), mate.getClubNo());
	            // 각 동호회 정보에 좋아요 상태를 설정합니다.
	            mate.setLiked(isLiked);
	        }
	    }
	     
	    // 준비된 동호회 목록을 JSP 페이지로 전달하기 위해 요청 속성에 설정합니다.
	    req.setAttribute("mates", mates);

		req.getRequestDispatcher("/views/member/mypage.jsp").forward(req, resp); 
	}
    
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
