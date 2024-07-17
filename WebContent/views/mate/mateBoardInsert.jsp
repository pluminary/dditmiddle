<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/views/inclue/top.jsp" %>

<%
	MateVO mv = (MateVO)request.getAttribute("mateVO");
%>

<!-- Content -->
<section id="con_board" class="conBody tab">
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
	    <h2>게시글 등록</h2>
	    <p>자유로운 이야기와 소식들을 작성해주세요.</p> 
	</div>
	
	<div class="contents mt60">
        <div class="inner">
        	<form action="<%=request.getContextPath() %>/mate/boardInsert.do?clubNo=<%=mv.getClubNo() %>" method="post" enctype="multipart/form-data">
				
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
	                <div class="f_box f_box2">
	                    <strong>첨부파일</strong>
	                    <div class="file_input">
		                    <input type="file" id="atchFile" name="atchFile" multiple="multiple">
							<div id="selectedFiles"></div>
	                    </div>
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



<script>
$(document).ready(function() {
    $('#atchFile').change(function(event) {
        let fileList = event.target.files;	// 첨푸파일들을 담을 리스트 선언
        let sDiv = $('#selectedFiles');

        if(fileList.length > 1) {	// 파일이 한 개일 땐 선택된 파일이름이 잘 나타나므로 1보다 클 때로 설정함
            for(let i = 0; i < fileList.length; i++) {
                let fileName = fileList[i].name;
                let fDiv = document.createElement('div');
                fDiv.textContent = i+1 + '. ' + fileName;
                sDiv.append(fDiv);
            }
        } else {
            sDiv.text('');
        }
    });
});
</script>

<%@include file="/views/inclue/bottom.jsp" %>
