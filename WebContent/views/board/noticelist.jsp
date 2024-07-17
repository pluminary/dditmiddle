<%@page import="kr.or.ddit.member.vo.adminVO"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/views/inclue/top.jsp" %>

<!-- Content -->
<section id="con_noticeList" class="conBody tab">

	<!-- 서브탭 -->
	<div class="s_tab s_tab2">
	    <ul>
	        <li class="on"><a href="/GymMate/noticeboard/list.do">공지사항</a></li>
	        <li><a href="/GymMate/buyboard/list.do">거래장터</a></li>
	        <li><a href="/GymMate/freeboard/list.do">자유게시판</a></li>
	    </ul>
	</div>
	
	<!-- 타이틀  -->
	<div id="" class="tit_wrap pt90">
	    <h2>공지사항</h2>
	    <p>짐짝의 중요한 소식들을 알려드립니다.</p>
	</div>
	
	<%
	    List<NoticeBoardVO> noticelist = (List<NoticeBoardVO>)request.getAttribute("notice"); // get name : "notice"
	    PageVO pageVO = (PageVO)request.getAttribute("pg");
	    String sortParam = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
	%>
	
	<div id="" class="list_form mt80">
	    <div class="list_area">
	    
	        <div class="l_top">
	        	<!-- 게시물 건수  -->
	            <strong>총 <b>${totalCount}</b>건</strong>
	
	            <!-- 정렬 -->
	            <div class="srch_area">
	            	<form id="sortForm" action="<%=request.getContextPath()%>/noticeboard/list.do" method="get">
		                <select  name="sort" onchange="submitFormWithPageNo()" id="" class="view_num">
		                    <option value="latest" <%= "latest".equals(request.getParameter("sort")) ? "selected" : "" %>>최신순</option>
				            <option value="views" <%= "views".equals(request.getParameter("sort")) ? "selected" : "" %>>조회수순</option>
				        </select>
				        <!-- 현재 페이지 번호를 숨겨진 필드로 추가 -->
		        		<input type="hidden" name="pageNo" value="<%=pageVO != null ? pageVO.getPageNo() : 1 %>"/>
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
	            </colgroup>
	            <thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
	            </thead>
	            <tbody>
		            <%
	                if(noticelist != null && !noticelist.isEmpty()){
	                    for(NoticeBoardVO notice : noticelist){
	            	%>
	                <tr onclick="location.href='detail.do?no=<%= notice.getNoticeNo() %>'">
	                    <td><%= notice.getRnum() %></td>
		                <td class="ti"><%= notice.getNoticeTitle() %></td>
		                <td><%= notice.getNoticeDate() %></td>
		                <td><%= notice.getNoticeCount() %></td>
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
			        <% if(pageVO != null) {
			            // 이전 페이지로 이동하는 링크
			            if(pageVO.getPageNo() > 1) { %>
			                <li class="prev">
			                    <a href="list.do?pageNo=<%= pageVO.getPageNo() - 1 %><%= sortParam %>">Prev</a>
			                </li>
			            <% }
			
			            // 페이지 번호 링크
			            for(int i=pageVO.getStartPage(); i<=pageVO.getEndPage(); i++) { %>
			                <li class="num <%= pageVO.getPageNo() == i ? "on" : "" %>">
			                    <a href="list.do?pageNo=<%= i %><%= sortParam %>"><%= i %></a>
			                </li>
			            <% }
			
			            // 다음 페이지로 이동하는 링크
			            if(pageVO.getPageNo() < pageVO.getTotalPage()) { %>
			                <li class="next">
			                    <a href="list.do?pageNo=<%= pageVO.getPageNo() + 1 %><%= sortParam %>">Next</a>
			                </li>
			            <% } 
			        } %>
			    </ul>
			</div>

           <%
           		adminVO admin = (adminVO)request.getSession().getAttribute("admin");
           		if(admin != null){
           %> 
            <!-- 버튼 영역 -->
            <div class="btn_area">
			    <div class="btn">
			        <form action="<%=request.getContextPath()%>/noticeboard/insert.do" method="get">
			            <button type="submit">등록</button> 
			        </form>
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
    function submitFormWithPageNo() {
        // 폼을 제출할 때 현재 페이지 번호를 포함시켜 제출
        document.getElementById('sortForm').submit();
    }
</script>

<%@include file="/views/inclue/bottom.jsp" %>
