package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.INoticeBoardService;
import kr.or.ddit.board.service.NoticeBoardServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.common.PageVO;
import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.place.vo.PlaceVO;

@WebServlet("/noticeboard/list.do")
public class NoticeBoardList extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		INoticeBoardService noticeBoardService = NoticeBoardServiceImpl.getInstance();
		
		int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
	    String sort = req.getParameter("sort") == null ? "latest" : req.getParameter("sort"); // 정렬 조건 추가
	    int count = noticeBoardService.getNoticeCount();
		
		PageVO pg = new PageVO(count, pageNo, 10);
		req.setAttribute("pg", pg);
		req.setAttribute("totalCount", count);  // 총 개수를 "totalCount"라는 이름으로 JSP에 전달
		
		Map<String, Object> map = new HashMap<String, Object>();
		int start = pg.getStart();
		int end = pg.getEnd();
		map.put("start", start);
		map.put("end", end);
		map.put("sort", sort); // 정렬 조건
		
		List<NoticeBoardVO> notice = noticeBoardService.getAllNotice(map);
		req.setAttribute("notice", notice);	// set name : "notice"
        
        // Forward to JSP
        req.getRequestDispatcher("/views/board/noticelist.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}    
