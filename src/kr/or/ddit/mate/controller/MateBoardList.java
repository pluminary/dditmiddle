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
import kr.or.ddit.mate.vo.MateBoardVO;
import kr.or.ddit.mate.vo.MateVO;

@WebServlet("/mate/boardList.do")
public class MateBoardList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IMateBoardService service = MateBoardServiceImpl.getInstance();
		IMateService mservice = MateServiceImpl.getInstance();
		
		String clubNo = req.getParameter("clubNo");
		int pageNo = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
		
		MateVO mv = mservice.getMateDetail(clubNo);
		String clubName = mv.getClubName();
		req.setAttribute("clubNo", clubNo);
		req.setAttribute("mv", mv);
		
		// 검색, 정렬조건 받아오기
		String sort = req.getParameter("sort") == null ? "" : req.getParameter("sort");
		String search = req.getParameter("search") == null ? "" : req.getParameter("search");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("clubNo", clubNo);
		param.put("search", search);
		
		// 글 개수 가져오기
		int cnt = service.getBoardCount(param);
		req.setAttribute("cnt", cnt);
		
		// 페이징
		PageVO pv = new PageVO(cnt, pageNo, 10);
		req.setAttribute("pv", pv);
		
		int start = pv.getStart();
		int end = pv.getEnd();
		
		param.put("start", start);
		param.put("end", end);
		param.put("sort", sort);
		
		// 검색조건을 물고있기 위해 다시 보냄
		req.setAttribute("sort", sort);
		req.setAttribute("search", search);
		
		List<MateBoardVO> boardList = service.getAllBoard(param);
		req.setAttribute("boardList", boardList);
		
		req.getRequestDispatcher("/views/mate/mateBoardList.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
