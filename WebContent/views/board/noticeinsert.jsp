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
	    <h2>공지사항 등록</h2>
	    <p>짐짝의 중요한 소식들을 작성해 주세요.</p>
	</div>
	
	<div class="contents">
        <div class="inner">
        	<form action="${pageContext.request.contextPath}/noticeboard/insert.do" method="POST" onsubmit="return validateForm();">
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