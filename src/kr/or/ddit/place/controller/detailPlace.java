package kr.or.ddit.place.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.place.vo.MedicalVO;
import kr.or.ddit.place.vo.PlaceVO;

@WebServlet("/place/detailPlace.do")
public class detailPlace extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IPlaceService service = PlaceServiceImpl.getInstance();
		
		String fcNo = req.getParameter("fcNo");
		
		// 운동시설 상세정보를 담은 VO 
		PlaceVO placeVO = service.detailPlace(fcNo);
		req.setAttribute("detail", placeVO);
		
		// 인근 의료시설 정보를 담은 VO
		MedicalVO medicalVO = service.getMedicInfo(fcNo);
		req.setAttribute("medicInfo", medicalVO);
		
		req.getRequestDispatcher("/views/gymplace/detailPlaceView.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
