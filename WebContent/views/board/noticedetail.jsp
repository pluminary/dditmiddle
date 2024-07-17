<%@page import="kr.or.ddit.member.vo.adminVO"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@ page import="kr.or.ddit.board.vo.FreeBoardVO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@include file="/views/inclue/top.jsp" %>

<!-- Content -->
<section id="con_board" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
	    <ul>
	        <li class="on"><a href="/GymMate/noticeboard/list.do">공지사항</a></li>
	        <li><a href="/GymMate/buyboard/list.do">거래장터</a></li>
	        <li><a href="/GymMate/freeboard/list.do">자유게시판</a></li>
	    </ul>
	</div>
	
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
		<c:set var="notice" value="${requestScope.notice}" />
        <h2>${notice.noticeTitle}</h2>
        <ul>
            <li>${notice.noticeDate}</li>
            <li>조회 ${notice.noticeCount}</li>
        </ul>
    </div>
	
	<div class="contents mt60 board">
	    <div class="inner">
	        <div class="v_con">
	            <div class="board_con">
	                <pre>${notice.noticeContent}</pre>
	            </div>
	        </div>
	        <div class="btn">
	            <a href="list.do">목록</a>
	        <%
           		adminVO admin = (adminVO)request.getSession().getAttribute("admin");
           		if(admin != null){
            %> 
			    <a href="<%=request.getContextPath()%>/noticeboard/update.do?no=${notice.noticeNo}">수정</a>
			    <a href="javascript:deleteNotice('<%=request.getContextPath()%>/noticeboard/delete.do?no=${notice.noticeNo}');">삭제</a>
			<%
           		}
			%>
	        </div>
	    </div>
	</div>
	
</section>
<!-- // Content -->
    
<script>
    function deleteNotice(url) {
        if(confirm('정말 삭제하시겠습니까?')) {
            location.href = url;
        }
    }
</script>

<%@include file="/views/inclue/bottom.jsp" %>
