<%@page import="kr.or.ddit.mate.vo.MBoardFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.mate.vo.MateBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/views/inclue/top.jsp" %>    
<%
	MateBoardVO mv = (MateBoardVO)request.getAttribute("bList");
	List<MBoardFileVO> file = (List<MBoardFileVO>)request.getAttribute("file");
%>


<!-- Content -->
<section id="con_board" class="conBody">
    
    
    <div class="contents mt10">
        <div class="inner">
			<!-- 타이틀  -->
			<div id="" class="tit_wrap">
		        <h2><%=mv.getCbTitle() %></h2>
		        <ul>
		            <li class="writer"><%=mv.getMemNick() %></li>
		            <li><%=mv.getCbRegDate() %></li>
		            <li>조회 <%=mv.getCbCount() %></li>
		        </ul>
		    </div>
			
			<div class="contents board">
			    <div class="inner">
			        <div class="v_con">
			            <div class="board_con">
			            	<div class="img_wrap">
			            	<%
								if(file != null){
									for(MBoardFileVO fv : file){
							%>			
								<img alt="<%=fv.getCbfileName() %>" src="<%=request.getContextPath() %>/imageView.do?fileNo=<%=fv.getCbfileNo()%>"><br>
							<%
									}
								}
							%>
							</div>
			                <pre><%=mv.getCbContent() %></pre>
			            </div>
			        </div>
			        <div class="btn">
			            <button id="list">목록</button>
			        <%
					
					if( user != null && mv.getMemNo() == user.getMemNo()){
					%>    
						<button id="update">수정</button>
						<button id="delete">삭제</button>
					<% } %>	
			        </div>
			    </div>
			</div>
			

        </div>
    </div>
</section>
<!-- // Content -->







<script type="text/javascript">
	var clubNo = '<%=mv.getClubNo()%>';
	$('#list').on('click', function() {
		location.href='<%=request.getContextPath() %>/mate/boardList.do?clubNo='+clubNo;
	});
	$('#update').on('click', function() {
		location.href="<%=request.getContextPath() %>/mate/boardUpdate.do?no=<%=mv.getCbNo() %>&clubNo="+clubNo;
	});
	$('#delete').on('click', function() {
	    if (confirm('정말 삭제하시겠습니까?')) {
	        location.href = "<%=request.getContextPath() %>/mate/boardDelete.do?no=<%=mv.getCbNo() %>&clubNo="+clubNo;
	    }
	});
</script>
<%@include file="/views/inclue/bottom.jsp" %>