<%@page import="kr.or.ddit.member.vo.adminVO"%>
<%@page import="kr.or.ddit.place.vo.MedicalVO"%>
<%@page import="kr.or.ddit.place.vo.PlaceVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	PlaceVO place = (PlaceVO)request.getAttribute("detail");	
	MedicalVO medic = (MedicalVO)request.getAttribute("medicInfo");
%>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>



<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.0/kakao.min.js"
  integrity="sha384-l+xbElFSnPZ2rOaPrU//2FF5B4LB8FiX5q4fXYTlfcG4PGpMkE1vcL7kNXI6Cci0" crossorigin="anonymous">
</script>
<script>
  Kakao.init('a7f355d8df9c339c086f782a9af81c94'); // 사용하려는 앱의 JavaScript 키 입력
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a7f355d8df9c339c086f782a9af81c94&libraries=services"></script>


<!-- Content -->
<section id="con_placeDetail" class="conBody">
    <!-- Content Title -->
    <div id="" class="tit_wrap place_detail">
        <h2><%=place.getFcName() %></h2>
        <p><%=place.getCode() %> · 중구</p>
        <div>
            <button id="kakaotalk-sharing-btn" class="copy">카카오톡 공유하기</button>
        </div>
    </div>
    <div class="contents mt60">
    
        <div class="map_area">
            <div class="map_info">
                <strong class="tit"><%=place.getFcName() %>​</strong>
                <ul>
                    <li>
                        <span><em class="icon icon01"></em>주소</span><%=place.getFcAddr() %>
                    </li>
                    <li>
                        <span><em class="icon icon02"></em>연락처</span><%=place.getFcTell() %>
                    </li>
                </ul>
                <div class="link">
                    <a href="" id="findWayLink" class="" target="_blank"><i class="ri-navigation-fill" style="padding-right:10px;"></i>길찾기</a>
                </div>
            </div>
        </div>
        
        <div id="map" class="detailPlaceMap_wrap"></div>
        
        <div class="inner">
            <div class="v_con">

                <div class="ui vlist__bodo type1">
                    <div class="obj col1">
                        <div class="item aos-init aos-animate">
                            <div class="inner">
                                <div class="title_box">
                                    <span class="ir ir-icon__line icon1"></span>
                                    <strong>부가 정보</strong>
                                </div>
                                <div class="ui-bodo__summary">
                                    <div class="text_box">
                                        <div class="list-1st">
                                            <div><pre><%=place.getFcInfo() == null ? "정보없음" : place.getFcInfo()  %></pre>​</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item aos-init aos-animate">
                            <div class="inner">
                                <div class="title_box">
                                    <span class="ir ir-icon__line icon2"></span>
                                    <strong>인근 의료 시설</strong>
                                </div>
                                <div class="ui-bodo__summary">
                                    <div class="text_box">
                                        <div class="list-1st">
                                            <div>
                                                <p><%=medic.getMedicfcName() %><a href="<%=medic.getMedicfcURL() %>" class="findgogo" target="_blank"><i class="ri-home-4-fill"></i> 홈페이지</a><a href="" id="findhosLink" class="findgogo" target="_blank"><i class="ri-navigation-fill"></i> 길찾기</a></p>
                                                <p><%=medic.getMedicfcAddr() %></p>
                                                <p><%=medic.getMedicfcTell() %></p>
                                            ​</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>




            </div>
            <div class="btn">
                <button type="button" id="listButton" onclick="history.back()">목록</button>
                <%
					adminVO admin = (adminVO)request.getSession().getAttribute("admin");
					if(admin != null){ 
				%>
                <a href="javascript:void(0)" id="updateButton">수정</a>
                <a href="javascript:void(0)" id="deleteButton">삭제</a>
                <%
					}
			    %>
            </div>
        </div>
    </div>
    
</section>
<!-- // Content -->


 
<script type="text/javascript">
    var fcNo = '<%=place.getFcNo()%>';
    var fcName = '<%=place.getFcName()%>'
    // 수정 버튼 클릭 시 수정 페이지로 이동
    document.getElementById('updateButton').addEventListener('click', function() {
        // 수정 페이지의 URL을 여기에 입력하세요.
        var updatePageURL = "<%=request.getContextPath()%>/place/updateplace.do?fcNo="+fcNo;
        window.location.href = updatePageURL;
    });
    // 삭제 버튼 클릭 시 수정 페이지로 이동
    document.getElementById('deleteButton').addEventListener('click', function() {
        // 삭제 페이지의 URL을 여기에 입력하세요.
        var deletePageURL = "<%=request.getContextPath()%>/place/deleteplace.do?fcNo="+fcNo;
        var confirmed = confirm('정말 삭제하시겠습니까?');
        if(confirmed){
        	alert(fcName+'의 삭제가 완료되었습니다.');
	        window.location.href = deletePageURL;
        }
    });
</script>

<script type="text/javascript">
var container = document.getElementById('map');
var options = {
    center: new kakao.maps.LatLng(36.35048468616169, 127.38487914140921 - 0.001), // 경도에서 약간 값을 빼줌
    level: 3
};
var map = new kakao.maps.Map(container, options);
var geocoder = new kakao.maps.services.Geocoder();
var fcurl = "https://map.kakao.com/link/to/<%=place.getFcName() %>";
geocoder.addressSearch('<%=place.getFcAddr() %>', function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        fcurl += ',' + result[0].y + "," + result[0].x;
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        // 지도 중심을 마커 위치에서 약간 왼쪽으로 이동하여 마커가 오른쪽에 위치하도록 함
        map.setCenter(new kakao.maps.LatLng(result[0].y, result[0].x - 0.002));
        document.getElementById('findWayLink').href = fcurl; // 길찾기 링크 업데이트
    }
});
</script>

<script type="text/javascript">
//길찾기를 위한 주소-좌표 변환 객체
var geocoder = new kakao.maps.services.Geocoder();
var medicurl = "https://map.kakao.com/link/to/<%=medic.getMedicfcName() %>";

// 주소로 좌표를 검색
geocoder.addressSearch('<%=medic.getMedicfcAddr() %>', function(result, status) {
    // 정상적으로 검색이 완료되었을 경우
    if (status === kakao.maps.services.Status.OK) {
        medicurl += ',' + result[0].y + ',' + result[0].x;
        
        // 병원 길찾기 링크의 href 속성 업데이트
        document.getElementById('findhosLink').href = medicurl;
    }
});

Kakao.Share.createDefaultButton({
container: '#kakaotalk-sharing-btn',
objectType: 'text',
text:
 '<%=place.getFcName()%>의 정보를 공유합니다',
link: {
 mobileWebUrl: location.href,
 webUrl: location.href,
},
});
</script>
<%@include file="/views/inclue/bottom.jsp" %>