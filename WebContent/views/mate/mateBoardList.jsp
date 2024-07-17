<%@page import="kr.or.ddit.mate.vo.MBoardFileVO"%>
<%@page import="kr.or.ddit.mate.service.MateBoardServiceImpl"%>
<%@page import="kr.or.ddit.mate.service.IMateBoardService"%>
<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="kr.or.ddit.mate.vo.MateBoardVO"%>
<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/views/inclue/top.jsp" %>    

<%
	List<MateBoardVO> boardList = (List<MateBoardVO>)request.getAttribute("boardList");
	PageVO pv = (PageVO)request.getAttribute("pv");
	String sortParam = request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "";
	Integer cnt = (Integer)request.getAttribute("cnt");
	MateVO mv = (MateVO) request.getAttribute("mv");
	
	IMateBoardService service = MateBoardServiceImpl.getInstance();
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
				    <li><a href="<%=request.getContextPath() %>/mate/noticelist.do?clubNo=<%=mv.getClubNo()%>">공지사항</a></li>
				    <li class="on"><a href="<%=request.getContextPath() %>/mate/boardList.do?clubNo=<%=mv.getClubNo()%>" >게시판</a></li>
                </ul>
            </div>

            <!-- 리스트 영역 -->
            <div id="" class="placeList_wrap list_form mt60">
                <div class="list_area">
                    
                    <div class="l_top">
                        <strong>총 <b><%=cnt %></b>건</strong>
                        
                        <!-- 정렬 -->
			            <div class="srch_area">
			            	<form id="sortForm" action="<%=request.getContextPath() %>/mate/boardList.do">
						        <select name="sort" onchange="submitFormWithPageNo()"class="view_num">
									<option value="latest" <%= "latest".equals(request.getParameter("sort")) ? "selected" : "" %>>최신순</option>
									<option value="views" <%= "views".equals(request.getParameter("sort")) ? "selected" : "" %>>조회수순</option>
								</select>
						        <!-- 현재 페이지 번호를 숨겨진 필드로 추가 -->
				        		<input type="hidden" name="pageNo" value="<%=pv != null ? pv.getPageNo() : 1 %>">
				        		<input type="hidden" name="clubNo" value="<%=mv.getClubNo() %>">
			                </form>
			            </div>
                    </div>

                    <!-- 테이블 -->
                    <table class="b_list">
                        <colgroup>
                            <col width="10%" />
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
							if(boardList != null && !boardList.isEmpty()){
								for(MateBoardVO mmv : boardList){
						%>
                            <tr onclick="location.href='<%=request.getContextPath() %>/mate/boardDetail.do?no=<%=mmv.getCbNo() %>'">
                                <td><%=mmv.getRnum() %></td>
                        <%
							List<MBoardFileVO> mf = service.getFile(mmv.getCbNo());
							if(mf != null && !mf.isEmpty()){
						%>	        
                                
								<td class="ti"><%=mmv.getCbTitle() %> <i class="ri-image-fill" style="color:#00C9C8; font-size:22px; padding-left:5px"></i></td>
						<%
							}else{
						%>		
								<td class="ti"><%=mmv.getCbTitle() %></td>
						<%		
							}
						%>		
								<td><%=mmv.getMemNick() %></td>
								<td><%=mmv.getCbRegDate() %></td>
								<td><%=mmv.getCbCount() %></td>
                            </tr>
	                    <%
								}
							}else {
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
					        <% if(pv != null) {
					            // 이전 페이지로 이동하는 링크
					            if(pv.getPageNo() > 1) { %>
					                <li class="prev">
					                    <a href="<%=request.getContextPath() %>/mate/boardList.do?pageNo=<%= pv.getPageNo() - 1 %><%= sortParam %>&clubNo=<%=mv.getClubNo()%>">Prev</a>
					                </li>
					            <% }
					
					            // 페이지 번호 링크
					            for(int i=pv.getStartPage(); i<=pv.getEndPage(); i++) { %>
					                <li class="num <%= pv.getPageNo() == i ? "on" : "" %>">
					                    <a href="<%=request.getContextPath() %>/mate/boardList.do?pageNo=<%= i %><%= sortParam %>&clubNo=<%=mv.getClubNo()%>"><%= i %></a>
					                </li>
					            <% }
					
					            // 다음 페이지로 이동하는 링크
					            if(pv.getPageNo() < pv.getTotalPage()) { %>
					                <li class="next">
					                    <a href="<%=request.getContextPath() %>/mate/boardList.do?pageNo=<%= pv.getPageNo() + 1 %><%= sortParam %>&clubNo=<%=mv.getClubNo()%>">Next</a>
					                </li>
					            <% } 
					        } %>
					    </ul>
					</div>
					
					
					
                    <!-- 버튼 영역 -->
                    <div class="btn_area">
                        <div class="btn">
                            <button id="insert">등록</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- // Content -->


<script type="text/javascript">
	function submitFormWithPageNo() {
		$('#sortForm').submit();
	}
	
	$('#insert').on('click', function(){
		location.href="<%=request.getContextPath() %>/mate/boardInsert.do?clubNo=<%=request.getAttribute("clubNo") %>";
	});
</script>
<%@include file="/views/inclue/bottom.jsp" %>