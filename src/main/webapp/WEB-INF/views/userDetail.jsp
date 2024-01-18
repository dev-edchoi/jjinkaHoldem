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
            <a href="/">jjinka-Pub</a>
        </div>
    </div>
</header>
<button onclick="updateFn()">수정</button>
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
        <td>${userList.userPoint}</td>
    </tr>
</table>
<form action="/user/userUpdatePoint" method="post" name="userPointUpdate">
    <input type="hidden" name="userNo" value="${userList.userNo}">
    <label for="userPoint">포인트 수정 : <input name="userPoint" id="userPoint" type="number" value="0" readonly style="border:none; outline:none;"/></label>

    <input type="button" class="btn" id="minus3M" value="-30000" onclick="updatePoint(value)"/>
    <input type="button" class="btn" id="plus3M" value="+30000" onclick="updatePoint(value)"/>
    <input type="button" class="btn" id="minus5M" value="-50000" onclick="updatePoint(value)"/>
    <input type="button" class="btn" id="plus5M" value="+50000" onclick="updatePoint(value)"/>
    <input type="number" class="btn" id="point" value="0" onblur="updatePoint(value)"/>

    <input type="button" class="btn" id="userPointUpdate" value=확인 onclick="userUpdatePoint()"/>
</form>
<div>
    <table>
        <tr>
            <th>잔여 포인트</th>
            <th>게임 일자</th>
        </tr>
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
        console.log(parseInt(point));
        let userPoint = document.getElementById("userPoint").value;
        console.log(${userList.userPoint});
        if(userPoint === "0"){
            userPoint = 0;
        } else {
            userPoint = parseInt(userPoint);
        }
            userPoint += parseInt(point);

        document.getElementById("userPoint").value = userPoint;
    }

    const userUpdatePoint = () => {
        alert(document.getElementById("userPoint").value);
        document.userPointUpdate.submit();
    }

</script>
</html>