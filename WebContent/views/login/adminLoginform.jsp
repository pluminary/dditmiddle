<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/views/inclue/top.jsp" %>


<!-- Content -->
<section id="login" class="login_main">
    <div class="login_wrap">
        <div id="" class="tit_wrap mb60">
            <h2>관리자 로그인</h2>
            <p>반갑습니다!<br>우리동네 운동 플랫폼, 짐짝입니다.</p>
        </div>
        <form class="form-signin" method="post" action="<%=request.getContextPath()%>/admin/login.do">
	        <div class="s_wrap">
	            <input type="text" id="username" name="username" class="f_input" placeholder="아이디" required autofocus>
	        </div>
	        <div class="s_wrap mt20">
	            <input type="password" id="password" name="password" class="f_input" placeholder="비밀번호" required>
	        </div>
	        <button class="btn1 wd100 mt40" type="submit">로그인</button>
        </form>
    </div>
</section>
<!-- // Content -->

<%@include file="/views/inclue/bottom.jsp" %>
