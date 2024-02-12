
<%--
  Created by IntelliJ IDEA.
  User: ddilg
  Date: 2024-01-28
  Time: 오후 3:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/makeGame.css">
</head>
<body>
<div class="container">
    <form action="/game/gameUpdate" method="post" name="updateForm">
        <input type="hidden" name="gameNo" value="${game.gameNo}" readonly>
        <h1>User Information</h1>

        <label for="tableNo">테이블 번호:</label>
        <input type="number" id="tableNo" name="tableNo" value="${game.tableNo}" readonly>

        <label for="gameType">게임 유형:</label>
        <select id="gameType" name="gameType" disabled>
            <option value="0">=== 선택 ===</option>
            <option value="1">고정 상금</option>
            <option value="2">변동 상금</option>
        </select>

        <label for="gameReward">상금:</label>
        <input type="number" id="gameReward" name="gameReward" value="${game.gameReward}">

        <label for="gameFee">참가 비용:</label>
        <input type="number" id="gameFee" name="gameFee" value="${game.gameFee}">

        <label for="rewardRate">상금 비율:</label>
        <input type="number" id="rewardRate" name="rewardRate" value="${game.rewardRate}">

        <input type="button" value="수정" onclick="fnGameUpdate()">
        <input type="button" value="취소" onclick="listFn('${game.gameNo}')">
    </form>
</div>
<script>
    window.onload = function () {
        let gameType = ${game.gameType};

        document.getElementsByName('gameType')[0].value= gameType;

        fnChkGameType();
    }

    function fnGameUpdate() {
        if(confirm("게임 정보를 수정하시겠습니까?")){
            document.updateForm.submit();
        } else {
            return false;
        }
    }

    const listFn = (gameNo) => {
        location.href = "/game?gameNo=" + gameNo;
    }

    const fnChkGameType = () => {
        let gameType = document.getElementById('gameType');
        let gameReward = document.getElementById('gameReward');
        let rewardRate = document.getElementById('rewardRate');

        if (gameType.value === '1') {
            gameReward.disabled = false;
            rewardRate.disabled = true;
        } else if (gameType.value === '2') {
            gameReward.disabled = true;
            rewardRate.disabled = false;
        }
    }
</script>
</body>
</html>
