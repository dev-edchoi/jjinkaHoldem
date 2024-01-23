<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-03(003)
  Time: 오후 4:03
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
            <a href="/">ALPHA</a>
        </div>
    </div>
</header>
<div>
    <button class="defaultBtn" onclick="updateFn()">유정 정보 수정</button>
    <button class="defaultBtn" onclick="listFn()">유저 목록</button>
</div>
<div>
    <table class="brown-table">
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
            <td>${userList.userPoint}</td>
        </tr>
    </table>
</div>
<form action="/user/userUpdatePoint" method="post" name="userPointUpdate">
    <div style="margin-top: 10px">
        <input type="hidden" name="userNo" value="${userList.userNo}">
        <label for="userPoint" style="font-size: 12px; font-family: Oswald, sans-serif;">
            포인트 수정 : <input name="userPoint" id="userPoint" type="number" value="0" readonly
                            class="defaultSmallBtn" style="border:none; outline:none;"/>
        </label>
    </div>
    <div style="margin-top: 10px">
        <input type="number" class="defaultSmallBtn" id="point" value="0" onblur="updatePoint(value)"
               placeholder="금액을 입력해주세요."/>
        <input type="button" class="defaultSmallBtn" id="userPointUpdate" value=확인 onclick="userUpdatePoint()"/>
        <input type="button" class="defaultSmallBtn" id="minus3M" value="-30000" onclick="updatePoint(value)"/>
        <input type="button" class="defaultSmallBtn" id="plus3M" value="+30000" onclick="updatePoint(value)"/>
        <input type="button" class="defaultSmallBtn" id="minus5M" value="-50000" onclick="updatePoint(value)"/>
        <input type="button" class="defaultSmallBtn" id="plus5M" value="+50000" onclick="updatePoint(value)"/>
    </div>
</form>
<div>
    <table>
        <thead>
        <tr>
            <th>변동 금액</th>
            <th>변동 일자</th>
        </tr>
        </thead>
        <c:forEach items="${userPoint}" var="userPoint">
            <tr>
                <td>${userPoint.point}</td>
                <td>${userPoint.date}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    const updateFn = () => {
        const userNo = '${userList.userNo}';
        location.href = "/user/userUpdate?userNo=" + userNo;
    }

    const updatePoint = (point) => {
        let userPoint = document.getElementById("userPoint").value;
        if (userPoint === "0") {
            userPoint = 0;
        } else {
            userPoint = parseInt(userPoint);
        }
        userPoint += parseInt(point);

        document.getElementById("userPoint").value = userPoint;
    }

    const userUpdatePoint = () => {
        document.userPointUpdate.submit();
    }

    const listFn = () => {
        const page = '${page}';
        location.href = "/user/?page=" + page;
    }
</script>
</html>