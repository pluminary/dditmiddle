<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@page import="kr.or.ddit.place.vo.AthlVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.place.service.PlaceServiceImpl"%>
<%@page import="kr.or.ddit.place.service.IPlaceService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/views/inclue/top.jsp" %>


<%
	IPlaceService placeService = PlaceServiceImpl.getInstance();
	List<AthlVO> athlList = placeService.getAthl();
	
	MateVO mv = (MateVO)request.getAttribute("mv");
%>

<!-- Content -->
<section id="con_mateList" class="conBody">

    <div id="" class="tit_wrap">
        <h2>동호회 수정</h2>
        <p>동호회 정보를 수정해보세요!<br>필수 정보는 꼭 입력해주세요.</p>
    </div>

    <div class="contents">
        <div class="inner">
        	<form name="updateForm" action="<%=request.getContextPath() %>/mate/update.do" method="POST">
	            <div class="f_wrap">
	                <div class="f_box">
	                    <strong>동호회명 *</strong>
	                    <div class="s_wrap readonly">
	                        <input type="text" id="clubName" name="clubName" class="f_input readonly" value="<%=mv.getClubName()%>" disabled >
        					<input type="hidden" name="clubNo" value="<%=mv.getClubNo()%>">	
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>종목 *</strong>
	                    <div class="s_wrap readonly">
	                        <input type="text" id="athlName" name="athlName" class="f_input readonly" value="<%=mv.getAthlName()%>" disabled >
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>활동지역 *</strong>
	                    <div class="s_wrap">
	                        <select name="clubFarea">
					            <option value="">선택하세요</option>
					        <%
					            String[] guList = { "중구", "동구", "대덕구", "유성구", "서구" };
					        	for(String gu : guList){
					        		if(mv.getClubFarea() != null && mv.getClubFarea().equals(gu)){
					        %>
					        	<option selected><%=gu %></option>
					        <%			
					        		}else{
					        %>
					        	<option><%=gu %></option>
					        <%			
					        		}
					        	}
					        %>
					        </select>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>연령대 *</strong>
	                    <div class="s_wrap">
	                        <select name="clubAge" title="연령대">
	                            <%
						            String[] ageList = { "10대", "20대", "30대", "40대", "50대", "60대 이상" };
						        	for(String age : ageList){
						        		if(mv.getClubAge() != null && mv.getClubAge().equals(age)){
						        %>
						        	<option selected><%=age %></option>
						        <%			
						        		}else{
						        %>
						        	<option><%=age %></option>
						        <%			
						        		}
						        	}
						        %>
	                        </select>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>주활동시간 *</strong>
	                    <div class="s_wrap">
	                        <select name="clubFtzone" title="주활동시간">
	                             <%
					            String[] timeList = { "평일 오전", "평일 오후", "평일 저녁", "주말 오전", "주말 오후", "주말 저녁" };
					        	for(String time : timeList){
					        		if(mv.getClubFtzone() != null && mv.getClubFtzone().equals(time)){
					        %>
					        	<option selected><%=time %></option>
					        <%			
					        		}else{
					        %>
					        	<option><%=time %></option>
					        <%			
					        		}
					        	}
					        %>
	                        </select>
	                    </div>
	                </div>
	                <div class="f_box">
	                    <strong>모집인원 *</strong>
	                    <div class="s_wrap">
	                        <input type="number" id="clubTotalmem" name="clubTotalmem" min="1" max="100" class="f_input" value="<%=mv.getClubTotalmem()%>">
	                    </div>
	                </div>
	                <div class="f_box f_box2">
	                    <strong>비고</strong>
	                    <textarea id="clubMemo" name="clubMemo"><%= mv.getClubMemo() == null ? "" : mv.getClubMemo() %></textarea>
	                </div>
	            </div>
	
	            <div class="btn">
	                <button type="button" onclick="history.back();">취소</button>
    				<button type="submit">저장</button>
	            </div>
            </form>
        </div>
    </div>
</section>
<!-- // Content -->





<script type="text/javascript">
    // 저장 버튼 클릭 시 저장 여부 다이얼로그 표시
    document.querySelector('form').addEventListener('submit', function(event) {
        var confirmed = confirm('정말 저장하시겠습니까?');
        
        if (!confirmed) {
            event.preventDefault(); // 기본 동작(폼 제출) 막음
        }
    });
</script>
<%@include file="/views/inclue/bottom.jsp" %>