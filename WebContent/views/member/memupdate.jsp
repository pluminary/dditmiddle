<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="kr.or.ddit.member.vo.MemberVO" %>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>


<!-- Content -->
<section id="con_mateList" class="conBody">

    <div id="" class="tit_wrap">
        <h2>회원 정보 수정</h2>
    </div>

    <div class="contents">
        <div class="inner">
        	<form action="${pageContext.request.contextPath}/member/update.do" method="post">
	            <div class="f_wrap join">
	                <div class="f_box">
	                    <strong>아이디 *</strong>
	                    <div class="s_wrap readonly">
	                        <input type="text" id="memId" name="memId" class="f_input readonly" value="${user.memId}" readonly>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>이름 *</strong>
	                    <div class="s_wrap readonly">
	                        <input type="text" maxlength="12" name="memName" class="f_input readonly" value="${user.memName}" readonly>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>닉네임 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" maxlength="12" id="memNick" name="memNick" class="f_input" value="${user.memNick}">
	                        <button type="button" class="confirm" id="nickCheck"><i class="ri-check-line"></i></button>
	                        <div id="nkCkResult" class="msg ok"></div>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>생년월일</strong>
	                    <div class="s_wrap readonly">
	                        <input type="date" name="memBirth" class="f_input readonly" value="${user.memBirth}" readonly>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>휴대폰 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" name="memPhone" class="f_input" value="${user.memPhone}">
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>등급 *</strong>
	                    <div class="s_wrap">
	                        <select name="levelNo">
								<option value="1">브론즈</option>
								<option value="2">실버</option>
								<option value="3">골드</option>
								<option value="4">챌린저</option>
							</select>
	                    </div>
	                </div>
	                <div class="f_box f_box2 emilform">
	                    <strong>이메일 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" name="memEmail" id="memEmail" class="f_input" placeholder="이메일" style="width: 45%;">
	                        <span class="at">@</span>
	                        <input type="text" name="memEmail2" id="memEmail2" class="f_input" placeholder="도메인주소" style="width: 45%;">
	                        <button type="button" class="confirm" id="emailCheck"><i class="ri-check-line"></i></button>
	                        <div id="eCkResult" class="msg ok"></div>
	                    </div>
	                </div>
	            </div>
	            
	            <div class="btn mt30">
                	<a href="${pageContext.request.contextPath}/member/delete.do"><input type="button" value="회원 탈퇴" id="delButton" class="inputBtn"></a>
	            	<button type="button" onclick="history.back()">취소</button>
	            	<input type="submit" value="저장" class="inputBtn">
	            </div>
	        </form>
        </div>
    </div>
</section>
<!-- // Content -->




<script type="text/javascript">
   
$(document).ready(function() {
	// 회원 정보 수정 폼 제출 시
    $('form').submit(function(event) {
        var memNick = $('#memNick').val(); // 닉네임 입력란 값 가져오기

        // 닉네임이 비어있는지 확인
        if (memNick.trim() === '') {
            alert("닉네임을 입력해주세요.");
            event.preventDefault(); // 폼 제출 취소
        }
    });
	
    // 닉네임 중복 확인 버튼 클릭 이벤트 처리
    $('#nickCheck').click(function(event) {
    	event.preventDefault(); // 버튼 클릭 기본 동작 방지
        var memNick = $('#memNick').val(); // 닉네임 입력란 값 가져오기

        // 닉네임이 비어있는지 확인
        if (memNick.trim() === '') {
            alert("닉네임을 입력해주세요.");
            return;
        }
        
        // AJAX를 이용해 서버에 닉네임 중복 확인 요청
        $.ajax({
            type : 'POST',
            url :"${pageContext.request.contextPath}/member/checknick.do", // 서블릿 주소
            data : {"memNick" : memNick},   // 닉네임만 전송
            dataType : "json",
            success : function(response) {
            	 console.log('nkCkResult', response.nkCkResult);
                 
 			    if (response.nkCkResult === "fail") {
 			        $('#nkCkResult').removeClass('ok'); // 'ok' 클래스 제거
 			        $('#nkCkResult').addClass('error'); // 'error' 클래스 추가
 			        $('#nkCkResult').html('중복된 닉네임 입니다'); // 메시지 업데이트
 			    } else {
 			        $('#nkCkResult').removeClass('error'); // 'error' 클래스 제거
 			        $('#nkCkResult').addClass('ok'); // 'ok' 클래스 추가
 			        $('#nkCkResult').html('사용 가능한 닉네임 입니다'); // 메시지 업데이트
 			    }
                
            },
        })
    });
    
    // 이메일 중복 확인 버튼 클릭 이벤트 처리
    $('#emailCheck').click(function(event) {
        event.preventDefault(); // 버튼 클릭 기본 동작 방지
        var memEmail = $('#memEmail').val(); // 첫 번째 이메일 입력란 값 가져오기
        var memEmail2 = $('#memEmail2').val(); // 두 번째 이메일 입력란 값 가져오기
        
        // 이메일을 입력하지 않은 경우
        if (memEmail.trim() === '' || memEmail2.trim() === '') {
            alert("이메일을 입력하세요");
            return;
        }

        // 이메일 형식 체크
        var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(memEmail + '@' + memEmail2)) {
            alert("올바른 이메일 형식이 아닙니다.");
            return;
        }

        var tEmail = memEmail + '@' + memEmail2; // 이메일 주소 조합
            
        // AJAX를 이용해 서버에 이메일 중복 확인 요청
        $.ajax({
            type : 'POST',
            url :"/GymMate/member/checkemail.do",
            data : {"tEmail" : tEmail},		// 조합된 이메일 전송
            dataType : "json",
            success : function(response) {
                console.log('eCkResult', response.eCkResult);
                    
                if (response.eCkResult === "fail") {
			        $('#eCkResult').removeClass('ok'); // 'ok' 클래스 제거
			        $('#eCkResult').addClass('error'); // 'error' 클래스 추가
			        $('#eCkResult').html('중복된 이메일 입니다'); // 메시지 업데이트
			    } else {
			        $('#eCkResult').removeClass('error'); // 'error' 클래스 제거
			        $('#eCkResult').addClass('ok'); // 'ok' 클래스 추가
			        $('#eCkResult').html('사용 가능한 이메일 입니다'); // 메시지 업데이트
			    }
                    
        	},
    	});
    });
});  
</script>

<%@include file="/views/inclue/bottom.jsp" %>
