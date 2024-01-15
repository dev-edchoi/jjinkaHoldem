<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-03(003)
  Time: 오후 3:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/table.css">
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
        <th>No.</th>
        <th>회원 전화번호</th>
        <th>회원 이름</th>
        <th>잔여 포인트</th>
        <th>가입 일자</th>
        <th>조회</th>
        <th>삭제</th>
    </tr>
    <c:forEach items="${userList}" var="user">
        <tr>
            <td>${user.userNo}</td>
            <td>
                <a href="/user?userNo=${user.userNo}">${user.phoneNumber}</a>
            </td>
            <td>${user.userName}</td>
            <td><c:out value="${user.userPoint}">0</c:out></td>
            <td>${user.registDate}</td>
            <td>
                <a href="/user?userNo=${user.userNo}">조회</a>
            </td>
            <td>
                <button onclick="deleteMember('${user.userNo}')">회원 삭제</button>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
<script>
    const deleteMember = (userNo) => {
        console.log(userNo);
        location.href = "/user/delete?userNo="+userNo;
    }
</script>
</html>