<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>



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
            <h2>회원 탈퇴!</h2>
            <p>탈퇴시 삭제되는 정보는 복구가 불가능합니다.</p>
            <p>탈퇴를 원하신다면 비밀번호를 입력해주세요.</p> 
        </div>
        
        <form action="${pageContext.request.contextPath}/member/delete.do" method="post">
            <input type="hidden" name="memId" value="<%= user.getMemId() %>" />
            <div class="s_wrap">
	        	<input type="password" id="password" name="password" class="f_input" placeholder="비밀번호" required autofocus>
	        </div>
	        <button type="submit" class="btn1 wd100 mt40" onclick="deleteok();">탈퇴하기</button>
	        <button type="button"  class="btn1 wd100 mt10" onclick="goBack()">취소</button>
        </form>
        
        
	
	</form>
        
        
        
        <div id="errorMessage" style="color: red;">
        	<% if (request.getAttribute("errorMessage") != null) { %>
        		<%= request.getAttribute("errorMessage") %>
    		<% } %>
        </div>
        
    </div>
</section>
<!-- // Content -->

























<script>
	function deleteok() {
	        alert("탈퇴가 완료되었습니다.");
	}

	
   function goBack() {
       window.location.href = "${pageContext.request.contextPath}/member/update.do";
   }
</script>
<%@include file="/views/inclue/bottom.jsp" %>