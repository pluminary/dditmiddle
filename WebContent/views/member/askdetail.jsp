<%@page import="kr.or.ddit.member.vo.askVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/views/inclue/top.jsp" %>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        h2 {
            color: #333;
        }
        .metadata {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 20px;
        }
        .content {
            margin-bottom: 20px;
        }
		
		.inbtn {
			width: 100px;
    		height: 35px;
		}
    </style>
</head>
<body>
<div class="container">
<%-- <% askVO askboard=(askVO)request.getAttribute("askboard") %> --%>
    <c:set var="askboard" value="${requestScope.askboard}" />
    <h2>${askboard.askTitle}</h2>
    <div class="metadata">
        <span>작성자 : ${askboard.memNick}</span> |
        <span>${askboard.askDate}</span> |
        <span>문의유형: ${askboard.askClass}</span>
    </div>
    <div class="content">
        <p>${askboard.askContent}</p>
    </div>
   
      <%-- 답변 입력 폼 --%>
    <div class="comment">
        <form action="<%=request.getContextPath() %>/admin/reply.do" method="post">
            <textarea name="askAnswer" rows="4" cols="50"></textarea><br>
            <input type="hidden" name="askNo" value="${askboard.askNo}">
            <input type="submit" value="답변" class="inbtn">
        </form>
    </div>

    <a href="askList.do">목록</a>
    <a href="javascript:deleteBoard('<%=request.getContextPath()%>/admin/askDelete.do?no=${askboard.askNo}');">삭제</a>
</div>
<script>
	function deleteBoard(url){
		if(confirm('정말로 삭제하시겠습니까?')){
			alert('게시물이 삭제되었습니다.');
			location.href = url;
		}
	}
</script> 
<%@include file="/views/inclue/bottom.jsp" %>
