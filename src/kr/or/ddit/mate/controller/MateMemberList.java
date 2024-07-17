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
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateMemberVO;
import kr.or.ddit.mate.vo.MateVO;

/**
 * 동호회 멤버 화면
 * @author PC-02
 *
 */
@WebServlet("/mate/memberList.do")
public class MateMemberList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MateBoardServiceImpl service = MateBoardServiceImpl.getInstance();
		IMateService mservice = MateServiceImpl.getInstance();
		
		String clubNo = req.getParameter("clubNo");
		int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
		
		MateVO mv = mservice.getMateDetail(clubNo);
		req.setAttribute("mv", mv);
		
		int cnt = service.getMemberCount(clubNo);
		req.setAttribute("cnt", cnt);
		
		PageVO pv = new PageVO(cnt, pageNo, 15);
		req.setAttribute("pv", pv);
		int start = pv.getStart();
		int end = pv.getEnd();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("clubNo", clubNo);
		
		List<MateMemberVO> memList = service.getMateMember(map);
		req.setAttribute("memList", memList);
		req.setAttribute("clubNo", clubNo);
		
		req.getRequestDispatcher("/views/mate/mateMemList.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
