<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%@include file="/views/inclue/top.jsp" %>


<!-- Content -->
<section id="con_board" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
	    <ul>
	        <li><a href="/GymMate/member/mypage.do">마이 메이트</a></li>
	        <li><a href="<%=request.getContextPath()%>/member/info.do">회원정보</a></li>
	        <li><a href="<%=request.getContextPath()%>/member/like.do">찜관리</a></li>
	        <li class="on"><a href="<%=request.getContextPath()%>/member/askList.do">1:1 문의</a></li>
	    </ul>
	</div>
	
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
	    <h2>1:1문의 등록</h2>
	    <p>문의하실 내용을 작성해 주세요.</p>
	</div>
	
	<div class="contents">
        <div class="inner">
        	<form action="${pageContext.request.contextPath}/member/askinsert.do" method="POST">
            	<div class="f_wrap">
	                <div class="f_box f_box2">
	                    <strong>제목 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="title" name="title" class="f_input" placeholder="제목을 입력해주세요." required>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>문의유형 *</strong>
	                    <div class="s_wrap">
	                        <select id="cars" name="cars">
								<option value="일반문의">일반문의</option>
								<option value="시설등록">시설등록</option>
							</select>
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
			            <button type="button" onclick="history.back()">취소</button>
			            <button type="submit">저장</button>
				    </div>
				</div>
			</form>
        </div>
    </div>
	
</section>
<!-- // Content -->



<%@include file="/views/inclue/bottom.jsp" %>