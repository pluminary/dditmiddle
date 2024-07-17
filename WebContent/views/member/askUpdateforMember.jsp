<%@page import="kr.or.ddit.member.vo.askVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.FreeBoardVO"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!-- 헤더 영역 -->
<%@include file="/views/inclue/top.jsp" %> 
    <script type="text/javascript">
        function cancelEdit() {
            if (confirm("수정을 취소하시겠습니까?")) {
                alert("작업이 취소되었습니다.");
                window.location.href = "${pageContext.request.contextPath}/member/askList.do"; // 여기에 목록 페이지의 URL을 입력하세요.
            }
        }

        function validateForm() {
            var title = document.getElementById("title").value.trim();
            var content = document.getElementById("content").value.trim();
            
            if(title === "") {
                alert("제목을 입력해주세요");
                return false;
            }
            if(content === "") {
                alert("내용을 입력해주세요");
                return false;
            }
            // 서버로 폼 데이터를 제출하기 전에 추가적인 유효성 검사를 수행할 수 있습니다.
            return true; // 모든 검사를 통과하면 true를 반환하여 폼 제출을 계속합니다.
        }
    </script>
    <style type="text/css">
    .container {
            width: 80%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
<h2>1:1문의게시판 수정</h2>

<%
	askVO mv = (askVO) request.getAttribute("board");
%>

<form action="${pageContext.request.contextPath}/member/askupdate.do" method="POST" onsubmit="return validateForm();">
	<input type="hidden" name="no" value="<%=mv.getAskNo()%>">
    <div>
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="<%=mv.getAskTitle() %>" required>
    </div>
    <div>
        <label for="content">내용:</label>
        <textarea id="content" name="content" required><%=mv.getAskContent() %></textarea>
    </div>
    <button type="button" onclick="cancelEdit();">취소</button>
    <button onclick="alert('저장이 완료되었습니다.')" type="submit">저장</button>
</form>
</div>

<%@include file="/views/inclue/bottom.jsp" %>
