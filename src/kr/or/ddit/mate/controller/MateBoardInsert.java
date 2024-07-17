package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MBoardFileVO;
import kr.or.ddit.mate.vo.MateBoardVO;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/mate/boardInsert.do")
@MultipartConfig
public class MateBoardInsert extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String clubNo = req.getParameter("clubNo");
		req.setAttribute("clubNo", clubNo);
		IMateService mservice = MateServiceImpl.getInstance();
		MateVO mateVO = mservice.getMateDetail(clubNo);
		req.setAttribute("mateVO", mateVO);
		req.getRequestDispatcher("/views/mate/mateBoardInsert.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IMateBoardService service = MateBoardServiceImpl.getInstance();
		MemberVO user = (MemberVO) req.getSession().getAttribute("user");
		int memNo = user.getMemNo();	//  로그인한 회원 정보로 수정해야함
		String clubNo = req.getParameter("clubNo"); 
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		
		MateBoardVO mv = new MateBoardVO(title, content, memNo, clubNo);
		System.out.println(mv);
		
		service.boardInsert(mv);
		
		try {
			MBoardFileVO vo = service.insertFile(req.getParts());
			System.out.println(vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(req.getContextPath()+"/mate/boardList.do?clubNo="+clubNo);
		
	}
}	
