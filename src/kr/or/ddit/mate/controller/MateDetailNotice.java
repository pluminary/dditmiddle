package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateNoticeVO;
import kr.or.ddit.mate.vo.MateVO;

@WebServlet("/mate/detailNotice.do")
public class MateDetailNotice extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MateBoardServiceImpl service = MateBoardServiceImpl.getInstance();
		IMateService mservice = MateServiceImpl.getInstance();
		// 상세조회할 공지사항 정보 가져오기
		int no = Integer.parseInt(req.getParameter("no"));
		String clubNo = req.getParameter("clubNo");
		
		MateVO mateVO = mservice.getMateDetail(clubNo);
		req.setAttribute("mateVO", mateVO);
		// 조회수 증가시키기
		service.noticeIncreaseCount(no);
		MateNoticeVO mateNoticeVO = service.getDetailNotice(no);
		System.out.println(no);
		
		req.setAttribute("mv" , mateNoticeVO);
		
		req.getRequestDispatcher("/views/mate/mateNoticeDetail.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
