<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-03(003)
  Time: 오후 4:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>detail</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <div class="header_container">
        <div class="logo_container">
            <a href="/">jjinka-Pub</a>
        </div>
    </div>
</header>
<table>
    <tr>
        <th>유저 번호</th>
        <td>${userList.userNo}</td>
    </tr>
    <tr>
        <th>유저 이름</th>
        <td>${userList.userName}</td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td>${userList.phoneNumber}</td>
    </tr>
    <tr>
        <th>잔여 포인트</th>
        <td><c:out value="${user.userPoint}">0</c:out></td>
    </tr>
</table>
<button onclick="updateFn()">수정</button>
</body>
<script>
    const updateFn = () => {
        const userNo = '${userList.userNo}';
        location.href = "/user/userUpdate?userNo=" + userNo;
    }
</script>
</html>