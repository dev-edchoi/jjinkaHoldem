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
</head>
<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>
<div class="buttons-container">
    <button class="button" onclick="updateFn()">유정 정보 수정</button>
    <button class="button" onclick="listFn()">유저 목록</button>
</div>
<div class="container">
    <div class="game-info">
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
</div>
<form action="/user/userUpdatePoint" method="post" name="userPointUpdate">
    <input type="hidden" name="userNo" value="${userList.userNo}">
    <div class="buttons-container">
        <label for="userPoint" style="font-size: 16px; margin-top: 4px"> 포인트 수정 :</label>
        <input name="userPoint" id="userPoint" type="number" value="0" style="width: 150px;" readonly/>
        <button type="button" class="button" id="userPointUpdate" onclick="userUpdatePoint()" style="margin-right: 20px">확인</button>
        <input type="number" id="point" value="0" onblur="updatePoint(value)" style="width: 150px" />
        <button type="button" class="button" id="minus3M" value="-30000" onclick="updatePoint(value)">-30,000</button>
        <button type="button" class="button" id="plus3M" value="+30000" onclick="updatePoint(value)">+30,000</button>
        <button type="button" class="button" id="minus5M" value="-50000" onclick="updatePoint(value)">-50,000</button>
        <button type="button" class="button" id="plus5M" value="+50000" onclick="updatePoint(value)">+50,000</button>
    </div>
</form>
<div>
    <table class="brown-table">
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