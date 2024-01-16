<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-16(016)
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>detail</title>
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
<button onclick="updateFn()">수정</button>
<table>
    <tr>
        <th>게임 번호</th>
        <td>1</td>
    </tr>
    <tr>
        <th>테이블 번호</th>
        <td>3</td>
    </tr>
    <tr>
        <th>참여자 수</th>
        <td>5</td>
    </tr>
    <tr>
        <th>리워드 포인트</th>
        <td>150000</td>
    </tr>
</table>
<br><br>
<H1>참여 유저</H1>
<br><br>
<div>
    <table>
        <tr>
            <th>유저</th>
            <th>포인트</th>
        </tr>
        <tr>
            <td>유저1</td>
            <td>30000</td>
        </tr>
        <tr>
            <td>유저2</td>
            <td>30000</td>
        </tr>
        <tr>
            <td>유저3</td>
            <td>30000</td>
        </tr>
    </table>
</div>
</body>
<script>

</script>
</html>
