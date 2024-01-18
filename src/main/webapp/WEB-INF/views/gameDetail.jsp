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
<div>
    <button onclick="updateFn()">수정</button>
    <table>
        <tr>
            <th>게임 번호</th>
            <td>${gameList.gameNo}</td>
        </tr>
        <tr>
            <th>테이블 번호</th>
            <td>${gameList.tableNo}</td>
        </tr>
        <tr>
            <th>참가 비용</th>
            <td>${gameList.gameFee}</td>
        </tr>
        <tr>
            <th>보상 비율</th>
            <td>${gameList.rewardRate}</td>
        </tr>
        <tr>
            <th>리워드 포인트</th>
            <td>${gameList.makeDate}</td>
        </tr>
        <tr>
            <th>게임 생성 시각</th>
            <td>${gameList.makeDate}</td>
        </tr>
    </table>
    <div>
        <label for="searchUser"> 유저 검색 :
            <input type="text" id="searchUser" name="userName" onblur="userSearch()"/>
        </label>
        <input type="submit" class="btn" id="btnSearchUser" value="회원 검색" onclick="userSearch()"/>
    </div>
    <div id="searchList">
    </div>
    <br>
    <H1>참여 유저</H1><br>
    <div>
        <label for="totalGamerCnt">총 참여 수 : <input type="number" id="totalGamerCnt" readonly
                                                   style="border:none; outline:none;"></label>
    </div>

    <div>
        <label for="totalReward">총 참여 수 : <input type="number" id="totalReward" readonly
                                                 style="border:none; outline:none;"></label>
    </div>
    <div id="gamerList">
        <table id='gamerTable'>
            <tr>
                <th>회원 번호</th>
                <th>참가자 이름</th>
                <th>참여 횟수</th>
                <th>추가 참여</th>
                <th>게임 종료</th>
                <th>참여 시간</th>
            </tr>
            <c:forEach items="${gameJoiner}" var="joiner">
                <tr>
                    <td>${joiner.userNo}</td>
                    <td>${joiner.userName}</td>
                    <td>${joiner.gameTime}</td>
                    <td>
                        <button onclick="oneMoreGameCnt('${joiner.userNo}')">추가 참여</button>
                    </td>
                    <td>
                        <button onclick="gameSet('${joiner.userNo}')">게임 종료</button>
                    </td>
                    <td>${joiner.joinTime}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
<script>
    const userSearch = () => {
        const userName = document.getElementById("searchUser").value;

        $.ajax({
            type: "post",
            url: "/user/findByUserName",
            data: {
                "userName": userName
            },
            success: function (res) {
                let output = "<table>";
                output += "<tr><th>번호</th>";
                output += "<th>이름</th>";
                output += "<th>전화번호</th>";
                output += "<th>게임 참가</th>";

                for (let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].userNo + "</td>";
                    output += "<td>" + res[i].userName + "</td>";
                    output += "<td>" + res[i].phoneNumber + "</td>";
                    //output += "<td><a href='/user?userNo=" + res[i].userNo + "'>참가</a></td>";
                    output += "<td><button onclick='ChkJoiner(" + res[i].userNo + ")'>" + "게임 참가" + "</button></td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('searchList').innerHTML = output;
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }

    const ChkJoiner = (userNo) => {
        let gameNumber = '${gameList.gameNo}';
        $.ajax({
            type: "post",
            url: "/game/chkJoiner",
            data: {
                "userNo": userNo,
                "gameNo": gameNumber
            },
            success: function (res) {
                if (res === "ok") {
                    gamerJoin(userNo);
                } else {
                    alert("이미 참여 중 입니다.")
                }
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }

    const gamerJoin = (userNo) => {
        let gameNumber = '${gameList.gameNo}';
        $.ajax({
            type: "post",
            url: "/game/gamerJoin",
            data: {
                "userNo": userNo,
                "gameNo": gameNumber
            },
            success: function (res) {
                reloadGamerList(res);
                document.getElementById('searchList').innerHTML = "";
                document.getElementById('searchUser').value = "";
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }

    const oneMoreGameCnt = (userNo) => {
        if (confirm("게임에 추가 참여하시겠습니까?")) {
            let gameNumber = '${gameList.gameNo}';
            $.ajax({
                type: "post",
                url: "/game/oneMoreGameCnt",
                data: {
                    "userNo": userNo,
                    "gameNo": gameNumber
                },
                success: function (res) {
                    reloadGamerList(res);
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        } else {
            return false;
        }
    }

    const gameSet = (userNo) => {
        if (confirm("사용자의 이용이 끝났습니까?")) {
            let gameNumber = '${gameList.gameNo}';
            $.ajax({
                type: "post",
                url: "/game/userGameSet",
                data: {
                    "userNo": userNo,
                    "gameNo": gameNumber
                },
                success: function (res) {
                    reloadGamerList(res);
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        } else {
            return false;
        }
    }

    const reloadGamerList = (res) => {
        let gamerList = "<table id='gamerTable'>";
        gamerList += "<tr><th>회원 번호</th>";
        gamerList += "<th>참가자 이름</th>";
        gamerList += "<th>참여 횟수</th>";
        gamerList += "<th>추가 참여</th>";
        gamerList += "<th>게임 종료</th>";
        gamerList += "<th>참여 시간</th>";
        for (let i in res) {
            gamerList += "<tr>";
            gamerList += "<td>" + res[i].userNo + "</td>";
            gamerList += "<td>" + res[i].userName + "</td>";
            gamerList += "<td class='gameTimeCnt'>" + res[i].gameTime + "</td>";
            gamerList += "<td><button onclick='oneMoreGameCnt(" + res[i].userNo + ")'>" + "추가 참여" + "</button></td>";
            gamerList += "<td><button onclick='gameSet(" + res[i].userNo + ")'>" + "게임 종료" + "</button></td>";
            gamerList += "<td>" + res[i].joinTime + "</td>";
            gamerList += "</tr>";
        }
        gamerList += "</table>";
        document.getElementById('gamerList').innerHTML = gamerList;
        calcSum();
    }

    calcSum = () => {
        const table = document.getElementById('gamerTable');        // table element 찾기
        let sum = 0;
        for (let i = 1; i < table.rows.length; i++) {               // 합계 계산
            sum += parseInt(table.rows[i].cells[2].innerHTML);
        }
        document.getElementById('totalGamerCnt').value = sum;       // 합계 출력
        calcReward();
    }

    calcReward = () => {
        const gamerCnt = document.getElementById('totalGamerCnt').value;
        const gameFee = ${gameList.gameFee};
        const rewardRate = ${gameList.rewardRate};

        let gameReward = (gamerCnt * gameFee) * (rewardRate / 100);
        gameReward = Math.ceil(gameReward);
        document.getElementById('totalReward').value = gameReward;
    }

    window.addEventListener('DOMContentLoaded', function () {
        calcSum();
    });
</script>
</html>
