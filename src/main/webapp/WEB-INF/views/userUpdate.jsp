<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-11(011)
  Time: 오전 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>update.jsp</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<header>
    <div class="header_container">
        <div class="logo_container">
            <a href="/">ALPHA</a>
        </div>
    </div>
</header>
<body>
<form action="/user/userUpdate" method="post" name="updateForm">
    <input type="hidden" name="userNo" value="${user.userNo}" readonly>
    <input type="text" name="userName" value="${user.userName}" readonly>
    <input type="text" name="userPoint" value="${user.userPoint}">
    <input type="button" value="수정" onclick="updateReqFn()">
</form>
</body>
<script>
    const updateReqFn = () => {
        document.updateForm.submit();
    }
</script>
</html>