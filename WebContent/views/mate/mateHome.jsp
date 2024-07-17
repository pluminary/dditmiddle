<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="kr.or.ddit.mate.vo.MateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %>

<%
	MateVO mv = (MateVO)request.getAttribute("mv");
	MemberVO ld = (MemberVO)request.getAttribute("leader");
%>

<!-- Content -->
<section id="con_board" class="conBody tab club">
            
	<div id="" class="tit_wrap pt90">
		<h2><a href=""><%= mv.getClubName() %></a></h2>
		<ul>
			<li class="writer"><%=mv.getAthlName() %> · <%=mv.getClubFarea() %> · <%=mv.getClubAge() %></li>
		</ul>
	</div>
   
	<div class="contents mt60">
		<div class="inner">
			<div class="club_tab">
			<ul>
			    <li class="on"><a href="">메인</a></li>
			    <li><a href="" id="memberList">멤버</a></li>
			    <li><a href="" id="notice">공지사항</a></li>
			    <li><a href="" id="board">게시판</a></li>
			</ul>
           </div>

           <div class="v_con" style="border: 0">

               <div class="ui vlist__bodo type1">
                   <div class="obj col1">
                       <div class="item aos-init aos-animate">
                           <div class="inner">
                               <div class="title_box">
                                   <span class="ir ir-icon__line icon3"></span>
                                   <strong>동호회장</strong>
                               </div>
                               <div class="ui-bodo__summary">
                                   <div class="text_box">
                                       <div class="list-1st">
                                           <div>
                                               <a href="" id="leader"><%=ld.getMemNick() %></a>
                                           ​</div>
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <div class="item aos-init aos-animate">
                           <div class="inner">
                               <div class="title_box">
                                   <span class="ir ir-icon__line icon2"></span>
                                   <strong>멤버수/정원</strong>
                               </div>
                               <div class="ui-bodo__summary">
                                   <div class="text_box">
                                       <div class="list-1st">
                                           <div>
                                               <%=mv.getClubCurrmem() %>/<%=mv.getClubTotalmem() %>
                                               <% if("Y".equals(mv.getClubEndyn()) || mv.getClubCurrmem() >= mv.getClubTotalmem()) { %>
						                             <span class="badge" style="margin-left:20px">모집마감</span>
								                <% } else { %>
								                     <span class="badge on" style="margin-left:20px">모집중</span>
								                <% } %>
                                            ​</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item aos-init aos-animate">
                            <div class="inner">
                                <div class="title_box">
                                    <span class="ir ir-icon__line icon4"></span>
                                    <strong>주 활동시간</strong>
                                </div>
                                <div class="ui-bodo__summary">
                                    <div class="text_box">
                                        <div class="list-1st">
                                            <div>
                                               	<%=mv.getClubFtzone() %>
                                            ​</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item aos-init aos-animate">
                            <div class="inner">
                                <div class="title_box">
                                    <span class="ir ir-icon__line icon5"></span>
                                    <strong>비고</strong>
                                </div>
                                <div class="ui-bodo__summary">
                                    <div class="text_box">
                                        <div class="list-1st">
                                            <div>
                                                <%=mv.getClubMemo() == null ? "" : mv.getClubMemo() %>
                                            ​</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="btn">
            	<%
// 					MemberVO user = (MemberVO)request.getSession().getAttribute("user");
					int userNo = user.getMemNo();
					if(userNo == ld.getMemNo() ){
				%>
                <a href="" id="update">정보 수정</a>
                <%
					}
				%>
                <a href="" id="leave">동호회 탈퇴</a>
            </div>
        </div>
    </div>
    
    <!-- 팝업 -->
    <div id="pop" class="mate_pop cm" style="display:none;">
		<div class="box">
			<button class="c_btn" onclick="closeModal()">
				<span class="sp01"></span>
				<span class="sp02"></span>
			</button>
           	<h2>동호회장</h2>
			<div class="wrap">
				<div id="pop_con">
					<table>
						<colgroup>
							<col width="30%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
							    <th>동호회명</th>
							    <td><%=mv.getClubName() %></td>
							</tr>
							<tr>
							    <th>이름</th>
							    <td><%=ld.getMemName() %></td>
							</tr>
							<tr>
							    <th>닉네임</th>
								<td><%=ld.getMemNick()  %></td>
							</tr>
							<tr>
							    <th>연락처</th>
								<td><%=ld.getMemPhone() %></td>
							</tr>
						</tbody>
					</table>
				</div>
	         </div>
        </div>
    </div>
    
    
</section>
<!-- // Content -->




<script type="text/javascript">
	//동호회장 클릭 시 모달 표시
	$('#leader').on('click', function(event){
	    event.preventDefault(); // 링크의 기본 동작 방지
	    $('#pop').show(); // 모달 표시
	});
	
	// 모달 닫기 버튼 클릭 시 모달 숨김
	$('.c_btn').on('click', function(event){
	    event.preventDefault(); // 버튼의 기본 동작 방지
	    $('#pop').hide(); // 모달 숨김
	});
	
	// 정보 수정, 동호회 탈퇴 등 다른 버튼 이벤트도 기본 동작을 방지해야 할 경우
	$('#update, #leave, #memberList, #notice, #board ').on('click', function(event){
	    event.preventDefault();
	    // 여기에 버튼 클릭 시 실행할 코드 추가
	});




	
	$('#update').on('click', function(){
		var clubNo = '<%=mv.getClubNo()%>';
		location.href='<%=request.getContextPath()%>/mate/update.do?clubNo='+clubNo;
	})
	$('#leave').on('click', function(){
	      // 사용자에게 확인 다이얼로그 표시
	      var confirmed = confirm('정말 탈퇴하시겠습니까?');
	        
	      // 사용자가 확인을 클릭한 경우에만 탈퇴 처리를 진행
	      if (confirmed) {
	          var clubNo = '<%=mv.getClubNo()%>';
	          location.href = '<%=request.getContextPath()%>/mate/delete.do?clubNo=' + clubNo;
	      }
	})
	// 멤버, 공지사항, 게시판 가기
	$(document).ready(function(){
        var clubNo = '<%=mv.getClubNo()%>';
        $('#memberList').on('click', function(){
            location.href = '<%=request.getContextPath()%>/mate/memberList.do?clubNo=' + clubNo;
        });
        $('#notice').on('click', function(){
            location.href = '<%=request.getContextPath()%>/mate/noticelist.do?clubNo=' + clubNo;
        });
        $('#board').on('click', function(){
            location.href = '<%=request.getContextPath()%>/mate/boardList.do?clubNo=' + clubNo;
        });
    });
</script>







<%@include file="/views/inclue/bottom.jsp" %>