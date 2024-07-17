<%@page import="kr.or.ddit.member.vo.askVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 헤더 영역 -->
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
    width: 100px;
    height: 40px;
    margin-right: 8px;
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
    <h2 class="sectiontitle">1:1문의게시판(관리자 전용)</h2>
    <div class="sort-options" style="display: flex; justify-content: flex-end;">
    	<form action="<%=request.getContextPath()%>/admin/askList.do" method="get" class="flex" style="width: 50%">
        	<input type="text" name="searchKeyword" placeholder="제목 검색" value="${param.searchKeyword}" class="search-input">
        	<button type="submit" class="search-btn">검색</button>
        	
        	<select name="sort" class="sort-select" onchange="this.form.submit()">
            	<option value="all" ${"all".equals(param.sort) ? "selected" : ""}>전체</option>
<%--             	<option value="views" ${"views".equals(param.sort) ? "selected" : ""}>조회수 순</option> --%>
            	<option value="place" ${"place".equals(param.sort) ? "selected" : ""}>시설등록</option>
            	<option value="nomal" ${"nomal".equals(param.sort) ? "selected" : ""}>일반문의</option>
        	</select>
    	</form>
	</div>
    <table class="table">
    	
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>답변유무</th>
                <th>문의유형</th>
            </tr>
        </thead>
        <tbody>
			<%
			List<askVO> askList = (List<askVO>) request.getAttribute("askList");
			PageVO pageVO = (PageVO) request.getAttribute("pageVO");
			%>
			
			<div class="total-count">
    			<p>총 <%=pageVO.getCount()%>건</p>
			</div>

			<%
				if (askList != null && !askList.isEmpty()) {
				for (askVO askvo : askList) {
			%>		
			
			<tr>
				<td><%=askvo.getRnum()%></td>
				<td><a href="askdetail.do?no=<%=askvo.getAskNo()%>"><%=askvo.getAskTitle()%></a></td>
				<td><%=askvo.getMemNick()%></td>
				<td><%=askvo.getAskDate()%></td>
				<td><%= askvo.getAskAns() == null ? "N" : "Y" %></td>
				<td><%=askvo.getAskClass()%></td>
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
        	String searchKeyword = request.getParameter("searchKeyword") != null ? "&searchKeyword=" + request.getParameter("searchKeyword") : "";
            String currentSort = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
            // 이전 페이지로 이동하는 링크
            if(pageVO.getPageNo() > 1) {
    %>
		<ul class="pagination pager">
                <a href="askList.do?pageNo=<%= pageVO.getPageNo() - 1 %><%= currentSort %><%= searchKeyword %>">◀</a>
    <%
            }
            // 페이지 번호 링크
            for(int i=pageVO.getStartPage(); i<=pageVO.getEndPage(); i++){
    %>
                <a href="askList.do?pageNo=<%= i %><%= currentSort %><%= searchKeyword %>" class="<%= pageVO.getPageNo() == i ? "active" : "" %>"><%= i %></a>
    <%
            }
            // 다음 페이지로 이동하는 링크
            if(pageVO.getPageNo() < pageVO.getTotalPage()) {
    %>
                <a href="askList.do?pageNo=<%= pageVO.getPageNo() + 1 %><%= currentSort %><%= searchKeyword %>">▶</a>
    <%
            }
        }
    %>
	</div>

  </main>
</div>
</script>
<%@include file="/views/inclue/bottom.jsp" %>