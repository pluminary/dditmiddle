<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.BuyBoardVO"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>

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
	    <h2>거래장터 수정</h2>
	    <p>거래할 물품을 등록해 주세요.</p>
	</div>
	
	<div class="contents">
        <div class="inner">
        	<%
				BuyBoardVO mv = (BuyBoardVO) request.getAttribute("board");
			%>
        	<form action="${pageContext.request.contextPath}/buyboard/update.do" method="POST" onsubmit="return validateForm();">
        		<input type="hidden" name="no" value="<%=mv.getBoardNo()%>">
            	<div class="f_wrap">
	                <div class="f_box f_box2">
	                    <strong>제목 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="title" name="title"  class="f_input" value="<%=mv.getBoardTitle() %>" required>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>내용 *</strong>
	                    <textarea id="content" name="content" required><%=mv.getBoardContent() %></textarea>
	                </div>
	            </div>
	
	            <!-- 버튼 영역 -->
	            <div class="btn_area">
				    <div class="btn">
			            <button type="button" onclick="cancelEdit();">취소</button>
    					<button onclick="alert('수정이 완료되었습니다.')" type="submit">저장</button>
				    </div>
				</div>
			</form>
        </div>
    </div>
	
</section>
<!-- // Content -->


<script type="text/javascript">
    function cancelEdit() {
        if (confirm("수정을 취소하시겠습니까?")) {
            alert("작업이 취소되었습니다.");
            window.location.href = "${pageContext.request.contextPath}/buyboard/list.do"; // 여기에 목록 페이지의 URL을 입력하세요.
        }
    }

    function validateForm() {
        var title = document.getElementById("title").value.trim();
        var content = document.getElementById("content").value.trim();
        
        if(title === "") {
            alert("제목을 입력해주세요");
            return false;
        }
        if(content === "") {
            alert("내용을 입력해주세요");
            return false;
        }
        // 서버로 폼 데이터를 제출하기 전에 추가적인 유효성 검사를 수행할 수 있습니다.
        return true; // 모든 검사를 통과하면 true를 반환하여 폼 제출을 계속합니다.
    }
</script>

<%@include file="/views/inclue/bottom.jsp" %>