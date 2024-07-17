<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
alert("로그인에 실패했습니다 다시 시도해주세요");
window.location.href=("<%=request.getContextPath() + "/login.do" %>");
</script>
</head>
<body>

</body>
</html>