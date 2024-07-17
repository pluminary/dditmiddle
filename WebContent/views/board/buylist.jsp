<%@page import="kr.or.ddit.member.vo.adminVO"%>
<%@page import="kr.or.ddit.board.vo.BuyBoardVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/views/inclue/top.jsp"%>

<!-- Content -->
<section id="con_freeList" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
		<ul>
			<li><a href="/GymMate/noticeboard/list.do">공지사항</a></li>
			<li class="on"><a href="/GymMate/buyboard/list.do">거래장터</a></li>
			<li><a href="/GymMate/freeboard/list.do">자유게시판</a></li>
		</ul>
	</div>

	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
		<h2>거래장터</h2>
		<p>각종 물품을 서로 소통하며 거래해 보세요.</p>
	</div>

	<%
		List<BuyBoardVO> boardList = (List<BuyBoardVO>) request.getAttribute("boardList");
	PageVO pageVO = (PageVO) request.getAttribute("pageVO");
	%>


	<div id="" class="list_form mt80">
		<div class="list_area">

			<div class="l_top">
				<!-- 게시물 건수  -->
				<strong>총 <b><%=pageVO.getCount()%></b>건
				</strong>

				<!-- 정렬 -->
				<div class="srch_area wide">
					<form action="<%=request.getContextPath()%>/buyboard/list.do"
						method="get" class="flex">
						<select name="sort" class="sort-select"
							onchange="this.form.submit()">
							<option value="latest"
								${"latest".equals(param.sort) ? "selected" : ""}>최신순</option>
							<option value="views"
								${"views".equals(param.sort) ? "selected" : ""}>조회수순</option>
						</select> <span class="line"></span> <input type="text"
							name="searchKeyword" value="${param.searchKeyword}" class="se_in"
							placeholder="제목 검색">
						<button type="submit">검색</button>
					</form>
				</div>
			</div>

			<!-- 게시판 리스트 -->
			<table class="b_list">
				<colgroup>
					<col width="15%" />
					<col width="*" />
					<col width="20%" />
					<col width="20%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						if (boardList != null && !boardList.isEmpty()) {
						for (BuyBoardVO board : boardList) {
					%>
					<tr onclick="location.href='detail.do?no=<%=board.getBoardNo()%>'">
						<td><%=board.getRnum()%></td>
						<td class="ti"><%=board.getBoardTitle()%></td>
						<td><%=board.getMemNick()%></td>
						<td><%=board.getBoardDate()%></td>
						<td><%=board.getBoardCount()%></td>
					</tr>
					<%
						}
					} else {
					%>
					<tr class="empty">
						<td colspan="5">게시물이 없습니다.</td>
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
						String searchKeyword = request.getParameter("searchKeyword") != null
						? "&searchKeyword=" + request.getParameter("searchKeyword")
						: "";
						String currentSort = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
						// 이전 페이지로 이동하는 링크
						if (pageVO.getPageNo() > 1) {
					%>

					<li class="prev"><a
						href="list.do?pageNo=<%=pageVO.getPageNo() - 1%><%=currentSort%><%=searchKeyword%>">Prev</a>
					</li>

					<%
						}
					// 페이지 번호 링크
					for (int i = pageVO.getStartPage(); i <= pageVO.getEndPage(); i++) {
					%>

					<li class="num <%=pageVO.getPageNo() == i ? "on" : ""%>"><a
						href="list.do?pageNo=<%=i%><%=currentSort%><%=searchKeyword%>"><%=i%></a>
					</li>

					<%
						}
					// 다음 페이지로 이동하는 링크
					if (pageVO.getPageNo() < pageVO.getTotalPage()) {
					%>

					<li class="next"><a
						href="list.do?pageNo=<%=pageVO.getPageNo() + 1%><%=currentSort%><%=searchKeyword%>">Next</a>
					</li>

					<%
						}
					}
					%>
				</ul>
			</div>
			<%
				adminVO admin = (adminVO) request.getSession().getAttribute("admin");
			if (admin != null) {

			} else {
			%>
<%
	if(user != null){
%>
			<!-- 버튼 영역 -->
			<div class="btn_area">
				<div class="btn">
					<form action="<%=request.getContextPath()%>/buyboard/insert.do"
						method="get">
						<button type="submit">등록</button>
					</form>
				</div>
			</div>
			<%
					}	
				}
			%>

		</div>
	</div>
</section>
<!-- // Content -->



<%@include file="/views/inclue/bottom.jsp"%>

