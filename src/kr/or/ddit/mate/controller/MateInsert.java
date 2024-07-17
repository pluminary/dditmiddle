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

@WebServlet("/mate/insert.do")
public class MateInsert extends HttpServlet {

    private IMateService mateService;

    public void init() throws ServletException {
        super.init();
        mateService = MateServiceImpl.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 동호회 등록 페이지로 포워딩
        req.getRequestDispatcher("/views/mate/mateInsert.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 폼에서 제출된 데이터 추출
        String clubName = req.getParameter("clubName");
        String athlId = req.getParameter("athlNo");
        String clubFarea = req.getParameter("clubFarea");
        String clubAge = req.getParameter("clubAge");
        String clubFtzone = req.getParameter("clubFtzone");
        String clubMemo = req.getParameter("clubMemo");
        int clubTotalmem = Integer.parseInt(req.getParameter("clubTotalmem"));
        // 세션에서 사용자 번호 추출 로직 (예시로 사용자 번호를 직접 지정)
        MemberVO user = (MemberVO) req.getSession().getAttribute("user");
        String memNo = ""+user.getMemNo(); 

        // MateVO 객체 생성 및 데이터 설정
        MateVO mateVO = new MateVO();
        mateVO.setClubName(clubName);
        mateVO.setAthlId(athlId);
        mateVO.setClubFarea(clubFarea);
        mateVO.setClubAge(clubAge);
        mateVO.setClubFtzone(clubFtzone);
        mateVO.setClubMemo(clubMemo);
        mateVO.setClubTotalmem(clubTotalmem);
        mateVO.setMemNo(memNo);

        try {
            // 동호회 정보를 데이터베이스에 삽입
            int result = mateService.insertMate(mateVO);
            if (result > 0) {
                // 동호회 정보 삽입 성공 시, 리더 정보를 join 테이블에 삽입
                mateService.insertJoinLeader(mateVO);
            }
            // 처리 후 동호회 목록 페이지로 리다이렉션
            resp.sendRedirect(req.getContextPath() + "/mate/list.do");
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리 페이지로 리다이렉션 or 에러 메시지 출력
        }
    }
}
