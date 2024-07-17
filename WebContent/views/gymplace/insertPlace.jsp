<%@page import="kr.or.ddit.place.vo.AthlVO"%>
<%@page import="kr.or.ddit.place.vo.MedicalVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.place.service.PlaceServiceImpl"%>
<%@page import="kr.or.ddit.place.service.IPlaceService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>


<%
	IPlaceService service = PlaceServiceImpl.getInstance();
	List<MedicalVO> medic = service.getAllMedic();
	List<AthlVO> athl = service.getAthl();
%>

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
            	<form action="${pageContext.request.contextPath}/place/insert.do" method="POST" class="flex">
	                <div class="f_box">
	                    <strong>시설명 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="fcName" name="fcName" class="f_input" placeholder="이름을 입력해주세요" required>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>종목 *</strong>
	                    <div class="s_wrap">
	                        <select name="code" title="종목">
	                            <%  for(AthlVO av : athl){  %>
			                    	<option value="<%=av.getAthlId()%>"><%=av.getAthlName() %>
			                    <%	 } %>
	                        </select>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>주소 *</strong>
	                    <div class="s_wrap">
	                        <input type="text" id="fcAddr" name="fcAddr" class="f_input" placeholder="주소를 입력해주세요." required>
	                    </div>
	                </div>
	                <div class="f_box mrY">
	                    <strong>전화번호 *</strong>
	                    <div class="s_wrap">
	                        <input type="tel" id="fcTel" name="fcTel" class="f_input" placeholder="전화번호를 입력해주세요." required>
	                    </div>
	                </div>
	                <div class="f_box mrN">
	                    <strong>인근 의료시설 *</strong>
	                    <div class="s_wrap">
	                        <select name="medicFc" title="인근 의료시설">
	                            <%  for(MedicalVO mv : medic){  %>
			                    	<option value="<%=mv.getMedicfcNo()%>"><%=mv.getMedicfcName() %>
			                    <%	 } %>
	                        </select>
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>부가정보</strong>
	                    <textarea id="fcInfo" name="fcInfo" placeholder="부가정보를 입력해주세요."></textarea>
	                </div>
	            <div class="btn">
	                <button type="button" onclick="history.back();">취소</button>
	       			<button type="submit" id="insertButton">저장</button>
	            </div>
	            </form>
            </div>

        </div>
    </div>
<script type="text/javascript">
	$('#insertButton').on('click', function(){
		var fcName = $('#fcName').val();
		var confirmed = confirm('등록하시겠습니까?');
		if(confirmed){
			alert(fcName+'의 등록이 완료되었습니다');
		}
	});
</script>   
</section>

<%@include file="/views/inclue/bottom.jsp" %>
