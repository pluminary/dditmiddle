package kr.or.ddit.mate.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.common.PageVO;
import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.place.vo.AthlVO;

//웹 애플리케이션에서 "/mate/list.do" 주소로 요청이 오면 이 코드가 실행됩니다.
@WebServlet("/mate/list.do")
public class MateList extends HttpServlet {
 
	 // HTTP GET 요청을 처리하는 메서드입니다. 웹 브라우저가 페이지를 요청할 때 이 메서드가 호출됩니다.
	 @Override
	 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	     // 동호회 정보를 관리하는 서비스 객체를 가져옵니다.
	     IMateService mateService = MateServiceImpl.getInstance();
	     // 플레이스 서비스 객체 가져옵니다.
	     IPlaceService placeService = PlaceServiceImpl.getInstance();
	     
	     // 웹 브라우저가 보낸 요청에서 세션 정보를 확인하여 로그인한 사용자 정보를 가져옵니다.
//	     MemberVO loggedInUser = (MemberVO) req.getSession().getAttribute("user");
	     MemberVO loggedInUser = (MemberVO) req.getSession().getAttribute("user");
	     // 로그인 여부를 확인합니다. 사용자 정보가 있으면 로그인한 것으로 간주합니다.
	     boolean isLoggedIn = (loggedInUser != null);
	     
	     // 요청에서 페이지 번호를 가져옵니다. 페이지 번호가 없으면 기본값으로 1을 사용합니다.
	     int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
	     
	     // 요청에서 검색 조건을 가져옵니다.
	     String athlName = req.getParameter("athlName");
	     String clubEndyn = req.getParameter("clubEndyn");
	     String mtName = req.getParameter("mtName");
	     
	     Map<String, Object> parammap = new HashMap<>();
	     parammap.put("athlName", athlName);
	     parammap.put("clubEndyn", clubEndyn);
	     parammap.put("mtName", mtName);
	     
	     // 동호회 총 개수를 조회합니다.
	     int count = mateService.getMateCount(parammap);
	     
	     // 검색조건(종목)에 뿌리기 위한 리스트
		 List<AthlVO> athlList = placeService.getAthl();
		 req.setAttribute("athlList", athlList);
		 
		 
		 
	     // 페이징 처리를 위한 객체를 생성합니다. 총 개수, 현재 페이지 번호, 페이지 당 목록 수를 설정합니다.
	     PageVO pg = new PageVO(count, pageNo, 10);
	     // 페이지 정보와 총 개수를 JSP 페이지로 전달하기 위해 요청 속성에 설정합니다.
	     req.setAttribute("pg", pg);
	     req.setAttribute("totalCount", count);
	     
	     // 동호회 목록을 가져오기 위한 시작 번호와 끝 번호를 설정합니다.
	     Map<String, Object> map = new HashMap<>();
	     int start = pg.getStart();
	     int end = pg.getEnd();
	     map.put("start", start);
	     map.put("end", end);
	     map.put("athlName", athlName);
	     map.put("clubEndyn", clubEndyn);
	     map.put("mtName", mtName);
	     
	     // 설정된 범위에 해당하는 동호회 목록을 가져옵니다.
	     List<MateVO> mates = mateService.getAllMate(map);
	
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
	     
	     // 동호회 목록 페이지로 요청을 전달합니다. JSP 페이지에서는 설정된 속성을 사용하여 목록을 표시합니다.
	     req.getRequestDispatcher("/views/mate/mateList.jsp").forward(req, resp);
	 }
	 
	 // HTTP POST 요청을 처리하는 메서드입니다. 일반적으로 데이터를 서버에 제출할 때 사용됩니다.
	 // 여기서는 POST 요청이 오면 GET 메서드를 호출하여 처리하도록 합니다.
	 @Override
	 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	     doGet(req, resp);
	 }
}

