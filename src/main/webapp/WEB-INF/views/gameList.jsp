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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/paging.css">
</head>
<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>
<div>
    <div class="buttons-container">
        <button onclick="makeGame()" class="button">게임 생성</button>
    </div>

    <div style="margin-top: 20px">
        <table class="brown-table">
            <tr>
                <th>Game No.</th>
                <th>테이블 번호</th>
                <th>게임 참가 비용</th>
                <th>총 게임 비용</th>
                <th>보상 비율</th>
                <th>상금</th>
                <th>게임 현황</th>
                <th>게임 시작 날짜</th>
            </tr>
            <c:forEach items="${gameList}" var="game">
                <tr>
                    <td onclick="location.href='/game?gameNo=${game.gameNo}&page=${paging.page}'">${game.gameNo}</td>
                    <td onclick="location.href='/game?gameNo=${game.gameNo}&page=${paging.page}'">${game.tableNo}</td>
                    <td onclick="location.href='/game?gameNo=${game.gameNo}&page=${paging.page}'">${game.gameFee}</td>
                    <td onclick="location.href='/game?gameNo=${game.gameNo}&page=${paging.page}'">${game.totalGameFee}</td>
                    <td onclick="location.href='/game?gameNo=${game.gameNo}&page=${paging.page}'">${game.rewardRate}</td>
                    <td onclick="location.href='/game?gameNo=${game.gameNo}&page=${paging.page}'">${game.gameReward}</td>
                    <c:choose>
                        <c:when test="${game.isEnd == 0}">
                            <td>
                                <button class="table-button" onclick="fnGameSet('${game.gameNo}')">게임 종료</button>
                            </td>
                        </c:when>
                        <c:otherwise>
                            <td>게임이 종료됐습니다.</td>
                        </c:otherwise>
                    </c:choose>
                    <td>${game.makeDate}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<div class="wrap">
    <div class="pagination">
        <c:choose>
            <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
            <c:when test="${paging.page<=1}">
                <span>[이전]</span>
            </c:when>
            <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
            <c:otherwise>
                <a href="/game/gameList?page=${paging.page-1}">[이전]</a>
            </c:otherwise>
        </c:choose>

        <%--  for(int i=startPage; i<=endPage; i++)      --%>
        <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
            <c:choose>
                <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                <c:when test="${i eq paging.page}">
                    <span class="active">${i}</span>
                </c:when>

                <c:otherwise>
                    <a href="/game/gameList?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${paging.page>=paging.maxPage}">
                <span>[다음]</span>
            </c:when>
            <c:otherwise>
                <a href="/game/gameList?page=${paging.page+1}">[다음]</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
<script>
    const makeGame = () => {
        location.href = "/game/makeGame";
    }

    const fnGameSet = (gameNo) => {
        console.log(gameNo);
        if (confirm("해당 게임을 종료하겠습니까?")) {
            $.ajax({
                type: "post",
                url: "/game/gameSet",
                data: {
                    "gameNo": parseInt(gameNo)
                },
                success: function (res) {
                    console.log(res);
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        } else {
            return false;
        }
    }
</script>
</html>
