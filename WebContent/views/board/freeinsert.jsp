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
	    <h2>자유게시판 등록</h2>
	    <p>자유로운 이야기와 소식들을 작성해주세요.</p>
	</div>
	
	<div class="contents">
        <div class="inner">
        	<!-- Action 경로는 FreeBoardInsert의 URL 매핑과 일치해야 합니다. -->
        	<form action="${pageContext.request.contextPath}/freeboard/insert.do" method="POST">
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
			            <button type="button" onclick="history.back();">취소</button>
			            <button type="submit">저장</button>
				    </div>
				</div>
			</form>
        </div>
    </div>
	
</section>
<!-- // Content -->

<%@include file="/views/inclue/bottom.jsp" %>