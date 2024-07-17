package kr.or.ddit.place.controller;

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
import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.place.vo.AthlVO;
import kr.or.ddit.place.vo.PlaceVO;

/**
 * 플레이스 기본 화면
 * @author PC-02
 *
 */
@WebServlet("/place/gymlist.do")
public class GymList extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		IPlaceService placeService = PlaceServiceImpl.getInstance();
		
		int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
		int count = placeService.getPlaceCount();
		req.setAttribute("cnt", count);
		
		// 검색조건(종목)에 뿌리기 위한 리스트
		List<AthlVO> athlList = placeService.getAthl();
		req.setAttribute("athlList", athlList);
		System.out.println(athlList);
		
		PageVO pg = new PageVO(count, pageNo, 10);
		req.setAttribute("pg", pg);
		
		Map<String, Object> map = new HashMap<String, Object>();
		int start = pg.getStart();
		int end = pg.getEnd();
//		System.out.println(start + " , " +  end);
		map.put("start", start);
		map.put("end", end);
		
		List<PlaceVO> placeList = placeService.getAllPlace(map);
		req.setAttribute("placeList", placeList);
		System.out.println("controller : "+placeList);
		
		req.getRequestDispatcher("/views/gymplace/mainPlace.jsp").forward(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
