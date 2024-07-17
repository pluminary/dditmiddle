<%@page import="kr.or.ddit.member.vo.adminVO"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 MemberVO user = (MemberVO) session.getAttribute("user");
 adminVO adminCheck = (adminVO)session.getAttribute("admin");
%>
<html lang="kr">
<head>
<meta charset="UTF-8">
<title>짐짝 :: 우리동네 운동 플랫폼</title>
<!-- CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/reset.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet">
<!-- FONT -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<!-- JS -->
<script src="<%=request.getContextPath()%>/assets/js/common.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div id="wrap">
<%-- <input type="button" value="1:1문의" onclick="location.href='<%= request.getContextPath()%>/member/askList.do?memNo=<%=user.getMemNo()%>'"> --%>

<!-- Header -->
<header>
	<div class="header_wrap clear">
	    <h1><a href="<%= request.getContextPath()%>/place/gymlist.do" id="" class="">GymMate</a></h1>
	    
	    <div id="nav_util" class="login_before">
			<ul class="util">
		
				<!-- 사용자 로그인 시  id="userLogin"가 display:block 되어야 함-->
				<li class="user" id="userLogin">
					<button type="button" id="userButton" class="">
					    <strong><%= user == null ? "" : user.getMemName() %></strong>님
					    <i class="ri-arrow-down-s-fill" aria-hidden="true"></i>
					</button>
					<div class="user_box" id="userBox" style="display: none;">
					    <a href="<%= request.getContextPath()%>/member/mypage.do" class="">마이 메이트</a>
					    <a href="<%= request.getContextPath()%>/member/info.do" class="">회원정보</a>
					    <a href="<%= request.getContextPath()%>/member/like.do" class="">찜관리</a>
					    <a href="<%= request.getContextPath()%>/member/askList.do" class="">1:1 문의</a>
					</div>
			    </li>
			    
			    <!-- 관리자 로그인 시  id="adminLogin"가  display:block 되어야 함-->
			    <li class="admin" id="adminLogin"><a href="<%= request.getContextPath()%>/admin/askList.do" id="csCenter" class="csCenter">고객센터</a></li>
			    
			    
			    <li class="weather weather-info">
			    	<a href="" id="" class=""><span class="weather-icon"></span><em>대전</em><span class="now-temp"></span></a>
			    </li>
			    
			    
			    <!-- 로그인 전에는  loginBefore이 보이고 로그인 후에는 loginAfter가 보인다-->
			    <li class="login" id="loginBefore"><a href="<%= request.getContextPath()%>/login.do" id="" class="">로그인</a></li>
			    <li class="logout" id="loginAfter" style="display: none;"><a href="javascript:void(0);" onclick="logoutConfirm('<%= request.getContextPath()%>/logout.do')" id="" class="">로그아웃</a></li>
			</ul>
	    </div>
	</div>
    
    <!-- 글로벌 메뉴 -->
    <div class="nav_wrap">
    	<nav>
            <ul class="gnb">
                <li class=""><a href="<%= request.getContextPath()%>/place/gymlist.do" id="" class="">GYM:플레이스</a></li>
                <li class=""><a href="<%= request.getContextPath()%>/mate/list.do" id="" class="">짝:MATE</a></li>
                <li class=""><a href="<%= request.getContextPath()%>/noticeboard/list.do" id="" class="">라운지</a></li>
            </ul>
	    </nav>
    </div>
</header>
<!-- // Header -->

<!-- 날씨 관련 스크립트 -->
<script type="text/javascript">
    $(document).ready(function () {
        // 현재 시간을 가져와서 특정 요소에 출력하는 함수
        function getCurrentTime() {
            var now = new Date();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();
      
            if(seconds < 10) seconds = '0' + seconds;
            return month + '/' + date + ' ' + hours + ':' + minutes + ':' + seconds ;
        }

        // 날씨 정보를 가져와서 화면에 출력하는 함수
        function getWeather() {
            $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Daejeon,kr&appid=9068e0b62fa4f74b9e51afbc7ef094f0&units=metric',
                function (weatherResult) {
                    $('.now-temp').append(weatherResult.main.temp + '°C');

                    var weatherIconUrl = '<img src="http://openweathermap.org/img/wn/'
                        + weatherResult.weather[0].icon +
                        '.png" alt="' + weatherResult.weather[0].description + '"/>';
                    $('.weather-icon').html(weatherIconUrl);
                });
        }

        // 현재 시간 출력
        setInterval(function () {
            $('.now-time').html(getCurrentTime());
        }, 1000); // 1초마다 갱신

        // 날씨 정보 출력
        getWeather();
    });
</script>
<!-- 상단메뉴 관련 스크립트 -->
<script>

    // 페이지 로드 시 실행
    document.addEventListener('DOMContentLoaded', function() {
    	// 사용자가 로그인되어 있지 않은 경우
        <% if(user == null && adminCheck == null) { %>
            document.getElementById('userLogin').style.display = 'none'; // 사용자 로그인 메뉴 숨김
            document.getElementById('loginBefore').style.display = 'block'; // 로그인 메뉴 보임
            document.getElementById('loginAfter').style.display = 'none'; // 로그아웃 메뉴 숨김
            document.getElementById('adminLogin').style.display = 'none'; // 관리자 로그인 메뉴 숨김
        <% } else { %>
            // 로그인된 사용자가 있는 경우
            document.getElementById('userLogin').style.display = 'block'; // 사용자 로그인 메뉴 보임
            document.getElementById('loginBefore').style.display = 'none'; // 로그인 메뉴 숨김
            document.getElementById('loginAfter').style.display = 'block'; // 로그아웃 메뉴 보임
        <% } %>
        
    	// 관리자가 로그인되어 있는 경우
        <% if(adminCheck != null) { %>
        	document.getElementById('adminLogin').style.display = 'block'; // 관리자 로그인 메뉴 표시
            document.getElementById('userLogin').style.display = 'none'; // 사용자 로그인 메뉴 숨김
            document.getElementById('loginBefore').style.display = 'none'; // 로그인 메뉴 숨김
            document.getElementById('loginAfter').style.display = 'block'; // 로그아웃 메뉴 보임
        <% } %>
    	
    	
    	
    	
        
    });
    
    
    function logoutConfirm(logoutUrl) {
        var confirmLogout = confirm("로그아웃 하시겠습니까?");
        if (confirmLogout) {
            // 사용자가 '예'를 선택한 경우, 로그아웃 URL로 이동
            window.location.href = logoutUrl;
        }
        // '아니오'를 선택한 경우, 아무런 작업도 수행하지 않음
    }
    
    
    // 마우스가 버튼 위에 있을 때
    document.getElementById('userButton').addEventListener('mouseenter', function() {
        var userBox = document.getElementById('userBox');
        var userButton = document.getElementById('userButton');

        userBox.style.display = 'block'; // userBox를 표시
        userButton.classList.add('on'); // 버튼에 'on' 클래스 추가
    });

    // 마우스가 userBox에서 벗어날 때
    document.getElementById('userBox').addEventListener('mouseleave', function() {
        this.style.display = 'none'; // userBox를 숨김
        document.getElementById('userButton').classList.remove('on'); // 버튼에서 'on' 클래스 제거
    });
</script>
