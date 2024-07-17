package kr.or.ddit.member.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/member/update.do")
public class UpdateMemberController extends HttpServlet{
   
   private MemberServiceImpl service = (MemberServiceImpl) MemberServiceImpl.getInstance();
   
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
	   // MyPage에서 현재 로그인된 사용자의 정보를 가져옴
	   HttpSession session = req.getSession();
	   MemberVO user = (MemberVO) session.getAttribute("user");
	   
	   // 로그인된 사용자의 정보가 없을 경우 로그인 페이지로 이동
	    if (user == null) {
	        resp.sendRedirect(req.getContextPath() + "/login.do");
	        return;
	    }

	    // 회원 정보를 불러와서 수정 폼으로 전달
	    req.setAttribute("user", user);
	    req.getRequestDispatcher("/views/member/memupdate.jsp").forward(req, resp);
	}
   
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//      String userName = "홍길동";                  // 현재 로그인정보가 없기때문에 임의로


      // 세션에서 현재 로그인된 사용자의 정보를 가져옴
      HttpSession session = req.getSession();
      MemberVO user = (MemberVO) session.getAttribute("user");

      // 로그인된 사용자의 정보가 없을 경우 로그인 페이지로 이동
      if (user == null) {
         resp.sendRedirect(req.getContextPath() + "/login.do");
//         return;
      }
      
//      System.out.println(user);
      
      // 수정할 회원 정보 가져오기
        String memId = user.getMemId();
        String memName = user.getMemName();
        LocalDate memBirth = user.getMemBirth();
        String memPhone = req.getParameter("memPhone");
        String memEmail = req.getParameter("memEmail");
        String memEmail2 = req.getParameter("memEmail2");
        String tEmail = memEmail + '@' + memEmail2;
        String levelNoString = req.getParameter("levelNo");
        
        int levelNo = 0; // 기본값 설정
        if (levelNoString != null && !levelNoString.isEmpty()) {
            try {
                levelNo = Integer.parseInt(levelNoString);
            } catch (NumberFormatException e) {
                // 적절한 예외 처리를 여기서 수행합니다.
                // 예를 들어, 사용자에게 오류 메시지를 보여주거나 기본값을 사용할 수 있습니다.
            }
        }

        String memNick = req.getParameter("memNick");
        System.out.println("memNick 값: " + memNick);
        
        
        // 닉네임이 비어있는 경우 에러 메시지 설정 후 회원 정보 수정 페이지로 이동
        if (memNick == null || memNick.trim().isEmpty()) {
            req.setAttribute("errorMessage", "닉네임을 입력해주세요.");
            req.getRequestDispatcher("/views/member/memupdate.jsp").forward(req, resp);
            return;
        }

        // 회원 정보 업데이트를 위한 MemberVO 객체 생성
        MemberVO member = new MemberVO();
        member.setMemId(memId);       // 아이디는 수정되지 않음
        member.setMemName(memName);    // 이름은 수정되지 않음
        member.setMemBirth(memBirth);    // 생년월일은 수정되지 않음
        member.setMemPhone(memPhone);
        member.setMemEmail(tEmail);
        member.setLevelNo(levelNo);
        member.setMemNick(memNick); // 닉네임 설정

        // 회원 정보 업데이트 수행
        int update = service.updateMember(member);

        if (update > 0) {   // 수정 성공하면 어디로 가지?
            resp.sendRedirect(req.getContextPath() + "/member/mypage.do");
        } else {         // 수정 실패하면 다시 회원정보 수정창에 있자
            resp.sendRedirect(req.getContextPath() + "/member/update.do");
        }
    }
}