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
<link rel="stylesheet" href="/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
<style>
    body { font-family: Arial, sans-serif; line-height: 1.6; }
    .container { max-width: 800px; margin: auto; padding: 20px; }
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f4f4f4; }
    .pagination { text-align: center; margin-top: 20px; }
    .pagination a { display: inline-block; margin: 0 5px; padding: 5px 10px; border: 1px solid #ddd; color: black; text-decoration: none; }
    .pagination a:hover, .pagination a.active { background-color: #ddd; }
    .add-btn { display: block; width: max-content; padding: 5px 10px; margin: 20px auto; text-align: center; background-color: #333; color: white; text-decoration: none; }
    .add-btn:hover { background-color: #555; }
    .saveBtn {
        display: flex;
        justify-content: flex-end;
    }
    .clearFilters {
        display: flex;
        justify-content: flex-end;
    }
    .sort-options {
        text-align: right;
        margin: 10px 0;
    }
    .sort-form {
        display: inline-block;
    }
    .sort-select {
        padding: 5px;
        border-radius: 5px;
    }
    .search-input {
        padding: 5px;
        margin-right: 10px;
        border-radius: 5px;
    }
    .search-btn {
        padding: 5px 10px;
        border-radius: 5px;
        border: 1px solid #ddd;
    }
    .nav-buttons {
        display: flex;
        justify-content: start;
        margin-bottom: 20px;
    }
    .nav-buttons a {
        display: inline-block;
        background-color: #f4f4f4;
        color: #333;
        padding: 10px 15px;
        margin-right: 10px;
        text-decoration: none;
        border: 1px solid #ddd;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .nav-buttons a:hover {
        background-color: #ddd;
    }
    /* 모달 스타일 */
    .modal {
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4); /* 불투명한 검정색 배경 */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
    }

    .close-button {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close-button:hover,
    .close-button:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    /* 찜하기 버튼 스타일 */
    .like-off {
        background-color: #f4f4f4;
        color: #000;
    }
    
    .like-on {
        background-color: #ff0000;
        color: #fff;
    }
    .nav-buttons a.active {
    background-color: #007bff; /* 예시 색상, 원하는 색상으로 변경 가능 */
    color: white;
	}
	/* 비밀번호 필드와 버튼 스타일 */
    .password-field, .submit-button {
        width: 60%; /* 폼 너비에 맞게 확장 */
        padding: 10px; /* 패딩으로 필드와 버튼의 높이를 적절하게 설정 */
        margin-bottom: 20px; /* 필드와 버튼 사이의 여백을 조정 */
    }
</style>
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
    <div class="nav-buttons">
        <a href="<%=request.getContextPath()%>/member/mypage.do">마이 메이트</a>
        <a href="#" class="active">회원정보</a>
        <a href="<%=request.getContextPath()%>/member/like.do">찜관리</a>
        <a href="<%=request.getContextPath()%>/member/askList.do">1:1 문의</a>
    </div>
    <div class="content">
        <!-- 비밀번호 변경 폼 -->
        <h2>개인정보 보호를 위해 비밀번호를 다시 한번 확인합니다</h2>
        <form id="updatePasswordForm" action="<%=request.getContextPath()%>/member/info.do" method="post">
            <input type="hidden" name="memId" value="<%= user.getMemId() %>" />
	        <input type="password" id="currentPw" name="currentPw" class="password-field" placeholder="비밀번호" required>
	        <button type="submit" class="submit-button">확인</button>
        </form>
        <div id="errorMessage" style="color: red;">
        	<% if (request.getAttribute("errorMessage") != null) { %>
        		<%= request.getAttribute("errorMessage") %>
    		<% } %>
        </div>
    </div>
  </main>
</div>
<%@include file="/views/inclue/bottom.jsp" %>
