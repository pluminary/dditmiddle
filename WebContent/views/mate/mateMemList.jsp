<%@page import="kr.or.ddit.common.PageVO"%>
<%@page import="kr.or.ddit.mate.vo.MateMemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>



<%
	List<MateMemberVO> memList = (List<MateMemberVO>)request.getAttribute("memList");
	Integer cnt = (Integer) request.getAttribute("cnt");
	PageVO pgv = (PageVO)request.getAttribute("pv");
	String clubNo = (String) request.getAttribute("clubNo");
%>      
<%
	MateVO mv = (MateVO)request.getAttribute("mv");
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
				    <li class="on"><a href="<%=request.getContextPath() %>/mate/memberList.do?clubNo=<%=mv.getClubNo()%>" >멤버</a></li>
				    <li><a href="<%=request.getContextPath() %>/mate/noticelist.do?clubNo=<%=mv.getClubNo()%>">공지사항</a></li>
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
                            <col width="10%" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th></th>
							 	<th>번호</th>
							 	<th>닉네임</th>
							 	<th>등급</th>
							 	<th>이름</th>
							 	<th>전화번호</th>
							 	<th>가입일</th>
                            </tr>
                        </thead>
                        <tbody>
					<%
						for(MateMemberVO mateVO : memList){
					%>		
							<tr>
					<%
							if(mateVO.getHeadYn().equals("Y")){
					%>			
								<td class="incheckshow"><input type="checkbox" disabled></td>
					<%
							}else{
					%>
								<td class="incheckshow"><input class="checkbox" type="checkbox" value="<%=mateVO.getMemNo() %>"></td>
					<%
							}
					%>
								<td><%=mateVO.getRnum() %></td>	
								<td class="ti" style="text-align: center;"><%=mateVO.getMemNick() %></td>
								<td><%=mateVO.getLevelName() %></td>	
								<td><%=mateVO.getMemName() %></td>	
								<td><%=mateVO.getMemPhone() %></td>	
								<td><%=mateVO.getJoinDate() %></td>	
							</tr>
					<%
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
					                    <a href="memberList.do?pageNo=<%= pgv.getPageNo() - 1 %>&clubNo=<%=mv.getClubNo()%>">Prev</a>
					                </li>
					            <% }
					
					            // 페이지 번호 링크
					            for(int i=pgv.getStartPage(); i<=pgv.getEndPage(); i++) { %>
					                <li class="num <%= pgv.getPageNo() == i ? "on" : "" %>">
					                    <a href="memberList.do?pageNo=<%= i %>&clubNo=<%=mv.getClubNo()%>"><%= i %></a>
					                </li>
					            <% }
					
					            // 다음 페이지로 이동하는 링크
					            if(pgv.getPageNo() < pgv.getTotalPage()) { %>
					                <li class="next">
					                    <a href="memberList.do?pageNo=<%= pgv.getPageNo() + 1 %>&clubNo=<%=mv.getClubNo()%>">Next</a>
					                </li>
					            <% } 
					        } %>
					    </ul>
					</div>
			<%
				int memNo = Integer.parseInt(mv.getMemNo());
				if(memNo == user.getMemNo()){
			%>
                    <!-- 버튼 영역 -->
                    <div class="btn_area">
                        <div class="btn">
                            <button id="forceDelete">강제탈퇴</button>
                        </div>
                    </div>
            <% } %>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- // Content -->



<script type="text/javascript">
// "forceDelete" 버튼을 클릭했을 때의 동작을 정의합니다.
document.getElementById("forceDelete").addEventListener('click', function() {
    var checkedValue = ''; // 선택된 체크박스의 값을 저장할 변수를 초기화합니다.
    var checkedCount = 0; // 체크된 체크박스의 개수를 저장할 변수를 초기화합니다.
    
    // 모든 체크박스를 확인하며, 체크된 체크박스의 값을 변수에 저장합니다.
    var checkboxes = document.getElementsByClassName("checkbox");
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checkedValue = checkboxes[i].value;
            checkedCount++; // 체크된 개수를 증가시킵니다.
        }
    }
    
    // 체크된 체크박스의 개수가 1개가 아니라면 알림을 표시하고 함수를 종료합니다.
    if (checkedCount !== 1) {
        alert("한 명의 멤버를 선택해주세요.");
        return;
    }
    
    // 강제탈퇴 여부를 확인하고, 확인이 되면 강제탈퇴를 실행합니다.
    var confirmed = confirm('선택한 멤버를 강제탈퇴하시겠습니까?');
    if (confirmed) {
        // 선택된 멤버의 번호를 문자열로 변환하여 URL에 추가합니다.
        var clubNo = '<%=clubNo%>'; // 서버에서 전달받은 clubNo 값
        var url = '<%=request.getContextPath()%>/mate/forceDelete.do?no=' + checkedValue + '&clubNo=' + clubNo;
        location.href = url;
    }
});


</script>
