package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/searchPw.do")
public class searchPw extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/login/searchPw.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String memberId = req.getParameter("username");
        String memtel = req.getParameter("phone");
//        String recipientEmail = req.getParameter("email"); // 입력한 이메일 주소 가져오기

        System.out.println("입력한 아이디: " + memberId);
        System.out.println("입력한 전화번호: " + memtel);
//        System.out.println("입력한 이메일: " + recipientEmail);

        // 사용자가 입력한 정보를 담을 객체
        MemberVO mv = new MemberVO();
        // 사용자가 아이디를 찾을 결과를 담을 객체
        MemberVO vo = new MemberVO();

        mv.setMemId(memberId);
        mv.setMemPhone(memtel);

        IMemberService memService = MemberServiceImpl.getInstance();

        vo = memService.searchPw(mv);
        String memPw = "";

        if (vo != null) {
            memPw = vo.getMemPw();
        }
        System.out.println("가져온 memPw : " + memPw);
        
        // 멤버 이메일 가져오기
        MemberVO vo2 = memService.getMember(memberId);
        String email = vo2.getMemEmail();

        // 이메일 속성 설정
        String host = "smtp.naver.com"; // Naver SMTP 서버 주소로 변경
        String port = "587"; // Naver SMTP 서버 포트 번호
        String senderEmail = "gymmate404@naver.com"; // 본인의 Naver 이메일 주소로 변경
        String senderPassword = "dlfwh404"; // 본인의 Naver 이메일 비밀번호로 변경

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        // 수신자 이메일 주소 설정
        String recipientEmail = email; // 이메일을 받을 대상의 이메일 주소로 변경
        
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            // 메시지 생성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail)); // 입력한 이메일 주소 설정
            message.setSubject("비밀번호 찾기 결과");
            message.setText("회원님의 비밀번호는 " + memPw + " 입니다.");
            
       
            // 이메일 전송
            Transport.send(message);
            System.out.println("이메일 전송 성공!");
        } catch (MessagingException e) {
            System.err.println("이메일 전송 실패: " + e.getMessage());
        }

        // 응답으로 JSON 형식의 결과 전송
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.print("{\"memPw\": \"" + memPw + "\"}");
        out.flush();
        out.close();
    }
}
