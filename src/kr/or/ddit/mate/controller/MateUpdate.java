package kr.or.ddit.mate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/mate/update.do")
public class MateUpdate extends HttpServlet{
	
	IMateService service = MateServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String clubNo = req.getParameter("clubNo");
		
		MateVO mv = service.getMateDetail(clubNo);
		req.setAttribute("mv", mv);
		
		req.getRequestDispatcher("/views/mate/mateUpdate.jsp").forward(req, resp);
		
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 폼에서 제출된 데이터 추출
        String clubFarea = req.getParameter("clubFarea");
        String clubAge = req.getParameter("clubAge");
        String clubFtzone = req.getParameter("clubFtzone");
        String clubMemo = req.getParameter("clubMemo");
        clubMemo.replaceAll("\n","<br>");
        int clubTotalmem = Integer.parseInt(req.getParameter("clubTotalmem"));
        String clubNo = req.getParameter("clubNo");
        
        // MateVO 객체 생성 및 데이터 설정
        MateVO mateVO = new MateVO();
        mateVO.setClubFarea(clubFarea);
        mateVO.setClubAge(clubAge);
        mateVO.setClubFtzone(clubFtzone);
        mateVO.setClubMemo(clubMemo);
        mateVO.setClubTotalmem(clubTotalmem);
        mateVO.setClubNo(clubNo);

        service.updateMate(mateVO);
        resp.sendRedirect(req.getContextPath() + "/mate/home.do?clubNo="+clubNo);
	}
}
