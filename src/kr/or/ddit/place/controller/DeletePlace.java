package kr.or.ddit.place.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;

@WebServlet("/place/deleteplace.do")
public class DeletePlace extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IPlaceService service = PlaceServiceImpl.getInstance();
		
		String fcNo = req.getParameter("fcNo");
		service.deletePlace(fcNo);
		
		resp.sendRedirect(req.getContextPath()+"/place/gymlist.do");
	}
}
