<%@page import="kr.or.ddit.mate.vo.MateNoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@include file="/views/inclue/top.jsp" %>

<%
	MateNoticeVO mv = (MateNoticeVO)request.getAttribute("mv");
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
        	<form action="<%=request.getContextPath() %>/mate/noticeupdate.do" method="post">
				<input type="hidden" name="no" value="<%=mv.getCnoticeNo() %>">
				<input type="hidden" name="clubNo" value="<%=mv.getClubNo() %>">
				
            	<div class="f_wrap">
	                <div class="f_box f_box2">
	                    <strong>제목 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="title" name="title" class="f_input" value="<%=mv.getCnoticeTitle() %>" required>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>내용 *</strong>
	                    <textarea id="content" name="content" required><%=mv.getCnoticeContent() %></textarea>
	                </div>
	            </div>
	
	            <!-- 버튼 영역 -->
	            <div class="btn_area">
				    <div class="btn">
			            <button type="button" onclick="history.back();">취소</button>
   						<button type="submit">수정</button>
				    </div>
				</div>
			</form>
        </div>
    </div>
	
</section>
<!-- // Content -->


<%@include file="/views/inclue/bottom.jsp" %>