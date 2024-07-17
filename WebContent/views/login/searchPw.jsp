<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/views/inclue/top.jsp" %>


<!-- Content -->
<section id="login" class="srch">
    <div class="s_tab s_tab2">
        <ul>
            <li><a href="<%=request.getContextPath() %>/searchId.do">아이디 찾기</a></li>
            <li class="on"><a href="<%=request.getContextPath() %>/searchPw.do">비밀번호 찾기</a></li>
        </ul>
    </div>
    <div id="" class="tit_wrap pt90">
        <h2>비밀번호 찾기</h2>
        <p>비밀번호를 잊으셨나요?<br>회원가입시 입력한 아래의 정보를 입력해주세요.</p>
    </div>
    <div class="login_wrap">

        <div id="" class="searchId_wrap">
			<form id="searchForm" action="<%=request.getContextPath() %>/searchPw.do" method="post">
	            <div class="f_box">
	                <strong>아이디 *</strong>
	                <div class="s_wrap">
	                    <input type="text" id="username" name="username" class="f_input" placeholder="아이디를 입력해주세요" required autofocus>
	                </div>
	            </div>
	            <div class="f_box">
	                <strong>전화번호 *</strong>
	                <div class="s_wrap">
	                    <input type="tel" id="phone" name="phone" class="f_input" placeholder="전화번호를 입력해주세요" required>
	                </div>
	            </div>
	            <button id="searchButton" class="btn1 wd100 mt50" type="submit">비밀번호 찾기</button>
	        </form>
        </div>
        
        
        
        <div id="" class="searchIdResult_wrap hide">
	        <!-- 검색 결과를 표시할 곳 -->
            <p id="result"></p>
            
            <div class="btn between mt50">
                <a href="<%= request.getContextPath()%>/login.do">로그인</a>
                <a href="<%=request.getContextPath() %>/searchId.do">아이디 찾기</a>
            </div>
        </div>
    </div>
</section>
<!-- // Content -->

<!-- jQuery를 사용하여 AJAX 요청을 처리하는 JavaScript 코드 -->
<script type="text/javascript">
    $(document).ready(function() {
        // 검색 버튼 클릭 이벤트 처리
        $('#searchButton').click(function(event) {
            event.preventDefault(); // 버튼 클릭 기본 동작 방지

            // 필요한 데이터 가져오기
            var username = $('#username').val().trim(); // 아이디
            var phone = $('#phone').val().trim(); // 전화번호

            // 이름과 전화번호가 모두 입력되었는지 확인
            if (!username && !phone) {
                alert('아이디와 전화번호를 모두 입력해주세요.');
                return;
            } else if (!username) {
                alert('아이디를 입력해주세요.');
                return;
            } else if (!phone) {
                alert('전화번호를 입력해주세요.');
                return;
            }

            // 전화번호 형식과 길이 확인 (010-0000-0000 형태, 최대 13글자)
            var phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
            if (!phoneRegex.test(phone) || phone.length > 13) {
                alert('전화번호 형식이 올바르지 않습니다. (예: 010-0000-0000)');
                return;
            }

            var formData = $('#searchForm').serialize(); // 폼 데이터 직렬화
            console.log(formData);

            // AJAX를 이용해 서버에 데이터 전송
            $.ajax({
                type: 'POST',
                url: $('#searchForm').attr('action'), // 폼의 action 속성 값
                data: formData,
                dataType: "json",
                success: function(response) {
                    // 결과를 표시하는 div의 hide 클래스 제거
                    $('.searchIdResult_wrap').removeClass('hide');
                    
                    // 서버로부터 받은 데이터를 result div에 표시
                    if(response.memPw !== '') {
                        // 일치하는 회원정보가 있을 경우
                        $('#result').html('회원님의 비밀번호가 <strong>메일</strong>로 발송되었습니다.');
                    } else {
                        // 일치하는 회원정보가 없을 경우
                        $('#result').html('일치하는 회원정보가 없습니다.');
                    }
                },
                error: function() {
                    // 오류 발생 시 메시지 표시
                    $('#result').html('요청 처리 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>


<%@include file="/views/inclue/bottom.jsp" %>