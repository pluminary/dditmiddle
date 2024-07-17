<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.place.vo.AthlVO" %>
<%@ page import="kr.or.ddit.place.service.PlaceServiceImpl" %>
<%@ page import="kr.or.ddit.place.service.IPlaceService" %>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>


<%
IPlaceService placeService = PlaceServiceImpl.getInstance();
List<AthlVO> athlList = placeService.getAthl();
%>
<script>
    function cancelRegistration() {
        if (confirm("등록을 취소하시겠습니까?")) {
            alert("등록이 취소되었습니다");
            window.location.href = "<%=request.getContextPath()%>/mate/list.do";
        }
    }

    function validateForm() {
        var clubName = document.forms["registrationForm"]["clubName"].value;
        var athlName = document.forms["registrationForm"]["athlName"].value;
        var clubTotalmem = document.forms["registrationForm"]["clubTotalmem"].value;

        if (clubName == "" || athlName == "" || clubTotalmem == "") {
            alert("동호회명, 종목, 모집인원은 필수 항목입니다.");
            return false;
        }

        alert("등록이 완료되었습니다.");
        return true;
    }
</script>


<!-- Content -->
<section id="con_mateList" class="conBody">

    <div id="" class="tit_wrap">
        <h2>동호회 등록</h2>
        <p>함께 즐기는 새로운 동호회를 개설해보세요!<br>필수 정보는 꼭 입력해주세요.</p>
    </div>
	
	<form name="registrationForm" action="${pageContext.request.contextPath}/mate/insert.do" method="POST" onsubmit="return validateForm()">
    <div class="contents">
        <div class="inner">
            <div class="f_wrap">
                <div class="f_box">
                    <strong>동호회명 *</strong>
                    <div class="s_wrap">
                        <input type="text" id="clubName" name="clubName" class="f_input" placeholder="동호회명을 입력해주세요.">
                    </div>
                </div>
                <div class="f_box">
                    <strong>종목 *</strong>
                    <div class="s_wrap">
                        <select name="athlNo" required>
				            <option>선택하세요</option>
				            <% for(AthlVO av : athlList){ %>
				                <option value="<%=av.getAthlId()%>"><%= av.getAthlName() %></option>
				            <% } %>
				        </select>
                    </div>
                </div>
                <div class="f_box">
                    <strong>활동지역 *</strong>
                    <div class="s_wrap">
                        <select name="clubFarea">
				            <option value="">선택하세요</option>
				            <option value="동구">동구</option>
				            <option value="대덕구">대덕구</option>
				            <option value="서구">서구</option>
				            <option value="유성구">유성구</option>
				            <option value="중구">중구</option>
				        </select>
                    </div>
                </div>
                <div class="f_box">
                    <strong>연령대 *</strong>
                    <div class="s_wrap">
                        <select name="clubAge">
				            <option value="">선택하세요</option>
				            <option value="10대">10대</option>
				            <option value="20대">20대</option>
				            <option value="30대">30대</option>
				            <option value="40대">40대</option>
				            <option value="50대">50대</option>
				            <option value="60대 이상">60대 이상</option>
				        </select>
                    </div>
                </div>
                <div class="f_box">
                    <strong>주활동시간 *</strong>
                    <div class="s_wrap">
                        <select name="clubFtzone">
				            <option value="">선택하세요</option>
				            <option value="평일 오전">평일 오전</option>
				            <option value="평일 오후">평일 오후</option>
				            <option value="평일 저녁">평일 저녁</option>
				            <option value="주말 오전">주말 오전</option>
				            <option value="주말 오후">주말 오후</option>
				            <option value="주말 저녁">주말 저녁</option>
				        </select>
                    </div>
                </div>
                <div class="f_box">
                    <strong>모집인원 *</strong>
                    <div class="s_wrap">
                        <input type="number" id="clubTotalmem" name="clubTotalmem" min="1" max="100" class="f_input" placeholder="인원">
                    </div>
                </div>
                <div class="f_box f_box2">
                    <strong>비고</strong>
                    <textarea id="clubMemo" name="clubMemo" placeholder="정보를 입력해주세요."></textarea>
                </div>
            </div>

            <div class="btn">
                <button type="button" onclick="cancelRegistration()">취소</button>
    			<button type="submit">저장</button>
            </div>
        </div>
    </div>
    </form>
</section>
<!-- // Content -->



<%@include file="/views/inclue/bottom.jsp" %>