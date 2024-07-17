<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@include file="/views/inclue/top.jsp" %>

<%
	MateVO mv = (MateVO)request.getAttribute("m");
%>

<!-- Content -->
<section id="con_board" class="conBody tab">
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
	    <h2>공지사항 등록</h2>
	    <p>동호회의 중요한 소식들을 작성해 주세요.</p> 
	</div>
	
	<div class="contents mt60">
        <div class="inner">
        	<form action="<%=request.getContextPath() %>/mate/noticeInsert.do" method="post">
        		<input type="hidden" name="cbno" value="<%=mv.getClubNo() %>">
				<!-- 로그인된 회원으로 수정 필요 -->
				<input type="hidden" name="mno" value="1">
				
            	<div class="f_wrap">
	                <div class="f_box f_box2">
	                    <strong>제목 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="title" name="title" class="f_input" placeholder="제목을 입력해주세요." required>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>내용 *</strong>
	                    <textarea id="content" name="content" placeholder="내용을 입력해주세요." required></textarea>
	                </div>
	            </div>
	
	            <!-- 버튼 영역 -->
	            <div class="btn_area">
				    <div class="btn">
			            <button type="button" onclick="cancelRegistration();">취소</button>
			            <button type="submit">저장</button>
				    </div>
				</div>
			</form>
        </div>
    </div>
	
</section>
<!-- // Content -->

<script>
	function cancelRegistration() {
	    if (confirm("등록을 취소하시겠습니까?")) {
	        alert("등록이 취소되었습니다.");
	        history.back();
	    }
	}

	function validateForm() {
	    var title = document.getElementById("title").value;
	    var content = document.getElementById("content").value;

	    if (title.trim() === "" || content.trim() === "") {
	        alert("제목과 내용은 필수 항목입니다.");
	        return false;
	    }

	    alert("등록이 완료되었습니다.");
	    return true;
	}
</script>



<%@include file="/views/inclue/bottom.jsp" %>