<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="kr.or.ddit.member.vo.askVO"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %> 
    <title>1:1 문의게시글 상세보기</title>
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
        a2 {
            text-decoration: none;
            color: #007BFF;
            margin-right: 10px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
<%-- <% askVO askboard=(askVO)request.getAttribute("askboard") %> --%>
    <c:set var="askboard" value="${requestScope.askboard}" />
    <h1>${askboard.askTitle}</h1>
    <div class="metadata">
        <span>작성자 : ${askboard.memNick}</span> |
        <span>${askboard.askDate}</span> |
        <span>문의유형: ${askboard.askClass}</span>
    </div>
    <div class="content">
        <p>${askboard.askContent}</p>
    </div>

    <a href="askList.do?memNo=<%=user.getMemNo()%>">목록</a>
    <a href="askupdate.do?no=${askboard.askNo}">수정</a>
    <a href="javascript:deleteBoard('<%=request.getContextPath()%>/member/askDelete.do?no=${askboard.askNo}');">삭제</a>
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
