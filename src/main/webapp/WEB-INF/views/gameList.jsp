<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-16(016)
  Time: 오후 3:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게임 목록</title>
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
<div>
    <button onclick="makeGame()" class="defaultBtn">게임 생성</button>
    <br><br>
    <table>
        <tr>
            <th>Game No.</th>
            <th>테이블 번호</th>
            <th>보상 비율</th>
            <th>게임 현황</th>
            <th>게임 시작 날짜</th>
        </tr>
        <c:forEach items="${gameList}" var="game">
            <tr onclick="location.href='/game?gameNo=${game.gameNo}'">
                <td>${game.gameNo}</td>
                <td>${game.tableNo}</td>
                <td>${game.rewardRate}</td>
                <c:choose>
                    <c:when test="${game.isEnd == 0}">
                        <td>
                            <button onclick="">게임 종료</button>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>게임 종료</td>
                    </c:otherwise>
                </c:choose>
                <td>${game.makeDate}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    const makeGame = () => {
        location.href = "/game/makeGame";
    }
</script>
</html>
