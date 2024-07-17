package kr.or.ddit.place.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.place.vo.PlaceVO;

@WebServlet("/place/insert.do")
public class insertPlace extends HttpServlet{

	private PlaceServiceImpl placeService = PlaceServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/gymplace/insertPlace.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fcname = req.getParameter("fcName");		// 시설명
		String code = req.getParameter("code");			// 종목코드
		String fcaddr = req.getParameter("fcAddr");		// 시설 주소
		String fctel = req.getParameter("fcTel");		// 시설 주소
		int medicfcno = Integer.parseInt(req.getParameter("medicFc"));	// 의료시설 번호 
		String fcinfo = req.getParameter("fcInfo"); 	// 부가정보
		
		PlaceVO place = new PlaceVO();
		place.setFcName(fcname);
		place.setCodeNo(code);
		place.setFcAddr(fcaddr);
		place.setFcTell(fctel);
		place.setMedicFcNo(medicfcno);
		place.setFcInfo(fcinfo);
		
		System.out.println(place);
		
		placeService.insertPlace(place);
		
		resp.sendRedirect(req.getContextPath() + "/place/gymlist.do");
		
	}
}
