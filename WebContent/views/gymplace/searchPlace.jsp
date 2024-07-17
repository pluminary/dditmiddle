<%@page import="kr.or.ddit.member.vo.adminVO"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="kr.or.ddit.place.vo.PlaceVO"%>
<%@page import="kr.or.ddit.place.vo.AthlVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>
    
<%
	Integer cnt = (Integer)request.getAttribute("cnt");
	List<AthlVO> athlList = (List<AthlVO>)request.getAttribute("athlList");
	List<PlaceVO> placeList = (List<PlaceVO>)request.getAttribute("placeList");
	PageVO pgv = (PageVO)request.getAttribute("pg");
	PlaceVO search = (PlaceVO)request.getAttribute("search");
	String sortParam = "&code=" + search.getCode() + "&gu=" + search.getGu() + "&fcName=" + search.getFcName();
%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a7f355d8df9c339c086f782a9af81c94&libraries=services"></script>
<style>
.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
.wrap * {padding: 0;margin: 0;}
.wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
.wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
.info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
.info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
.info .close:hover {cursor: pointer;}
.info .body {position: relative;overflow: hidden;}
.info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
.desc .addr {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
.desc .tell {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
.info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.info .link {color: #5085BB;}
#listArea table td:nth-of-type(1){display: none;}
</style>

<!-- Content -->
<section id="con_main">

	<!-- 검색 영역 -->
	<div id="" class="placeSearch_wrap">
	    <div class="search main">
	    	<form method="get" action="<%=request.getContextPath() %>/place/searchGymList.do" class="flex">
		        <select name="code" title="종목">
		            <option>종목</option>
	<% 
			for(AthlVO av : athlList){
				// 만약 파라미터로 날아온 값이 값과 같으면  selected 아니면 아래코드
				if(search.getCode().equals(av.getAthlName())){
	%> 
				<option selected><%=av.getAthlName() %></option>
	<%
				}else{
	%>
				<option><%=av.getAthlName() %></option>
	<%			
				}
			}
	%>
		        </select>
		        <span class="line"></span>
		        <select name="gu" title="자치구">
		            <option>자치구</option>
	<%
				String[] guList = { "중구", "동구", "대덕구", "유성구", "서구" };
				for (String gu : guList) {
					// 만약 파라미터로 날아온 값이 값과 같으면 selected 아니면 아래코드
					if (search.getGu() != null && search.getGu().equals(gu)) {
	%>
				<option selected><%=gu%></option>
	<%
					} else {
	%>
				<option><%=gu%></option>
	<%
					}
				}
	%>
		        </select>
		        <span class="line"></span>
		        <input type="text" name="fcName" class="se_in" placeholder="시설명을 입력하세요" value="<%= (search.getFcName() != null) ? search.getFcName() : "" %>">
		        <button type="submit">검색</button>
	        </form>
	    </div>
	    <div class="reset_btn">
	    	<form action="<%=request.getContextPath()%>/place/searchGymList.do" method="get">
		        <button type="submit">검색조건 초기화</button>
		    </form>
	    </div>
	</div>


	<%
		if(placeList != null){
	%>
	<!-- 지도영역 -->  
	<div id="map" class="placeMap_wrap"></div>

	<!-- 리스트 영역 -->
    <div id="" class="placeList_wrap list_form">  <!-- 가릴때 hide 추가-->
        <div class="list_area">
            
            <div class="l_top">
                <strong>총 <b><%=cnt %></b>건</strong>	
            </div>

            <!-- 테이블 -->
            <table class="b_list">
                <colgroup>
                    <col width="10%" />
                    <col width="30%" />
                    <col width="15%" />
                    <col width="15%" />
                    <col width="30%" />
                </colgroup>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>시설명</th>
                        <th>종목</th>
                        <th>자치구</th>
                        <th>연락처</th>
                    </tr>
                </thead>
                <tbody>
	        <%
	        		for(PlaceVO pvo : placeList){
			%>
                    <tr onclick="location.href='<%=request.getContextPath() %>/place/detailPlace.do?fcNo=<%=pvo.getFcNo() %>'">
                        <td class="hide"><%=pvo.getFcNo() %></td>
						<td><%=pvo.getRnum() %></td>
						<td class="ti"><%=pvo.getFcName() %></td>
						<td><%=pvo.getCode() %></td>
						<td><%=pvo.getGu() %></td>
						<td><%=pvo.getFcTell() %></td>
                    </tr>
			<%
				}
			%>
                </tbody>
            </table>

 			<!-- 페이지 -->
            <div class="page">
			    <ul>
			        <% if(pgv != null) {
			            // 이전 페이지로 이동하는 링크
			            if(pgv.getPageNo() > 1) { %>
			                <li class="prev">
			                    <a href="searchGymList.do?pageNo=<%= pgv.getPageNo() - 1 %><%= sortParam %>">Prev</a>
			                </li>
			            <% }
			
			            // 페이지 번호 링크
			            for(int i=pgv.getStartPage(); i<=pgv.getEndPage(); i++) { %>
			                <li class="num <%= pgv.getPageNo() == i ? "on" : "" %>">
			                    <a href="searchGymList.do?pageNo=<%= i %><%= sortParam %>"><%= i %></a>
			                </li>
			            <% }
			
			            // 다음 페이지로 이동하는 링크
			            if(pgv.getPageNo() < pgv.getTotalPage()) { %>
			                <li class="next">
			                    <a href="searchGymList.do?pageNo=<%= pgv.getPageNo() + 1 %><%= sortParam %>">Next</a>
			                </li>
			            <% } 
			        } %>
			    </ul>
			</div>
			<%
				}else{
			%>
				<!-- 검색결과 없음 -->
	            <div id="" class="alert_wrap block"> <!-- 보여질때 block 추가-->
	                <div class="alert_area">
	                    <div id="" class="tit_wrap">
	                        <h3>검색 결과가 없습니다</h3>
	                        <p>정확한 검색어인지 확인하시고 다시 검색해주세요</p>
	                    </div>
	                    
	                    <form action="<%=request.getContextPath()%>/place/gymlist.do" method="get">
					        <button type="submit">검색조건 초기화</button>
<!-- 	                    <div class="btn"> -->
<!-- 	                        <a href="">초기화</a> -->
<!-- 	                    </div> -->
					    </form>
	                </div>
	            </div>
			<%
				}
			%>	
		<%
			adminVO admin = (adminVO)request.getSession().getAttribute("admin");
			if(admin != null){ 
		%>
            <!-- 버튼 영역 -->
            <div class="btn_area">
                <div class="btn">
                    <a href="">등록</a>
                </div>
            </div>
        <%
			}
    	%>
        </div>
    </div>
</section>
<!-- // Content -->



<script>
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(36.35048468616169, 127.38487914140921),
		level: 8
	};
	
	var map = new kakao.maps.Map(container, options);
	var marker;
	// 주소를 좌표로 바꾸기 위함
	var geocoder = new kakao.maps.services.Geocoder();
	<% for(PlaceVO pvo : placeList) { %>
    geocoder.addressSearch('<%=pvo.getFcAddr() %>', function(result, status) {
        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 좌표값

            marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            /* 커스텀 오버레이 정보 */
            var content = document.createElement('div'); // 컨테이너 div
            content.className = 'map_tip';

            // 오버레이 내용 작성
            var innerHTML = '<div class="map_tip_wrap">' + 
                            '   <div class="map_tip_info">' + 
                            '       <div class="map_tip_info_title">' + '<%=pvo.getFcName() %>' + '</div>' + 
                            '       <div class="map_tip_body">' + 
                            '           <div class="map_tip_desc">' + 
                            '               <div class="addr"><%=pvo.getFcAddr() %></div>' + 
                            '               <div class="tell"><%=pvo.getFcTell() %></div>' + 
                            '               <div class="tell"><%=pvo.getCode() %></div>' + 
                            '               <div class="map_detail_btn"><a href="<%=request.getContextPath() %>/place/detailPlace.do?fcNo=<%=pvo.getFcNo() %>" target="_self" class="link">상세보기 <i class="ri-arrow-right-double-line"></i></a></div>' + 
                            '           </div>' + 
                            '       </div>' + 
                            '   </div>' +    
                            '</div>';

            content.innerHTML = innerHTML;

            // 닫기 버튼 생성 및 이벤트 추가
            var closeBtn = document.createElement('button');
            closeBtn.textContent = '닫기';
            closeBtn.className = 'close_btn'; // 닫기 버튼에 클래스 추가 (스타일 지정용)
            closeBtn.onclick = function() {
                overlay.setMap(null);
            };

            // 닫기 버튼을 map_tip_wrap 내부에 추가
            content.querySelector('.map_tip_wrap').appendChild(closeBtn);

            var overlay = new kakao.maps.CustomOverlay({
                content: content,
                position: marker.getPosition()       
            });

            // 마커 클릭 시 오버레이 표시
            kakao.maps.event.addListener(marker, 'click', function() {
                overlay.setMap(map);
            });
        } // if문 종료
    });
<% } %>
	
		
	
</script>

<%@include file="/views/inclue/bottom.jsp" %>