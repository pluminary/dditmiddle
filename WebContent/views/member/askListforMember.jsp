<%@page import="kr.or.ddit.member.vo.askVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/views/inclue/top.jsp" %>  
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
    justify-content: flex-end; /* 오른쪽 정렬을 위해 사용 */
    }
    .clearFilters {
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬을 위해 사용 */
    }
    .sort-options {
    text-align: right; /* 우측 정렬 */
    margin: 10px 0; /* 상단 여백 */
	}
	.sort-form {
    display: inline-block; /* 드롭다운을 인라인 블록 요소로 표시 */
	}
	.sort-select {
    padding: 5px; /* 패딩 조정 */
    border-radius: 5px; /* 모서리 둥글게 */
	}
	.sort-options {
    text-align: right; /* 우측 정렬을 위해 사용 */
    margin-bottom: 20px; /* 하단 여백 */
}

.search-input {
    padding: 5px;
    margin-right: 10px; /* 검색 버튼과의 간격 */
    border-radius: 5px; /* 입력 필드 모서리 둥글게 */
}

.search-btn {
    padding: 5px 10px;
    border-radius: 5px; /* 버튼 모서리 둥글게 */
    border: 1px solid #ddd; /* 경계선 스타일 */
}

.sort-select {
    padding: 5px; /* 패딩 조정 */
    border-radius: 5px;
}
</style>
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
    <h2 class="sectiontitle">1:1문의-회원</h2>
    <div class="sort-options">
    	<form action="<%=request.getContextPath()%>/member/askList.do" method="get">
        
    	</form>
	</div>

    <table class="table">
    	
        <thead>
            <tr>
                <th>제목</th>
                <th>작성일</th>
                <th>문의유형</th>
                <th>답변유무</th>
            </tr>
        </thead>
        <tbody>
			<%
			List<askVO> askList = (List<askVO>) request.getAttribute("askList");
			PageVO pageVO = (PageVO) request.getAttribute("pageVO");
			%>
			
		

			<%
				if (askList != null && !askList.isEmpty()) {
				for (askVO askvo : askList) {
			%>		
			
			<tr>
				<td><a href="askdetail.do?no=<%=askvo.getAskNo()%>"><%=askvo.getAskTitle()%></a></td>
				<td><%=askvo.getAskDate()%></td>
				<td><%=askvo.getAskClass()%></td>
				<td><%= askvo.getAskAns() == null ? "N" : "Y" %></td>
			</tr>
				 <%-- 답변이 있는 경우에만 답변을 출력합니다. --%>
            <% if (askvo.getAskAns() != null) { %>
            <tr>
                <td colspan="6">↳답변: <%=askvo.getAskAns()%></td>
            </tr>
            <% } %>
			
			<%
				}
			} else {
			%>
			<tr>
				<td colspan="6">게시물이 없습니다.</td>
			</tr>
			<%
				}
			%>
		</tbody>
    </table>
   
	<%-- 등록 버튼 --%>
    <div class="saveBtn">
        <form action="<%=request.getContextPath()%>/member/askinsert.do" method="get">
            <button type="submit">등록</button>
        </form>
    </div>
  </main>
</div>
</script>
<%@include file="/views/inclue/bottom.jsp" %>