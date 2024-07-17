<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>
    
    
<!-- Content -->
<section id="con_join" class="conBody">
    
    <!-- 회원 가입 완료 -->
    <div id="" class="joinfinish_wrap mt60">
        <div class="joinfinish_area">
            <div id="" class="tit_wrap">
                <h3>가입이 완료되었습니다!</h3>
                <p>로그인 후 다양한 서비스를 이용해주시기 바랍니다.</p>
            </div>
            <div class="btn">
                <button onclick="goLogin()">로그인</button>
            </div>
        </div>
    </div>


</section>
<!-- // Content -->    
    

<script>
  function goLogin() {
    window.location.href = "<%=request.getContextPath()%>/login.do";
  }
</script>

<%@include file="/views/inclue/bottom.jsp" %>
    
    
    
    
    

