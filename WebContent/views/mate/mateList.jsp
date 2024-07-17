<%@page import="kr.or.ddit.place.vo.AthlVO"%>
<%@ page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp"%>

<%
	// 로그인 여부 확인
boolean isLoggedIn = (user != null);

// 로그인된 사용자의 아이디 출력 (디버깅 용도)
String loggedInUserId = isLoggedIn ? user.getMemId() : "비로그인 상태";

// 종목이름 가져오기
List<AthlVO> athlList = (List<AthlVO>) request.getAttribute("athlList");
%>
<script>
let memNo = null;

function showDetail(element, liked, isLoggedIn) {
    // 클릭된 요소의 부모인 <tr> 태그를 찾고, 이를 기반으로 hidden-details 요소에 접근합니다.
    var hiddenDetails = element.closest('tr').querySelector('.hidden-details');

    // hidden-details 요소에서 각 정보를 추출합니다.
    var clubNo = hiddenDetails.querySelector('.detail-clubno').innerText;
    var clubName = hiddenDetails.querySelector('.detail-clubname').innerText;
    var athlName = hiddenDetails.querySelector('.detail-athlname').innerText;
    var farea = hiddenDetails.querySelector('.detail-farea').innerText;
    var age = hiddenDetails.querySelector('.detail-age').innerText;
    var members = hiddenDetails.querySelector('.detail-members').innerText;
    var ftzone = hiddenDetails.querySelector('.detail-ftzone').innerText;
    var memo = hiddenDetails.querySelector('.detail-memo').innerText;
    
    // 추출한 정보를 모달 팝업의 해당 부분에 채워 넣습니다.
    document.getElementById('modalTitle').innerText = clubName;
    document.getElementById('modalAthlName').innerText = athlName;
    document.getElementById('modalFarea').innerText = farea;
    document.getElementById('modalAge').innerText = age;
    document.getElementById('modalMembers').innerText = members;
    document.getElementById('modalTime').innerText = ftzone;
    document.getElementById('modalMemo').innerText = memo;

    // 찜하기 버튼 상태 업데이트
    var likeButton = document.getElementById('likeButton');
    likeButton.innerText = liked === 'true' ? '찜 취소' : '찜하기';
    likeButton.classList.toggle('like-on', liked === 'true');
    likeButton.classList.toggle('like-off', liked !== 'true');
    likeButton.setAttribute('data-clubno', clubNo);
    likeButton.setAttribute('data-liked', liked);
    
    checkJoin(memNo, clubNo);

 	// 동호회의 현재 멤버 수와 총 정원을 가져옵니다.
    var currMembers = parseInt(document.getElementById('modalMembers').innerText.split('/')[0]); // 현재 멤버 수
    var totalMembers = parseInt(document.getElementById('modalMembers').innerText.split('/')[1]); // 총 정원

    // UI 업데이트 함수 호출
    updateJoinButtonUI(currMembers, totalMembers);

    // 팝업을 표시합니다.
    document.getElementById('pop').style.display = 'block';
}

document.addEventListener('DOMContentLoaded', function() {
	
	// 세션에서 사용자 정보 가져오기
    let user = '<%=request.getSession().getAttribute("user")%>';
    
    // 로그인 여부 확인
    let isLoggedIn = user !== null;

    // 로그인된 경우에만 memNo 설정
	if (isLoggedIn) {
	    memNo = <%=user != null ? user.getMemNo() : null%>;
	}
    
    // 찜하기 버튼에 이벤트 리스너를 추가합니다.
    var likeButton = document.getElementById('likeButton');
    likeButton.addEventListener('click', function() {
        var clubNo = likeButton.getAttribute('data-clubno');
        var isLiked = likeButton.getAttribute('data-liked') === 'true';
        
        // UI 업데이트
        updateLikeButtonUI(likeButton, !isLiked);
        
        // 서버에 찜하기 상태 전송
        toggleLike('<%=isLoggedIn%>', clubNo, !isLiked);
    });
});

// 찜하기 버튼 UI 업데이트 함수
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

// 찜하기 상태 서버 전송 함수
function toggleLike(isLoggedIn, clubNo, isLiked) {
    if (isLoggedIn !== 'true') {
        alert("로그인이 필요한 기능입니다.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/mate/like.do",
        data: {
            memNo: memNo,
            clubNo: clubNo,
            isLiked: isLiked
        },
        dataType: "json",
        success: function(response) {
            console.log(response);
            // 서버 응답 처리 필요한 경우 여기에 작성
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            // 에러 발생 시 UI 롤백 처리
            updateLikeButtonUI(button, !isLiked);
        }
    });
}

//동호회의 현재 멤버 수와 총 정원을 비교하여 UI 업데이트 함수
function updateJoinButtonUI(currMembers, totalMembers) {
    var joinButton = document.getElementById('joinButton');
    if (currMembers >= totalMembers) {
        joinButton.disabled = true; // 현재 멤버 수가 총 정원을 초과하면 가입 버튼을 비활성화합니다.
        joinButton.style.display = 'none';
    } else {
        joinButton.disabled = false; // 그렇지 않으면 가입 버튼을 활성화합니다.
        joinButton.style.display = 'block';
    }
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
}

document.getElementById('modal').addEventListener('click', function(event) {
    if (event.target == this) {
        closeModal();
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
                $('#joinButton').text('바로가기');
            } else {
                $('#joinButton').text('가입하기');
            }
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        }
    });
}


$('a').on('click', function(){
	var likeButton = document.getElementById('likeButton');
	var isLiked = likeButton.getAttribute('data-liked');
	showDetail(this, isLiked, '<%=isLoggedIn%>')
})
</script>

<!-- Content -->
<section id="con_noticeList" class="conBody">

	<!-- 타이틀  -->
	<div id="" class="tit_wrap">
		<h2>짝:MATE</h2>
		<p>다양한 스포츠 종목의 우리동네 동호회를 찾아보세요!</p>
	</div>

	<!-- 검색 영역 -->
	<div id="searchArea" class="placeSearch_wrap mt80">
		<div class="search">
			<form method="get"
				action="<%=request.getContextPath()%>/mate/list.do" class="flex">
				<select name="athlName" title="종목">
					<option value="">종목</option>
					<%
						for (AthlVO av : athlList) {
					%>
					<option value="<%=av.getAthlName()%>"
						<%=av.getAthlName().equals(request.getParameter("athlName")) ? "selected" : ""%>><%=av.getAthlName()%></option>
					<%
						}
					%>
				</select> <span class="line"></span> <select name="clubEndyn" title="모집상태">
					<option value="">모집상태</option>
					<option value="N"
						<%="N".equals(request.getParameter("clubEndyn")) ? "selected" : ""%>>모집중</option>
					<option value="Y"
						<%="Y".equals(request.getParameter("clubEndyn")) ? "selected" : ""%>>모집마감</option>
				</select> <span class="line"></span> <input type="text" name="mtName"
					value="<%=request.getParameter("mtName") != null ? request.getParameter("mtName") : ""%>"
					class="se_in" placeholder="동호회명을 입력하세요">
				<button>검색</button>
			</form>
		</div>
		<div class="reset_btn">
			<form action="<%=request.getContextPath()%>/mate/list.do"
				method="get">
				<button type="submit">검색조건 초기화</button>
			</form>
		</div>
	</div>

	<!-- 리스트 영역 -->
	<div id="" class="list_form mt80">
		<div class="list_area">

			<div class="l_top">
				<!-- 게시물 건수  -->
				<strong>총 <b>${totalCount}</b>건
				</strong>
			</div>

			<!-- 게시판 리스트 -->
			<table class="b_list">
				<colgroup>
					<col width="10%" />
					<col width="*" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>동호회명</th>
						<th>종목</th>
						<th>활동지역</th>
						<th>현인원/정원</th>
						<th>모집상태</th>
					</tr>
				</thead>
				<tbody>
					<%
						List<MateVO> matelist = (List<MateVO>) request.getAttribute("mates");
					%>
					<%
						PageVO pageVO = (PageVO) request.getAttribute("pg");
					%>
					<%
						if (matelist != null && !matelist.isEmpty()) {
					%>
					<%
						for (MateVO mate : matelist) {
					%>
					<tr
						onclick="showDetail(this, '<%=mate.isLiked()%>', '<%=isLoggedIn%>')">
						<td><%=mate.getRnum()%></td>
						<td class="ti"><a href="javascript:void(0)"<%-- onclick="showDetail(this, '<%= mate.isLiked() %>', '<%= isLoggedIn %>')" --%>><%=mate.getClubName()%></a>
							<!-- 숨겨진 상세 정보 -->
							<div class="hidden-details" style="display: none;">
								<span><%=mate.getClubNo()%></span> <span
									class="detail-clubname"><%=mate.getClubName()%></span> <span
									class="detail-athlname"><%=mate.getAthlName()%></span> <span
									class="detail-farea"><%=mate.getClubFarea()%></span> <span
									class="detail-age"><%=mate.getClubAge()%></span> <span
									class="detail-members"><%=mate.getClubCurrmem()%>/<%=mate.getClubTotalmem()%></span>
								<span class="detail-ftzone"><%=mate.getClubFtzone()%></span> <span
									class="detail-memo"><%=mate.getClubMemo() == null ? "" : mate.getClubMemo()%></span>
								<span class="detail-clubno" style="display: none;"><%=mate.getClubNo()%></span>
							</div></td>
						<td><%=mate.getAthlName()%></td>
						<td><%=mate.getClubFarea()%></td>
						<td><%=mate.getClubCurrmem()%>/<%=mate.getClubTotalmem()%></td>
						<td>
							<%
								if ("Y".equals(mate.getClubEndyn()) || mate.getClubCurrmem() >= mate.getClubTotalmem()) {
							%>
							<span class="badge">모집마감</span> <%
 	} else {
 %> <span
							class="badge on">모집중</span> <%
 	}
 %>
						</td>
					</tr>
					<%
						}
					} else {
					%>
					<tr class="empty">
						<td colspan="6">게시물이 없습니다.</td>
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
						if (pageVO != null) {
						// 이전 페이지로 이동하는 링크
						if (pageVO.getPageNo() > 1) {
					%>
					<li class="prev"><a
						href="list.do?pageNo=<%=pageVO.getPageNo() - 1%>">Prev</a></li>
					<%
						}

					// 페이지 번호 링크
					for (int i = pageVO.getStartPage(); i <= pageVO.getEndPage(); i++) {
					%>
					<li class="num <%=pageVO.getPageNo() == i ? "on" : ""%>"><a
						href="list.do?pageNo=<%=i%>"><%=i%></a></li>
					<%
						}

					// 다음 페이지로 이동하는 링크
					if (pageVO.getPageNo() < pageVO.getTotalPage()) {
					%>
					<li class="next"><a
						href="list.do?pageNo=<%=pageVO.getPageNo() + 1%>">Next</a></li>
					<%
						}
					}
					%>
				</ul>
			</div>


			<!-- 버튼 영역 -->
			<div class="btn_area">
				<div class="btn">
					<form action="<%=request.getContextPath()%>/mate/insert.do"
						method="get">
						<button type="submit">등록</button>
						<!-- 추후 관리자에게만 보이도록 수정해야 함 -->
					</form>
				</div>
			</div>


			<!-- 팝업 -->
			<div id="pop" class="mate_pop" style="display: none;">
				<div class="box">
					<button class="c_btn" onclick="closeModal()">
						<span class="sp01"></span> <span class="sp02"></span>
					</button>
					<h2 id="modalTitle"></h2>
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
										<td id="modalAthlName"></td>
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
										<td id="modalMembers"><span class="badge on">모집중</span></td>
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
							<button id="likeButton" class="like-button"<%-- onclick="toggleLike('<%= isLoggedIn %>')" --%>>찜하기</button>
							<button type="button" id="joinButton">가입하기</button>
						</div>
					</div>

				</div>
			</div>




		</div>
	</div>
</section>
<!-- // Content -->




<script>


$('#joinButton').on('click', function(){
	console.log('로그인 여부',<%=isLoggedIn%>)
	if( !<%=isLoggedIn%> ){
		alert("로그인이 필요한 기능입니다.");
        return;
	}else{
		
	var clubNo = $(this).siblings('button#likeButton').attr('data-clubno'); // '찜하기'버튼에 저장된 clubNo 가져오기
	var val = $(this).text();
	if(val == '바로가기'){
		location.href = '<%=request.getContextPath()%>/mate/home.do?clubNo='+clubNo;
	}else {
		var confirmed = confirm('정말로 가입하시겠습니까 ?');
		if(confirmed){
		location.href = '<%=request.getContextPath()%>/mate/join.do?clubNo='+ clubNo;
				}
			}
		}
});

</script>

<%@include file="/views/inclue/bottom.jsp"%>