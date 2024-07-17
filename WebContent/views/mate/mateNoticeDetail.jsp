<%@page import="kr.or.ddit.mate.vo.MateNoticeVO"%>
<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MateNoticeVO mmv = (MateNoticeVO)request.getAttribute("mv");
	MateVO mv = (MateVO) request.getAttribute("mateVO");
%>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>



<!-- Content -->
<section id="con_board" class="conBody">
    
    
    <div class="contents mt10">
        <div class="inner">
			<!-- 타이틀  -->
			<div id="" class="tit_wrap">
		        <h2><%=mmv.getCnoticeTitle() %></h2>
		        <ul>
		            <li><%=mmv.getCnoticeDate() %></li>
		            <li>조회 <%=mmv.getCnoticeCount() %></li>
		        </ul>
		    </div>
			
			<div class="contents board">
			    <div class="inner">
			        <div class="v_con">
			            <div class="board_con">
			                <pre><%=mmv.getCnoticeContent() %></pre>
			            </div>
			        </div>
			        <div class="btn">
			            <button id="list">목록</button>
			        <%
						String userNo = String.valueOf(user.getMemNo());
						String leader = mv.getMemNo();
						if(leader.equals(userNo)){
					%>
						<button id="update">수정</button>
						<button id="delete">삭제</button>
					<% } %>
			        </div>
			    </div>
			</div>
			

        </div>
    </div>
</section>
<!-- // Content -->

<script type="text/javascript">
	$('#list').on('click', function() {
		location.href="<%=request.getContextPath() %>/mate/noticelist.do?clubNo=<%=mv.getClubNo()%>";
	});
	$('#update').on('click', function() {
		location.href="<%=request.getContextPath() %>/mate/noticeupdate.do?no=<%=mmv.getCnoticeNo() %>&clubNo=<%=mv.getClubNo()%>";
	});
	$('#delete').on('click', function() {
	    if (confirm('정말 삭제하시겠습니까?')) {
	        location.href = '<%=request.getContextPath() %>/mate/noticeDelete.do?no=<%=mmv.getCnoticeNo() %>&clubNo=<%=mv.getClubNo()%>';
	    }
	});
</script>

<%@include file="/views/inclue/bottom.jsp" %>
