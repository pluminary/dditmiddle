<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %> 
    
<!-- Content Area -->
<section id="con_placeInsert" class="conBody">
    <!-- Content Title -->
    <div id="" class="tit_wrap">
        <h2>운동시설 등록</h2>
        <p>즐겁게 운동할 수 있는 시설을 알고 계신가요?<br>필수 정보는 꼭 입력해주세요!</p>
    </div>
    <div class="contents">
        <div class="inner">
            <div class="f_wrap">
            	<form id="updateForm" action="${pageContext.request.contextPath}/place/updateplace.do" method="post">
	                <div class="f_box">
	                    <strong>시설명</strong>
	                    <div class="s_wrap readonly">
	                        <!-- 시설명 입력란 (수정 불가능) -->
				            <input type="text" id="fcName" name="fcName" class="f_input" value="${place.fcName}" readonly>
				            <!-- 시설 번호 (수정 불가능, 서블릿에서 사용) -->
				            <input type="hidden" id="fcNo" name="fcNo" class="f_input" value="${place.fcNo}" readonly>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>종목</strong>
	                    <div class="s_wrap readonly">
	                        <!-- 종목 입력란 (수정 불가능) -->
            				<input type="text" id="code" name="code" class="f_input" value="${place.code}" readonly>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>주소</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="fcAddr" name="fcAddr" class="f_input" value="${place.fcAddr}">
	                    </div>
	                </div>
	                <div class="f_box mrY">
	                    <strong>전화번호</strong>
	                    <div class="s_wrap">
	                        <input type="tel" id="fcTel" name="fcTel" class="f_input" value="${place.fcTell}">
	                    </div>
	                </div>
	                <div class="f_box mrN">
	                    <strong>인근 의료시설</strong>
	                    <div class="s_wrap readonly">
	                        <!-- 인근 의료시설 입력란 (수정 불가능) -->
            				<input type="text" id="medicFcNo" name="medicFcNo" class="f_input" value="${place.medicFcNo}" readonly>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>부가정보</strong>
	                    <textarea id="fcInfo" name="fcInfo" class="f_input">${place.fcInfo}</textarea>
	                </div>
	            </form>
            </div>

            <div class="btn">
                <button type="submit" onclick="history.back();">취소</button>
            	<button type="submit" id="updateButton">저장</button>
            </div>
        </div>
    </div>
    
</section>
    
    
    
    
    <script type="text/javascript">
        // 수정 버튼 클릭 시 폼 데이터를 서블릿으로 전송
        document.getElementById('updateButton').addEventListener('click', function() {
//             var form = document.getElementById('updateForm');
//             var formData = new FormData(form);

//             // 서블릿 URL 설정
<%--             var servletURL = '<%= request.getContextPath() %>/place/updateplace.do'; --%>

//             // AJAX를 사용하여 서블릿으로 데이터 전송
//             var xhr = new XMLHttpRequest();
//             xhr.open('POST', servletURL, true);
//             xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
//             xhr.onreadystatechange = function() {
//                 if (xhr.readyState === 4 && xhr.status === 200) {
//                     // 수정 완료 후에 수행할 동작 추가
//                     alert('시설 정보가 수정되었습니다.');
//                     // 필요한 경우, 수정 후의 화면으로 이동할 수 있습니다.
//                     // window.location.href = '수정 후의 화면 URL';
//                 }
//             };
//             xhr.send(new URLSearchParams(formData));

				alert('시설 정보가 수정되었습니다.');
				$('#updateForm').submit();
        });
    </script>

    
<%@include file="/views/inclue/bottom.jsp" %>