package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.NoticeBoardServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;

@WebServlet("/noticeboard/update.do")
public class NoticeBoardUpdate extends HttpServlet {

    private NoticeBoardServiceImpl serviceImpl = (NoticeBoardServiceImpl) NoticeBoardServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 공지사항 번호를 파라미터로 받아옴
        int noticeNo = Integer.parseInt(req.getParameter("no"));
        
        // 공지사항 상세 정보 조회
        NoticeBoardVO notice = serviceImpl.getNoticeDetail(noticeNo);
        
        // 조회된 공지사항 정보를 request 영역에 저장
        req.setAttribute("notice", notice);
        
        // 수정 페이지로 포워딩
        req.getRequestDispatcher("/views/board/noticeupdate.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 폼에서 입력 받은 공지사항 내용을 가져옴
        int noticeNo = Integer.parseInt(req.getParameter("no"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        
        // 공지사항 VO 생성 및 값 설정
        NoticeBoardVO notice = new NoticeBoardVO();
        notice.setNoticeNo(noticeNo);
        notice.setNoticeTitle(title);
        notice.setNoticeContent(content);
        
        // 공지사항 수정 서비스 호출
        serviceImpl.updateNotice(notice);
        
        // 수정 후 상세보기 페이지로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/noticeboard/detail.do?no=" + noticeNo);
    }
}
