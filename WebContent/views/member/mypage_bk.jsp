<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@page import="kr.or.ddit.place.vo.AthlVO"%>
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

// 종목이름 가져오기
List<AthlVO> athlList = (List<AthlVO>)request.getAttribute("athlList");
%>
<style>
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
</style>
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
    <div class="nav-buttons">
        <a href="#" class="active">마이 메이트</a>
        <a href="<%=request.getContextPath()%>/member/info.do">회원정보</a>
        <a href="<%=request.getContextPath()%>/member/like.do">찜관리</a>
        <a href="<%=request.getContextPath()%>/member/askList.do">1:1 문의</a>
    </div>
    <div class="sort-options">
    	<form action="<%=request.getContextPath()%>/member/mypage.do" method="get">
        </form>
    </div>
    <table class="table">
        <thead>
            <tr>
                <th>No</th>
                <th>동호회명</th>
                <th>종목</th>
                <th>활동지역</th>
                <th>가입일</th>
            </tr>
        </thead>
        <tbody>
            <!-- 데이터 반복 영역 -->
            <%
            List<MyPageVO> boardList = (List<MyPageVO>) request.getAttribute("boardList");
            List<MateVO> mateList = (List<MateVO>) request.getAttribute("mateList"); // MateVO 리스트 추가
            PageVO pageVO = (PageVO) request.getAttribute("pageVO");
            %>
            
            <div class="total-count">
    			<p>총 <%=pageVO.getCount()%>건</p>
			</div>
            
            <%
            if (boardList != null && !boardList.isEmpty()) {
                for (MyPageVO board : boardList) {
            %>
            <tr>
                <td><%=board.getRnum()%></td>
				<td>
        			<a href='<%=request.getContextPath() %>/mate/home.do?clubNo=<%=board.getClubNo()%>' >
<!--         				onclick="showDetail(this)"  -->
<%--     					data-club-name="<%=board.getClubName()%>" --%>
<%--     					data-liked="<%=board.isLiked()%>"  --%>
<%--    						data-is-logged-in="<%=isLoggedIn%>" --%>
<%--     					data-code="<%=board.getCode()%>" --%>
<%--     					data-farea="<%=board.getClubFarea()%>" --%>
<%--     					data-age="<%=board.getClubAge()%>" --%>
<%--     					data-members="<%=board.getClubCurrmem()%>/<%=board.getClubTotalmem()%>" --%>
<%--     					data-ftzone="<%=board.getClubFtzone()%>" --%>
<%--     					data-memo="<%=board.getClubMemo()%>" --%>
    					
    					<%= board.getClubName() %>
					</a>
    			</td>
    			<div class="hidden-details" style="display: none;">
            		<span class="detail-clubname"><%= board.getClubName() %></span>
            		<span class="detail-code"><%= board.getCode() %></span>
            		<span class="detail-farea"><%= board.getClubFarea() %></span>
            		<span class="detail-age"><%= board.getClubAge() %></span>
            		<span class="detail-members"><%= board.getClubCurrmem() %>/<%= board.getClubTotalmem() %></span>
            		<span class="detail-ftzone"><%= board.getClubFtzone() %></span>
            		<span class="detail-memo"><%= board.getClubMemo() %></span>
            		<span class="detail-clubno" style="display:none;"><%= board.getClubNo() %></span>
        		</div>
				<td><%=board.getCode()%></td>
                <td><%=board.getClubFarea()%></td>
                <td><%=board.getJoinDate()%></td>
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
             <span class="close-button" onclick="closeModal()">&times;</span>
             <h2 id="modalTitle"></h2>
             <!-- 찜하기 버튼 -->
             <button id="likeButton" class="like-button" onclick="toggleLike('<%= isLoggedIn %>')">찜하기</button>
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
             <button onclick="closeModal()">닫기</button>
             <!-- <button>가입하기</button> -->
         </div>
     </div>
  </main>
</div>
<script>
//동호회 목록 중 하나를 클릭했을 때 상세 정보를 보여주는 함수입니다.
function showDetail(element) {
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
    likeButton.classList.toggle('like-on', liked);
    likeButton.classList.toggle('like-off', !liked);

    // 모달 창을 표시합니다.
    document.getElementById('modal').style.display = 'block';
}

// 찜하기 버튼을 클릭했을 때의 동작을 정의한 함수입니다.
function toggleLike(isLoggedIn) {
    // 로그인 여부를 확인하고, 로그인하지 않은 경우 경고 메시지를 표시합니다.
    if (isLoggedIn !== 'true') {
        alert("로그인이 필요한 기능입니다.");
        return;
    }
    // 찜하기 버튼의 현재 상태를 확인합니다.
    var likeButton = document.getElementById('likeButton');
    var isLiked = likeButton.innerText === '찜 취소';
    // 찜하기 상태를 토글합니다.
    isLiked = !isLiked;
    likeButton.innerText = isLiked ? '찜 취소' : '찜하기';
    likeButton.classList.toggle('like-on', isLiked);
    likeButton.classList.toggle('like-off', !isLiked);
    // 서버에 찜하기 또는 찜 취소 요청을 보내는 로직을 여기에 구현해야 합니다.
}

// 모달 창을 닫는 함수입니다.
function closeModal() {
    document.getElementById('modal').style.display = 'none';
}

// 모달 창 외부를 클릭했을 때 모달 창이 닫히도록 이벤트 리스너를 추가합니다.
document.getElementById('modal').addEventListener('click', function(event) {
    // 클릭된 요소가 모달 창 자체일 경우 모달 창을 닫습니다.
    if (event.target == this) {
        closeModal();
    }
});
</script>
<%@include file="/views/inclue/bottom.jsp" %>
