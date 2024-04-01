<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-04-01(001)
  Time: 오전 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jin/totalPoint.css">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <title>User Stats</title>
</head>
<body>
    <div class="container">
        <h1>유저 전체</h1>
        <br/>
        <br/>
        <div class="user-points">
            전체 회원 수: <span class="total-points">${cntMember}</span> 명
        </div>
        <div class="user-points">
            전체 포인트: <span class="total-points">${cntUserPoint}</span>
        </div>
    </div>
</body>
</html>
