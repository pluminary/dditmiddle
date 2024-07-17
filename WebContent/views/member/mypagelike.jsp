<%@page import="kr.or.ddit.mate.service.MateServiceImpl"%>
<%@page import="kr.or.ddit.mate.service.IMateService"%>
<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="kr.or.ddit.member.vo.MyPageVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/views/inclue/top.jsp" %>  
<%

// 로그인 여부 확인
boolean isLoggedIn = (user != null);

// 로그인된 사용자의 아이디 출력 (디버깅 용도)
String loggedInUserId = isLoggedIn ? user.getMemId() : "비로그인 상태";

IMateService service = MateServiceImpl.getInstance();
%>



<!-- Content -->
<section id="con_noticeList" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
	    <ul>
	        <li><a href="/GymMate/member/mypage.do">마이 메이트</a></li>
	        <li><a href="<%=request.getContextPath()%>/member/info.do">회원정보</a></li>
	        <li class="on"><a href="<%=request.getContextPath()%>/member/like.do">찜관리</a></li>
	        <li><a href="<%=request.getContextPath()%>/member/askList.do">1:1 문의</a></li>
	    </ul>
	</div>
	
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
	    <h2>찜관리</h2>
	    <p>내가 찜한 동호회 목록입니다.</p>
	</div>
	
	<div id="" class="list_form mt80">
	    <div class="list_area">
	    
	        <div class="l_top">
	        	<!-- 게시물 건수  -->
	            <strong>총 <b>${totalCount}</b>건</strong>
	        </div>
	        
	        <!-- 게시판 리스트 -->
	        <table class="b_list">
	            <colgroup>
	                <col width="15%" />
	                <col width="*" />
	                <col width="20%" />
	                <col width="20%" />
	            </colgroup>
	            <thead>
					<tr>
						<th>번호</th>
						<th>동호회명</th>
			            <th>종목</th>
			            <th>활동지역</th>
					</tr>
	            </thead>
	            <tbody>
	            <!-- 데이터 반복 영역 -->
		        <%
		        List<MyPageVO> boardList = (List<MyPageVO>) request.getAttribute("boardList");
		        List<MateVO> likeList = (List<MateVO>) request.getAttribute("likeList"); // MateVO 리스트 추가
		        PageVO pageVO = (PageVO) request.getAttribute("pageVO");
		        %>
		
		        <%
		        MateVO mv = null;
		        if (likeList != null && !likeList.isEmpty()) {
		            for (MateVO like : likeList) {
		            	mv = service.getMateDetail(like.getClubNo());
		        %>
	                <tr onclick="javascript:void(0)" onclick="showDetail(this)'">
	                    <td><%=like.getRnum()%></td>
		                <td class="ti">
		                	<a href="javascript:void(0)" onclick="showDetail(this)" 
					    	data-club-name="<%=mv.getClubName()%>"
					   		data-liked="<%=mv.isLiked()%>" 
					   		data-is-logged-in="<%=isLoggedIn%>"
					    	data-code="<%=mv.getAthlName()%>"
					    	data-farea="<%=mv.getClubFarea()%>"
					        data-age="<%=mv.getClubAge()%>"
					    	data-members="<%=mv.getClubCurrmem()%>/<%=mv.getClubTotalmem()%>"
					    	data-ftzone="<%=mv.getClubFtzone()%>"
					    	data-memo="<%=mv.getClubMemo()%>">
					    	<%=mv.getClubName() %>
							</a>
		                </td>
		                <div class="hidden-details" style="display: none;">
				          <span class="detail-clubname"><%= mv.getClubName() %></span>
				          <span class="detail-code"><%= mv.getAthlName() %></span>
				          <span class="detail-farea"><%= mv.getClubFarea() %></span>
				          <span class="detail-age"><%= mv.getClubAge() %></span>
				          <span class="detail-members"><%= mv.getClubCurrmem() %>/<%= mv.getClubTotalmem() %></span>
				          <span class="detail-ftzone"><%= mv.getClubFtzone() %></span>
				          <span class="detail-memo"><%= mv.getClubMemo() %></span>
				          <span class="detail-clubno" style="display:none;"><%= mv.getClubNo() %></span>
				        </div>
		                <td><%=mv.getAthlName()%></td>
            			<td><%=mv.getClubFarea()%></td>
	                </tr>
	                <%
			            }
			        } else {
			        %>
		            <tr class="empty">
                        <td colspan="4">게시물이 없습니다.</td>
                    </tr>
		            <%
		                }
		            %>
	            </tbody>
	        </table>
			
			
            <!-- 페이지 -->
            <div class="page">
	    		<ul>
			        <%
				      if(pageVO != null){
				          String currentSort = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
				          // 이전 페이지로 이동하는 링크
				          if(pageVO.getPageNo() > 1) {
				  %>
			                <li class="prev">
			                    <a href="list.do?pageNo=<%= pageVO.getPageNo() - 1 %><%= currentSort %>">Prev</a>
			                </li>
			            <%
					          }
					          // 페이지 번호 링크
					          for(int i=pageVO.getStartPage(); i<=pageVO.getEndPage(); i++){
					  %>
			                <li class="num <%= pageVO.getPageNo() == i ? "on" : "" %>">
			                    <a href="list.do?pageNo=<%= i %><%= currentSort %>" class="<%= pageVO.getPageNo() == i ? "active" : "" %>"><%= i %></a>
			                </li>
			            <%
						          }
						          // 다음 페이지로 이동하는 링크
						          if(pageVO.getPageNo() < pageVO.getTotalPage()) {
						  %>
			                <li class="next">
			                    <a href="list.do?pageNo=<%= pageVO.getPageNo() + 1 %><%= currentSort %>">Next</a>
			                </li>
			            <%
					            }
					        }
					    %>
			    </ul>
			</div>
			
			<!-- 팝업 -->
			<div id="pop" class="mate_pop" style="display: none;">
				<div class="box">
					<button class="c_btn" onclick="closeModal2()">
						<span class="sp01"></span> <span class="sp02"></span>
					</button>
					<h2 id="modalTitle"></h2>
					<button id="likeButton" class="like-button like-on" onclick="toggleLike('<%= isLoggedIn %>')" style="display: none"></button>
					<div class="wrap">
						<div id="pop_con">
							<table>
								<colgroup>
									<col width="30%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
						                  <th>종목</th>
						                  <td id="modalCode"></td>
						              </tr>
						              <tr>
						                  <th>활동지역</th>
						                  <td id="modalFarea"></td>
						              </tr>
						              <tr>
						                  <th>연령대</th>
						                  <td id="modalAge"></td>
						              </tr>
						              <tr>
						                  <th>멤버수/정원</th>
						                  <td id="modalMembers"></td>
						              </tr>
						              <tr>
						                  <th>주 활동시간</th>
						                  <td id="modalTime"></td>
						              </tr>
						              <tr>
						                  <th>비고</th>
						                  <td id="modalMemo"></td>
						              </tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="btn_area">
						<div class="btn center">
							<button onclick="closeModal2()">닫기</button>
						</div>
					</div>

				</div>
			</div>
	    </div>
	</div>
</section>
<!-- // Content -->




























<script>
//동호회 목록 중 하나를 클릭했을 때 상세 정보를 보여주는 함수입니다.
function showDetail(element, liked, isLoggedIn) {
    // 클릭된 요소에서 data- 속성을 통해 정보를 추출합니다.
    var clubName = element.getAttribute('data-club-name');
    var liked = element.getAttribute('data-liked') === 'true';
    var isLoggedIn = element.getAttribute('data-is-logged-in') === 'true';
    var code = element.getAttribute('data-code');
    var farea = element.getAttribute('data-farea');
    var age = element.getAttribute('data-age');
    var members = element.getAttribute('data-members');
    var ftzone = element.getAttribute('data-ftzone');
    var memo = element.getAttribute('data-memo');
    var clubCurrmem = members.split('/')[0];
    var clubTotalmem = members.split('/')[1];
    var recruitmentStatus = (parseInt(clubCurrmem) >= parseInt(clubTotalmem)) ? '모집마감' : '모집중';

    // 모달 창에 정보를 표시합니다.
    document.getElementById('modalTitle').innerText = clubName;
    document.getElementById('modalCode').innerText = code;
    document.getElementById('modalFarea').innerText = farea;
    document.getElementById('modalAge').innerText = age;
    document.getElementById('modalMembers').innerText = clubCurrmem + "/" + clubTotalmem + "("+recruitmentStatus+")";
    document.getElementById('modalTime').innerText = ftzone;
    document.getElementById('modalMemo').innerText = memo;

    // 찜하기 버튼의 상태를 업데이트합니다.
    var likeButton = document.getElementById('likeButton');
    likeButton.innerText = liked ? '찜 취소' : '찜하기';
    likeButton.classList.toggle('like-off', !liked);
    likeButton.classList.toggle('like-on', liked);
    likeButton.setAttribute('data-liked', liked.toString()); // 현재 상태를 반영하도록 이를 업데이트합니다
    likeButton.setAttribute('data-club-no', element.getAttribute('data-club-no')); // clubNo가 올바르게 설정되었는지 확인

    // 모달 창을 표시합니다.
    document.getElementById('pop').style.display = 'block';
}


//찜하기 상태를 토글하는 함수
function toggleLike() {
    var isLoggedIn = '<%= isLoggedIn %>' === 'true';
    if (!isLoggedIn) {
        alert("로그인이 필요한 기능입니다.");
        return;
    }

    var likeButton = document.getElementById('likeButton');
    var isLiked = likeButton.getAttribute('data-liked') === 'true';
    var clubNo = likeButton.getAttribute('data-club-no');
    
    var dataToSend = `action=${isLiked ? 'unlike' : 'like'}&clubNo=${clubNo}`;
    
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/member/like.do",
        data: dataToSend,
        success: function(response) {
            if (response.success) {
                // Toggle the liked state based on the response
                likeButton.setAttribute('data-liked', (!isLiked).toString());
                likeButton.innerText = !isLiked ? '찜 취소' : '찜하기';
                likeButton.classList.toggle('like-on', !isLiked);
                likeButton.classList.toggle('like-off', isLiked);
                alert("찜 상태가 변경되었습니다.");
            } else {
                alert(response.message);
            }
        },
        error: function() {
            alert("오류가 발생했습니다. 나중에 다시 시도해주세요.");
        }
    });
}
//찜하기 버튼 UI 업데이트 함수
function updateLikeButtonUI(button, isLiked) {
    if (isLiked) {
        button.innerText = '찜 취소';
        button.classList.remove('like-off');
        button.classList.add('like-on');
        button.setAttribute('data-liked', 'true');
    } else {
        button.innerText = '찜하기';
        button.classList.remove('like-on');
        button.classList.add('like-off');
        button.setAttribute('data-liked', 'false');
    }
}
// 모달 창을 닫는 함수입니다.
function closeModal2() {
    document.getElementById('pop').style.display = 'none';
}

// 모달 창 외부를 클릭했을 때 모달 창이 닫히도록 이벤트 리스너를 추가합니다.
document.getElementById('pop').addEventListener('click', function(event) {
    // 클릭된 요소가 모달 창 자체일 경우 모달 창을 닫습니다.
    if (event.target == this) {
        closeModal2();
    }
});
function checkJoin(memNo, clubNo) {
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/checkJoin.do",
        data: {
            memNo: memNo,
            clubNo: clubNo
        },
        dataType : "json",
        success: function(response) {
            console.log(response.isMember);
            if (response.isMember) {
                $('#joinButton').val('바로가기');
            } else {
                $('#joinButton').val('가입하기');
            }
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        }
    });
}
</script>
<%@include file="/views/inclue/bottom.jsp" %>