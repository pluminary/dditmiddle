<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="kr.or.ddit.member.vo.MyPageVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/views/inclue/top.jsp" %>
<%

// 로그인 여부 확인
boolean isLoggedIn = (user != null);

// 로그인된 사용자의 아이디 출력 (디버깅 용도)
String loggedInUserId = isLoggedIn ? user.getMemId() : "비로그인 상태";
%>
<script>
$(document).ready(function() {
    $('#updatePasswordForm').on('submit', function(e) {
        var currentPassword = $('#currentPw').val();
        if (currentPassword === '') {
            alert('비밀번호를 입력해주세요.');
            e.preventDefault(); // 폼 제출 중단
        } else {
            // 서버로 비밀번호 확인 요청을 AJAX로 수행
            $.ajax({
                url: '<%=request.getContextPath()%>/member/info.do',
                type: 'POST',
                data: {
                    'memId': '<%=user.getMemId()%>',
                    'password': currentPassword
                },
                success: function(response) {
                    if (response == 'match') {
                        // 비밀번호 일치. 폼 제출 계속.
                    } else {
                        // 비밀번호 불일치. 에러 메시지 표시하고 폼 제출 중단.
                        $('#errorMessage').text('비밀번호가 일치하지 않습니다.');
                        e.preventDefault();
                    }
                },
                error: function() {
                    alert('비밀번호 확인 중 문제가 발생했습니다.');
                    e.preventDefault();
                }
            });
        }
    });
});
</script>



<!-- Content -->
<section id="con_noticeList" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
	    <ul>
	        <li><a href="/GymMate/member/mypage.do">마이 메이트</a></li>
	        <li class="on"><a href="<%=request.getContextPath()%>/member/info.do">회원정보</a></li>
	        <li><a href="<%=request.getContextPath()%>/member/like.do">찜관리</a></li>
	        <li><a href="<%=request.getContextPath()%>/member/askList.do">1:1 문의</a></li>
	    </ul>
	</div>
	

	<div class="login_wrap">
        <div id="" class="tit_wrap mb60 pt90">
            <h2>비밀번호 확인</h2>
            <p>개인정보 보호를 위해<br>비밀번호를 다시 한번 확인합니다</p>
        </div>
        
        <form id="updatePasswordForm" action="<%=request.getContextPath()%>/member/info.do" method="post">
            <input type="hidden" name="memId" value="<%= user.getMemId() %>" />
            <div class="s_wrap">
	        	<input type="password" id="currentPw" name="currentPw" class="f_input" placeholder="비밀번호" required autofocus>
	        </div>
	        <button type="submit" class="btn1 wd100 mt40">확인</button>
        </form>
        <div id="errorMessage" style="color: red;">
        	<% if (request.getAttribute("errorMessage") != null) { %>
        		<%= request.getAttribute("errorMessage") %>
    		<% } %>
        </div>
        
    </div>
</section>
<!-- // Content -->









<%@include file="/views/inclue/bottom.jsp" %>
