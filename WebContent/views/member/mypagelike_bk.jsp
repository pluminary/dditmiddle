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
<!-- <link rel="stylesheet" href="/css/style.css"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
	body { font-family: Arial, sans-serif; line-height: 1.6; }
    .container { max-width: 800px; margin: auto; padding: 20px; }
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f4f4f4; }
    .pagination { text-align: center; margin-top: 20px; }
    .pagination a { display: inline-block; margin: 0 5px; padding: 5px 10px; border: 1px solid #ddd; color: black; text-decoration: none; }
    .pagination a:hover, .pagination a.active { background-color: #ddd; }
    .add-btn { display: block; width: max-content; padding: 5px 10px; margin: 20px auto; text-align: center; background-color: #333; color: white; text-decoration: none; }
    .add-btn:hover { background-color: #555; }
    .saveBtn {
        display: flex;
        justify-content: flex-end;
    }
    .clearFilters {
        display: flex;
        justify-content: flex-end;
    }
    .sort-options {
        text-align: right;
        margin: 10px 0;
    }
    .sort-form {
        display: inline-block;
    }
    .sort-select {
        padding: 5px;
        border-radius: 5px;
    }
    .search-input {
        padding: 5px;
        margin-right: 10px;
        border-radius: 5px;
    }
    .search-btn {
        padding: 5px 10px;
        border-radius: 5px;
        border: 1px solid #ddd;
    }
    .nav-buttons {
        display: flex;
        justify-content: start;
        margin-bottom: 20px;
    }
    .nav-buttons a {
        display: inline-block;
        background-color: #f4f4f4;
        color: #333;
        padding: 10px 15px;
        margin-right: 10px;
        text-decoration: none;
        border: 1px solid #ddd;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .nav-buttons a:hover {
        background-color: #ddd;
    }
    /* 모달 스타일 */
    .modal {
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4); /* 불투명한 검정색 배경 */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
    }

    .close-button {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close-button:hover,
    .close-button:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    /* 찜하기 버튼 스타일 */
    .like-off {
        background-color: #f4f4f4;
        color: #000;
    }
    
    .like-on {
        background-color: #ff0000;
        color: #fff;
    }
    .nav-buttons a.active {
    background-color: #007bff; /* 예시 색상, 원하는 색상으로 변경 가능 */
    color: white;
	}
	/* 비밀번호 필드와 버튼 스타일 */
    .password-field, .submit-button {
        width: 60%; /* 폼 너비에 맞게 확장 */
        padding: 10px; /* 패딩으로 필드와 버튼의 높이를 적절하게 설정 */
        margin-bottom: 20px; /* 필드와 버튼 사이의 여백을 조정 */
    }
</style>
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
  <div class="nav-buttons">
      <a href="<%=request.getContextPath()%>/member/mypage.do">마이 메이트</a>
      <a href="<%=request.getContextPath()%>/member/info.do">회원정보</a>
      <a href="#" class="active">찜관리</a>
      <a href="<%=request.getContextPath()%>/member/askList.do">1:1 문의</a>
  </div>
  <span>총 ${totalCount}건</span>
  <table class="table">
  	<thread>
  		<tr>
  		  <th>No</th>
          <th>동호회명</th>
          <th>종목</th>
          <th>활동지역</th>
  		</tr>
  	</thread>
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
        <tr>
            <td><%=like.getRnum()%></td>
		<td>
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
        <tr>
        <td colspan="5">게시물이 없습니다.</td>
        </tr>
        <%
        }
        %>  	
  	</tbody>
  </table>
  <%-- 기존 페이징 영역 --%>
  <div class="pagination">
  <%
      if(pageVO != null){
          String currentSort = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
          // 이전 페이지로 이동하는 링크
          if(pageVO.getPageNo() > 1) {
  %>
	  <ul class="pagination pager">
              <a href="list.do?pageNo=<%= pageVO.getPageNo() - 1 %><%= currentSort %>">◀</a>
  <%
          }
          // 페이지 번호 링크
          for(int i=pageVO.getStartPage(); i<=pageVO.getEndPage(); i++){
  %>
              <a href="list.do?pageNo=<%= i %><%= currentSort %>" class="<%= pageVO.getPageNo() == i ? "active" : "" %>"><%= i %></a>
  <%
          }
          // 다음 페이지로 이동하는 링크
          if(pageVO.getPageNo() < pageVO.getTotalPage()) {
  %>
              <a href="list.do?pageNo=<%= pageVO.getPageNo() + 1 %><%= currentSort %>">▶</a>
  <%
          }
      }
  %>
  </div>
  <!-- 모달 팝업 -->
  <div id="modal" class="modal" style="display:none;">
      <div class="modal-content">
          <span class="close-button" onclick="closeModal2()">&times;</span>
          <h2 id="modalTitle"></h2>
          <!-- 찜하기 버튼 -->
          <button id="likeButton" class="like-button like-on" onclick="toggleLike('<%= isLoggedIn %>')" style="display: none"></button>
          <table>
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
          </table>
          <button onclick="closeModal2()">닫기</button>
      </div>
     </div>
  </main>
</div>
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
    document.getElementById('modal').style.display = 'block';
}

<%-- document.addEventListener('DOMContentLoaded', function() {
	
	// 세션에서 사용자 정보 가져오기
    let user = '<%= request.getSession().getAttribute("user") %>';
    
    // 로그인 여부 확인
    let isLoggedIn = user !== null;

    // 로그인된 경우에만 memNo 설정
	if (isLoggedIn) {
	    memNo = <%= user != null ? user.getMemNo() : null %>;
	}
    
    // 찜하기 버튼에 이벤트 리스너를 추가합니다.
    var likeButton = document.getElementById('likeButton');
    likeButton.addEventListener('click', function() {
        var clubNo = likeButton.getAttribute('data-clubno');
        var isLiked = likeButton.getAttribute('data-liked') === 'true';
        
        // UI 업데이트
        updateLikeButtonUI(likeButton, isLiked);
        
        // 서버에 찜하기 상태 전송
        toggleLike('<%= isLoggedIn %>', clubNo, isLiked);
    });
}); --%>

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
    document.getElementById('modal').style.display = 'none';
}

// 모달 창 외부를 클릭했을 때 모달 창이 닫히도록 이벤트 리스너를 추가합니다.
document.getElementById('modal').addEventListener('click', function(event) {
    // 클릭된 요소가 모달 창 자체일 경우 모달 창을 닫습니다.
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