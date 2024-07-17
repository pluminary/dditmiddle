package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.board.service.FreeBoardServiceImpl;
import kr.or.ddit.board.service.IFreeBoardService;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.common.PageVO;
import kr.or.ddit.member.service.askBoardService;
import kr.or.ddit.member.service.askBoardServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.adminVO;
import kr.or.ddit.member.vo.askVO;

@WebServlet("/admin/askList.do")
public class askboardList extends HttpServlet {
		
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		int currentPage = 1;
    	currentPage = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
        // 전체 게시물 갯수
        askBoardService askService = askBoardServiceImpl.getInstance();
        String sortOption = req.getParameter("sort");
        String searchKeyword = req.getParameter("searchKeyword");
        
        System.out.println(sortOption+searchKeyword);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("sort", sortOption);
        paramMap.put("searchKeyword", searchKeyword);
        
        int totalCount = askService.getAskCountBySearch(paramMap);
        PageVO pageVO = new PageVO(totalCount, currentPage, 10);
        
        int start = pageVO.getStart();
        int end = pageVO.getEnd();
        paramMap.put("start", start);
        paramMap.put("end", end);
        
        req.setAttribute("pageVO", pageVO);
        
        List<askVO> askList = askService.getAlldata(paramMap);
        req.setAttribute("askList", askList);
        System.out.println(">>>>>>" + askList);

        req.getRequestDispatcher("/views/member/askList.jsp").forward(req, resp); 
    }
    
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
