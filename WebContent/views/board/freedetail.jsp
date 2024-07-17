<%@ page import="kr.or.ddit.board.vo.FreeBoardVO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@include file="/views/inclue/top.jsp" %>

<!-- Content -->
<section id="con_board" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
	    <ul>
	        <li><a href="/GymMate/noticeboard/list.do">공지사항</a></li>
	        <li><a href="/GymMate/buyboard/list.do">거래장터</a></li>
	        <li class="on"><a href="/GymMate/freeboard/list.do">자유게시판</a></li>
	    </ul>
	</div>
	
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
		<c:set var="board" value="${requestScope.board}" />
        <h2>${board.boardTitle}</h2>
        <ul>
            <li class="writer">${board.memNick}</li>
            <li>${board.boardDate}</li>
            <li>조회 ${board.boardCount}</li>
        </ul>
    </div>
	
	<div class="contents mt60 board">
	    <div class="inner">
	        <div class="v_con">
	            <div class="board_con">
	                <pre>${board.boardContent}</pre>
	            </div>
	        </div>
	        <div class="btn">
			    <a href="list.do">목록</a>
			<%
				FreeBoardVO vo = (FreeBoardVO)request.getAttribute("board");
				
				if( user != null && vo.getMemNo() == user.getMemNo()){
			%>
			    <a href="update.do?no=${board.boardNo}">수정</a>
			    <a href="javascript:deleteBoard('<%=request.getContextPath()%>/freeboard/delete.do?no=${board.boardNo}');">삭제</a>
			<%
				}
			%>
	        </div>
	    </div>
	</div>
	
</section>
<!-- // Content -->

<script>
	function deleteBoard(url){
		if(confirm('정말로 삭제하시겠습니까?')){
			alert('게시물이 삭제되었습니다.');
			location.href = url;
		}
	}
</script> 

<%@include file="/views/inclue/bottom.jsp" %>