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
import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateNoticeVO;
import kr.or.ddit.mate.vo.MateVO;
/**
 * 동호회 공지사항 리스트 화면
 * @author PC-02
 *
 */
@WebServlet("/mate/noticelist.do")
public class MateNoticeList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MateBoardServiceImpl service = MateBoardServiceImpl.getInstance();
		IMateService mservice = MateServiceImpl.getInstance();
		
		String clubNo = req.getParameter("clubNo");
		MateVO mv = mservice.getMateDetail(clubNo);
		String clubName = mv.getClubName();
		req.setAttribute("clubName", clubName);
		req.setAttribute("clubNo", clubNo);
		req.setAttribute("mv", mv);
		int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
		
		String sort = req.getParameter("sort") == null ? "" : req.getParameter("sort");
		String search = req.getParameter("search") == null ? "" : req.getParameter("search");
		
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("clubNo", clubNo);
		param.put("search", search);
		
		int cnt = service.getNoticeCount(param);
		req.setAttribute("cnt", cnt);
		PageVO pv = new PageVO(cnt, pageNo, 10);
		req.setAttribute("pv", pv);
		int start = pv.getStart();
		int end = pv.getEnd();
		
		param.put("start", start);
		param.put("end", end);
		param.put("sort", sort);
		
		req.setAttribute("sort", sort);
		req.setAttribute("search", search);
		List<MateNoticeVO> noticeList = service.getAllNotice(param);
		req.setAttribute("noticeList", noticeList);
		
		req.getRequestDispatcher("/views/mate/matenoticeList.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
