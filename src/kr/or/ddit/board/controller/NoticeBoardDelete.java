package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.NoticeBoardServiceImpl;

@WebServlet("/noticeboard/delete.do")
public class NoticeBoardDelete extends HttpServlet {

    private NoticeBoardServiceImpl serviceImpl = (NoticeBoardServiceImpl) NoticeBoardServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int noticeNo = Integer.parseInt(req.getParameter("no"));

        // 공지사항 삭제 서비스 호출
        serviceImpl.deleteNotice(noticeNo);

        // 삭제 후 목록 페이지로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/noticeboard/list.do");
    }
}
