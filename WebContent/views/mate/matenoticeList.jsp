<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@page import="kr.or.ddit.mate.vo.MateNoticeVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>

<%
	PageVO pgv = (PageVO)request.getAttribute("pv");
	List<MateNoticeVO> list = (List<MateNoticeVO>)request.getAttribute("noticeList");
	Integer cnt = (Integer)request.getAttribute("cnt");
	String sortParam = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
	MateVO mv = (MateVO) request.getAttribute("mv");
%>


<!-- Content -->
<section id="con_board" class="conBody tab club">
    
    <div id="" class="tit_wrap pt90">
        <h2><a href="<%=request.getContextPath() %>/mate/home.do?clubNo=<%=mv.getClubNo()%>"><%=mv.getClubName() %></a></h2>
        <ul>
            <li class="writer"><%=mv.getAthlName() %> · <%=mv.getClubFarea() %> · <%=mv.getClubAge() %></li>
        </ul>
    </div>
    
    <div class="contents mt60">
        <div class="inner">
            <div class="club_tab">
                <ul>
                    <li><a href="<%=request.getContextPath() %>/mate/home.do?clubNo=<%=mv.getClubNo()%>" >메인</a></li>
				    <li><a href="<%=request.getContextPath() %>/mate/memberList.do?clubNo=<%=mv.getClubNo()%>" >멤버</a></li>
				    <li class="on"><a href="<%=request.getContextPath() %>/mate/noticelist.do?clubNo=<%=mv.getClubNo()%>">공지사항</a></li>
				    <li><a href="<%=request.getContextPath() %>/mate/boardList.do?clubNo=<%=mv.getClubNo()%>" >게시판</a></li>
                </ul>
            </div>

            <!-- 리스트 영역 -->
            <div id="" class="placeList_wrap list_form mt60">
                <div class="list_area">
                    
                    <div class="l_top">
                        <strong>총 <b><%=cnt %></b>건</strong>
                    </div>

                    <!-- 테이블 -->
                    <table class="b_list">
                        <colgroup>
                            <col width="25%" />
                            <col width="25%" />
                            <col width="25%" />
                            <col width="25%" />
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
							
								for(MateNoticeVO mmv : list){
									if(mv != null){
						%>
                            <tr onclick="location.href='<%=request.getContextPath() %>/mate/detailNotice.do?no=<%=mmv.getCnoticeNo() %>&clubNo=<%=mv.getClubNo()%>'">
                                <td><%=mmv.getRnum() %></td>
								<td class="ti"><%=mmv.getCnoticeTitle() %></td>
								<td><%=mmv.getCnoticeDate() %></td>
								<td><%=mmv.getCnoticeCount() %></td>
                            </tr>
                            <%
				                } else {
				            %>
				            <tr class="empty">
		                        <td colspan="4">게시물이 없습니다.</td>
		                    </tr>
						<%		
								}
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
					                    <a href="list.do?pageNo=<%= pgv.getPageNo() - 1 %><%= sortParam %>">Prev</a>
					                </li>
					            <% }
					
					            // 페이지 번호 링크
					            for(int i=pgv.getStartPage(); i<=pgv.getEndPage(); i++) { %>
					                <li class="num <%= pgv.getPageNo() == i ? "on" : "" %>">
					                    <a href="list.do?pageNo=<%= i %><%= sortParam %>"><%= i %></a>
					                </li>
					            <% }
					
					            // 다음 페이지로 이동하는 링크
					            if(pgv.getPageNo() < pgv.getTotalPage()) { %>
					                <li class="next">
					                    <a href="list.do?pageNo=<%= pgv.getPageNo() + 1 %><%= sortParam %>">Next</a>
					                </li>
					            <% } 
					        } %>
					    </ul>
					</div>
					
					
					<%
						String userNo = String.valueOf(user.getMemNo());
						MateVO mate = (MateVO)request.getAttribute("mv");
						String leader = mate.getMemNo();
						if(leader.equals(userNo)){
					%>
					
                    <!-- 버튼 영역 -->
                    <div class="btn_area">
                        <div class="btn">
                            <button id="insert">등록</button>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- // Content -->







<script>
$('#insert').on('click', function(){
	location.href="<%=request.getContextPath() %>/mate/noticeInsert.do?clubNo=<%=request.getAttribute("clubNo") %>";
});
</script>
<%@include file="/views/inclue/bottom.jsp" %>