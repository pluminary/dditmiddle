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
 * 검색버튼을 눌렀을 때 띄워질 화면
 * @author PC-02
 *
 */
@WebServlet("/place/searchGymList.do")
public class SearchGymList extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IPlaceService placeService = PlaceServiceImpl.getInstance();

		// 검색조건(종목)에 뿌리기 위한 리스트
		List<AthlVO> athlList = placeService.getAthl();
		req.setAttribute("athlList", athlList);

		String code = req.getParameter("code") == null ? "종목" : req.getParameter("code");
		String gu = req.getParameter("gu") == null ? "자치구" : req.getParameter("gu");
		String fcName = req.getParameter("fcName") == "" ? "" : req.getParameter("fcName");
//		System.out.println(code + gu + fcName);
		PlaceVO placeVO = new PlaceVO(fcName, code, gu);
		req.setAttribute("search", placeVO);
//		System.out.println("controller" +placeVO);

		int count = placeService.getPlaceCountBySearch(placeVO);
		System.out.println(count);
		int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));

		PageVO pg = new PageVO(count, pageNo, 10);
		req.setAttribute("pg", pg);
		req.setAttribute("cnt", count);

		Map<String, Object> map = new HashMap<String, Object>();
		int start = pg.getStart();
		int end = pg.getEnd();
		map.put("start", start);
		map.put("end", end);
		map.put("gu", gu);
		map.put("code", code);
		map.put("fcName", fcName);
		
		req.setAttribute("map", map);
		
		List<PlaceVO> placeList = placeService.getAllPlaceBySearch(map);
		System.out.println(placeList);
		req.setAttribute("placeList", placeList);

		req.getRequestDispatcher("/views/gymplace/searchPlace.jsp").forward(req, resp);
//		req.getRequestDispatcher("/views/gymplace/searchPlace.jsp?code="+code+"&gu="+gu+"&fcName="+fcName).forward(req, resp);
//		resp.sendRedirect(req.getContextPath() + "/place/searchGymList.do");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}
