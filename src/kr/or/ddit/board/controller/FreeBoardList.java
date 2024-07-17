package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.FreeBoardServiceImpl;
import kr.or.ddit.board.service.IFreeBoardService;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.common.PageVO;

@WebServlet("/freeboard/list.do")
public class FreeBoardList extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int currentPage = 1;
    	currentPage = req.getParameter("pageNo") == null ? 1 : Integer.parseInt(req.getParameter("pageNo"));
        // 전체 게시물 갯수
        IFreeBoardService freeBoardService = FreeBoardServiceImpl.getInstance();
        String sortOption = req.getParameter("sort");
        String searchKeyword = req.getParameter("searchKeyword");
        
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("sort", sortOption);
        paramMap.put("searchKeyword", searchKeyword);
        
        int totalCount = freeBoardService.countList(paramMap);
        PageVO pageVO = new PageVO(totalCount, currentPage, 10);
        
        int start = pageVO.getStart();
        int end = pageVO.getEnd();
        paramMap.put("start", start);
        paramMap.put("end", end);
        
        req.setAttribute("pageVO", pageVO);
        
        List<FreeBoardVO> boardList = freeBoardService.boardList(paramMap);
        req.setAttribute("boardList", boardList);
        
        req.getRequestDispatcher("/views/board/freelist.jsp").forward(req, resp); 
    }
    
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
