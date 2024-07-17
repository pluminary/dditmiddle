<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>



<!-- Content -->
<section id="con_mateList" class="conBody">

    <div id="" class="tit_wrap">
        <h2>짐짝과 함께<br>운동 메이트를 만들어보세요!</h2>
    </div>

    <div class="contents">
        <div class="inner">
        	<form action="/GymMate/member/regist.do" method="POST" id="regist">
	            <div class="f_wrap join">
	                <div class="f_box">
	                    <strong>아이디 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="memId" name="memId" class="f_input" placeholder="아이디를 입력해주세요.">
	                        <button type="button" class="confirm" id="idCheck"><i class="ri-check-line"></i></button>
	                        <div id="idCkResult" class="msg ok"></div>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>이름 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" maxlength="12" name="memName" class="f_input" placeholder="이름을 입력해주세요.">
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>비밀번호 *</strong>
	                    <div class="s_wrap">
	                        <input type="password" maxlength="20" name="memPw" class="f_input" placeholder="비밀번호를 입력해주세요.">
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>비밀번호 확인 *</strong>
	                    <div class="s_wrap">
	                        <input type="password" maxlength="20" name="memPw2" class="f_input" placeholder="비밀번호를 다시 입력해주세요." required>
	                        <div id="pwError" class="msg ok"></div>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>닉네임 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" maxlength="12" id="memNick" name="memNick" class="f_input" placeholder="닉네임을 입력해주세요.">
	                        <button type="button" class="confirm" id="nickCheck"><i class="ri-check-line"></i></button>
	                        <div id="nkCkResult" class="msg ok"></div>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>생년월일</strong>
	                    <div class="s_wrap">
	                        <input type="date" name="memBirth" class="f_input">
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>휴대폰 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" name="memPhone" class="f_input" placeholder="010-0000-0000">
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
	            <div class="checkbox_wrap">
	                <input class="" type="checkbox" name="" value="" checked="checked">
	                <span class="">GYM짝 
	                    <a href="javascript:void(0)" onclick="showPop('terms')">서비스 이용약관</a>과 
	                    <a href="javascript:void(0)" onclick="showPop('privacy')">개인정보 처리방침</a>개인정보 수집 및 이용</a>
	                    에 동의합니다
	                </span>
	            </div>
	
	            <div class="btn mt60">
	            	<input type="submit" value="가입하기" class="inputBtn">
	            </div>
	        </form>
        </div>
    </div>
</section>
<!-- // Content -->













<script type="text/javascript">
   
	$(document).ready(function() {
	// 중복 확인 버튼 클릭 이벤트 처리
	$('#idCheck').click(function(event) {
		event.preventDefault(); // 버튼 클릭 기본 동작 방지
		var formData = $('#regist').serialize(); // 폼 데이터 직렬화
		console.log(formData);
	
		// 아이디를 입력하지 않은 경우
		if($('#memId').val().length == 0) {
			alert("아이디를 입력하세요");
			return;
		}
		
		// AJAX를 이용해 서버에 데이터 전송
		$.ajax({
			type : 'POST',
			url :"/GymMate/member/checkid.do", // 폼의 action 속성 값
			data : formData,
			dataType : "json",
			success : function(response) {
				console.log('idCheckResult', response.idCheckResult);
			
			    if (response.idCheckResult === "fail") {
			        $('#idCkResult').removeClass('ok'); // 'ok' 클래스 제거
			        $('#idCkResult').addClass('error'); // 'error' 클래스 추가
			        $('#idCkResult').html('중복된 아이디 입니다'); // 메시지 업데이트
			    } else {
			        $('#idCkResult').removeClass('error'); // 'error' 클래스 제거
			        $('#idCkResult').addClass('ok'); // 'ok' 클래스 추가
			        $('#idCkResult').html('사용 가능한 아이디 입니다'); // 메시지 업데이트
			    }
			},
		});
	});
	
	// 닉네임 중복 확인 버튼 클릭 이벤트 처리
    $('#nickCheck').click(function(event) {
        event.preventDefault(); // 버튼 클릭 기본 동작 방지
        var memNick = $('#memNick').val(); // 폼 데이터 직렬화

        // 닉네임을 입력하지 않은 경우
        if($('#memNick').val().length == 0) {
            alert("닉네임을 입력하세요");
            return;
        }
        
        // AJAX를 이용해 서버에 닉네임 중복 확인 요청
        $.ajax({
            type : 'POST',
            url :"/GymMate/member/checknick.do",
            data : {"memNick" : memNick},	// 닉네임만 전송
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
		});
	});
	
 	// 이메일 중복 확인 버튼 클릭 이벤트 처리
    $('#emailCheck').click(function(event) {
        event.preventDefault(); // 버튼 클릭 기본 동작 방지
        var memEmail = $('#memEmail').val(); // 첫 번째 이메일 입력란 값 가져오기
        var memEmail2 = $('#memEmail2').val(); // 두 번째 이메일 입력란 값 가져오기
        
        // 이메일을 입력하지 않은 경우
        if (memEmail.length == 0 || memEmail2.length == 0) {
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
            
        // AJAX를 이용해 서버에 닉네임 중복 확인 요청
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
    
    // 비밀번호 일치 여부 체크
    $("input[name='memPw'], input[name='memPw2']").on('keyup', function () {
        var pw = $("input[name='memPw']").val();
        var pw2 = $("input[name='memPw2']").val();

        if (pw != pw2) {
            $("#pwError").text("비밀번호가 일치하지 않습니다.");
        } else {
            $("#pwError").text(""); // 일치할 경우 메시지 제거
        }
    });
});
</script>

<%@include file="/views/inclue/bottom.jsp" %>