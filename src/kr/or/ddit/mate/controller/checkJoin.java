package kr.or.ddit.mate.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateService;
import kr.or.ddit.mate.service.MateServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/checkJoin.do")
public class checkJoin extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IMateService service = MateServiceImpl.getInstance();
		
		// 로그인한 회원이 해당 동호회에 가입되어 있는지 확인
		MemberVO user = (MemberVO) req.getSession().getAttribute("user");
		int memNo = user.getMemNo();
		String clubNo = req.getParameter("clubNo");
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("memNo", memNo);
		map.put("clubNo", clubNo);
		int cnt = service.checkJoin(map);

		// 여기서 가입 여부를 확인하고, 결과를 클라이언트로 응답합니다.
		boolean isMember = false;
		if (cnt > 0)
			isMember = true;

		resp.getWriter().write("{\"isMember\": " + isMember + "}");
//		System.out.println(isMember);
	}
}
