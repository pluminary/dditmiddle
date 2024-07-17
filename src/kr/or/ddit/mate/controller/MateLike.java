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

@WebServlet("/mate/like.do")
public class MateLike extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IMateService service = MateServiceImpl.getInstance();

        // 요청 파라미터 받기
        String isLiked = req.getParameter("isLiked");
        int memNo = Integer.parseInt(req.getParameter("memNo"));
//        MemberVO user = (MemberVO) req.getSession().getAttribute("user");
//        int memNo = user.getMemNo();
        String clubNo = req.getParameter("clubNo");

        // 맵에 파라미터 추가
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("memNo", memNo);
        map.put("clubNo", clubNo);

        System.out.println("isLiked"+isLiked);

        // isLiked가 "true"일 경우에만 insertLike 실행
        if ("true".equals(isLiked)) {
            service.insertLike(map);
        } else {
            service.deleteLike(map);
        }
    }
}
