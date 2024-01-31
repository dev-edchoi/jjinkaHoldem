<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-05(005)
  Time: 오전 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ALPHA</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/makeGame.css">
</head>
<body>
<div class="container">
    <h2 style="text-align: center; color: #4e342e;">게임 정보 입력</h2>
    <form action="/game/makeGame" method="post" class="makeGame" name="makeGameForm">
        <label for="tableNo">테이블 번호:</label>
        <select id="tableNo" name="tableNo" required>
            <option value="0">=== 선택 ===</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>

        <label for="gameType">게임 유형:</label>
        <select id="gameType" name="gameType" onchange="toggleInputs()" required>
            <option value="0">=== 선택 ===</option>
            <option value="1">고정 상금</option>
            <option value="2">변동 상금</option>
        </select>

        <label for="gameReward">상금:</label>
        <input type="number" id="gameReward" name="gameReward" placeholder="상금을 입력하세요.">

        <label for="gameFee">참가 비용:</label>
        <input type="number" id="gameFee" name="gameFee" placeholder="참가 비용을 입력하세요">

        <label for="rewardRate">상금 비율:</label>
        <input type="number" id="rewardRate" name="rewardRate" placeholder="상금 비율을 입력하세요">

        <input type="button" value="게임 만들기" onclick="fnMakeGame()">
        <input type="button" value="취소" onclick="listFn()">
    </form>
</div>
</body>
<script>
    const fnMakeGame = () => {
        let sTableNo = document.getElementById("tableNo").value;
        console.log("테이블 번호 : " + sTableNo);
        if(sTableNo === "0"){
            alert("테이블 번호를 선택 해 주세요.");
            return false;
        } else {
            fnChkGame(sTableNo);
        }
    }

    const fnChkGame = (tableNo) => {
        $.ajax({
            type: "post",
            url: "/game/chkInGame",
            data: {
                "tableNo": tableNo
            },
            success: function (res) {
                if(res === "ok"){
                    document.makeGameForm.submit();
                } else {
                    alert("해당 테이블은 게임 중 입니다.")
                }
            },
            error: function (err) {
                console.log("에러 발생", err);
                return false;
            }
        });
    }

    const listFn = () => {
        location.href = "/game/gameList";
    }

    const toggleInputs = () => {
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
</html>