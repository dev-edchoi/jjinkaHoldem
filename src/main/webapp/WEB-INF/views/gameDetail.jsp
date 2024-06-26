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
</head>
<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>

<div class="buttons-container">
    <button class="button" onclick="listFn()">게임 목록</button>
    <button id="gameSet" class="button" onclick="fnMakePopUp('${gameList.gameNo}')">게임 종료</button>
    <button class="button" onclick="updateFn()">게임 정보 수정</button>
</div>

<div class="container">
    <div class="game-info">
        <h2>Game Information</h2>
        <table class="brown-table">
            <tr>
                <th>게임 번호</th>
                <td>${gameList.gameNo}</td>
            </tr>
            <tr>
                <th>오늘의 게임 번호</th>
                <td>${gameList.todayGameNo}</td>
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
                <th>총 참여 비용</th>
                <td id="totalGameFee">${gameList.totalGameFee}</td>
            </tr>
            <tr>
                <th>보상 비율</th>
                <td>${gameList.rewardRate}</td>
            </tr>
            <tr>
                <th>상금</th>
                <td id="gameReward">${gameList.gameReward}</td>
            </tr>
            <tr>
                <th>게임 생성 시각</th>
                <td>${gameList.makeDate}</td>
            </tr>
        </table>
    </div>
    <div class="member-search">
        <h2>Member Search</h2>
        <label for="searchUser"> 유저 검색 :</label>
        <input type="text" id="searchUser" name="userName" placeholder="Enter member name" onkeyup="fnEnterKeyUp()" onblur="userSearch()"/>
        <button class="table-button" id="btnSearchUser" onclick="userSearch()">회원 검색</button>
        <div class="search-results" id="search-list">
            <!-- Results will be displayed dynamically here -->
        </div>
    </div>
</div>
<H3>참여 유저</H3>
<div style="margin: 10px 0 10px 0; float: right">
    <label for="totalGamerCnt">총 참여 횟수 : </label>
    <input type="number" id="totalGamerCnt" readonly>
</div>
<div>
    <table id='gamerTable' class="brown-table">
        <tr>
            <th>참여 번호</th>
            <th>회원 번호</th>
            <th>참가자 이름</th>
            <th>참여 횟수</th>
            <th>잔여 포인트</th>
            <th>추가 참여</th>
            <th>게임 종료</th>
            <th>획득 상금</th>
            <th>참여 시간</th>
            <th>종료 시간</th>
        </tr>
        <c:forEach items="${gameJoiner}" var="joiner">
            <tr>
                <td>${joiner.gameJoinNo}</td>
                <td>${joiner.userNo}</td>
                <td>${joiner.userName}</td>
                <td>${joiner.gameTime}</td>
                <td>${joiner.joinUserPoint}</td>
                <c:choose>
                    <c:when test="${joiner.inGame == 0}">
                        <td>
                            <button class="table-button" onclick="oneMoreGameCnt('${joiner.userNo}', '${joiner.gameJoinNo}')">추가 참여</button>
                        </td>
                        <td>
                            <button class="table-button" onclick="gameSet('${joiner.userNo}', '${joiner.gameJoinNo}')">게임 종료</button>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <button class="table-button" onclick="reGameIn('${joiner.userNo}', '${joiner.gameJoinNo}')">다시 참여하기</button>
                        </td>
                        <td>참여 종료 됐습니다.</td>
                    </c:otherwise>
                </c:choose>
                <td>${joiner.prizeMoney}</td>
                <td>${joiner.joinTime}</td>
                <td>${joiner.finishTime}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    let gameNoForLog;
    let isGameEnd;

    window.onload = function () {
        let today = new Date();

        let year = today.getFullYear(); // 년도
        let month = today.getMonth() + 1;  // 월
        let date = today.getDate();  // 날짜

        let todayGameNo = ${gameList.todayGameNo};

        gameNoForLog = year + "_" + month + "_" + date + "-" + todayGameNo;

        isGameEnd = ${gameList.isEnd};

        if(isGameEnd === 1) {
            disableElementsByClass('table-button');
            document.getElementById('searchUser').disabled = true;
        }

        fnChkGaming();
    }

    function disableElementsByClass(className) {
        let elements = document.getElementsByClassName(className);

        for (let i = 0; i < elements.length; i++) {
            elements[i].disabled = true;
        }
    }

    const fnChkGaming = () =>{
        let gameNo = ${gameList.gameNo};
        $.ajax({
            type: "post",
            url: "/alphaAdmin/game/chkGaming",
            data: {
                "gameNo": gameNo
            },
            success: function (res) {
                if(res === "1"){
                    document.getElementById("gameSet").disabled = true;
                    isGameEnd = 1;
                }
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }

    const userSearch = () => {
        const userName = document.getElementById("searchUser").value;

        $.ajax({
            type: "post",
            url: "/alphaAdmin/user/findByUserName",
            data: {
                "userName": userName
            },
            success: function (res) {
                let output = "<table class='brown-table'>";
                    output += "<tr><th>번호</th>";
                    output += "<th>이름</th>";
                    output += "<th>전화번호</th>";
                    output += "<th>포인트</th>";
                    output += "<th>게임 참가</th>";

                for (let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].userNo + "</td>";
                    output += "<td>" + res[i].userName + "</td>";
                    output += "<td>" + res[i].phoneNumber + "</td>";
                    output += "<td>" + res[i].userPoint + "</td>";
                    output += "<td><button class='table-button' onclick='ChkJoiner(" + res[i].userNo + ")'>" + "게임 참가" + "</button></td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('search-list').innerHTML = output;
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
            url: "/alphaAdmin/game/chkJoiner",
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
        let gameFee = ${gameList.gameFee};

        $.ajax({
            type: "post",
            url: "/alphaAdmin/game/gamerJoin",
            data: {
                "userNo": userNo,
                "gameNo": gameNumber,
                "gameFee": gameFee,
                "gameNoForLog" : gameNoForLog
            },
            success: function (res) {
                reloadGamerList(res);
                document.getElementById('search-list').innerHTML = "";
                document.getElementById('searchUser').value = "";
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }

    const oneMoreGameCnt = (userNo, gameJoinNo) => {
        if (confirm("게임에 추가 참여하시겠습니까?")) {
            let gameNumber = '${gameList.gameNo}';
            let gameFee = ${gameList.gameFee};

            $.ajax({
                type: "post",
                url: "/alphaAdmin/game/oneMoreGameCnt",
                data: {
                    "userNo": userNo,
                    "gameNo": gameNumber,
                    "gameFee": gameFee,
                    "gameJoinNo" : gameJoinNo,
                    "gameNoForLog" : gameNoForLog
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

    const gameSet = (userNo, gameJoinNo) => {
        if (confirm("사용자의 이용이 끝났습니까?")) {
            let gameNumber = '${gameList.gameNo}';
            $.ajax({
                type: "post",
                url: "/alphaAdmin/game/userGameSet",
                data: {
                    "userNo": userNo,
                    "gameNo": gameNumber,
                    "gameJoinNo" : gameJoinNo
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

    const reGameIn = (userNo, gameJoinNo) =>{
        if (confirm("다시 참여하겠습니까?")) {
            let gameNumber = '${gameList.gameNo}';
            let gameFee = ${gameList.gameFee};

            $.ajax({
                type: "post",
                url: "/alphaAdmin/game/reGameIn",
                data: {
                    "userNo": userNo,
                    "gameNo": gameNumber,
                    "gameFee": gameFee,
                    "gameJoinNo" : gameJoinNo,
                    "gameNoForLog" : gameNoForLog
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
            gamerList += "<tr><th>참여 번호</th>";
            gamerList += "<th>회원 번호</th>";
            gamerList += "<th>참가자 이름</th>";
            gamerList += "<th>참여 횟수</th>";
            gamerList += "<th>잔여 포인트</th>";
            gamerList += "<th>추가 참여</th>";
            gamerList += "<th>게임 종료</th>";
            gamerList += "<th>획득 상금</th>";
            gamerList += "<th>참여 시간</th>";
            gamerList += "<th>종료 시간</th>";
        for (let i in res) {
            gamerList += "<tr>";
            gamerList += "<td>" + res[i].gameJoinNo + "</td>";
            gamerList += "<td>" + res[i].userNo + "</td>";
            gamerList += "<td>" + res[i].userName + "</td>";
            gamerList += "<td class='gameTimeCnt'>" + res[i].gameTime + "</td>";
            gamerList += "<td class='gameTimeCnt'>" + res[i].joinUserPoint + "</td>";
            if(isGameEnd === 1) {
                gamerList += "<td>게임 종료.</td>";
                gamerList += "<td>게임 종료.</td>";
            } else if(isGameEnd !== 1 &&parseInt(res[i].inGame) === 0){
                gamerList += "<td><button class='table-button' onclick='oneMoreGameCnt(" + res[i].userNo + "," + res[i].gameJoinNo + ")'>" + "추가 참여" + "</button></td>";
                gamerList += "<td><button class='table-button' onclick='gameSet(" + res[i].userNo + "," + res[i].gameJoinNo + ")'>" + "게임 종료" + "</button></td>";
            } else {
                gamerList += "<td><button class='table-button' onclick='reGameIn(" + res[i].userNo + "," + res[i].gameJoinNo + ")'>" + "다시 참여하기" + "</button></td>";
                gamerList += "<td>참여 종료 됐습니다.</td>";
            }
            gamerList += "<td class='gameTimeCnt'>" + res[i].prizeMoney + "</td>";
            gamerList += "<td>" + res[i].joinTime + "</td>";
            if(res[i].finishTime === undefined || res[i].finishTime === null) res[i].finishTime ="";
            gamerList += "<td>" + res[i].finishTime + "</td>";
            gamerList += "</tr>";
        }
            gamerList += "</table>";
        document.getElementById('gamerTable').innerHTML = gamerList;
        calcSum();
    }

    calcSum = () => {
        const table = document.getElementById('gamerTable');        // table element 찾기
        let sum = 0;
        for (let i = 1; i < table.rows.length; i++) {               // 합계 계산
            sum += parseInt(table.rows[i].cells[3].innerHTML);
        }
        document.getElementById('totalGamerCnt').value = sum;       // 합계 출력

        calcReward();
    }

    calcReward = () => {
        let gameType = ${gameList.gameType};

        let gameNumber = '${gameList.gameNo}';
        let gamerCnt = document.getElementById('totalGamerCnt').value;
        let gameFee = ${gameList.gameFee};
        let rewardRate = ${gameList.rewardRate};

        let gameReward = (gamerCnt * gameFee) * (rewardRate / 100);
            gameReward = Math.ceil(Math.ceil(gameReward) / 10000) * 10000;

        let totalGameFee = parseInt(gamerCnt * gameFee);

        if(gameType === 2){
            $.ajax({
                type: "post",
                url: "/alphaAdmin/game/setReward",
                data: {
                    "gameNo": gameNumber,
                    "totalGameFee": totalGameFee,
                    "gameReward" : gameReward,
                },
                success: function (res) {
                    document.getElementById('totalGameFee').innerHTML = res.totalGameFee;
                    document.getElementById('gameReward').innerHTML = res.gameReward;
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        } else if (gameType === 1){
            $.ajax({
                type: "post",
                url: "/alphaAdmin/game/setReward",
                data: {
                    "gameNo": gameNumber,
                    "totalGameFee": totalGameFee,
                },
                success: function (res) {
                    document.getElementById('totalGameFee').innerHTML = res.totalGameFee;
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        }
    }

    window.addEventListener('DOMContentLoaded', function () {
        calcSum();
    });

    const listFn = () => {
        const page = '${page}';
        location.href = "/alphaAdmin/game/gameList?page=" + page;
    }

    const fnMakePopUp = (gameNo) => {
        let _width = '650';
        let _height = '600';
        let _left = Math.ceil((window.screen.width - _width) / 2);
        let _top = Math.ceil((window.screen.height - _height) / 2);

        window.open('/alphaAdmin/user/userPopUp?gameNo=' + gameNo +'&joinGameNo=' + gameNoForLog , 'childForm', 'width=' + _width + ',height=' + _height + ',left=' + _left + ',top=' + _top);
    }

    const updateFn = () => {
        const gameNo = '${gameList.gameNo}';
        location.href = "/alphaAdmin/game/gameUpdate?gameNo=" + gameNo;
    }

    const fnEnterKeyUp = () =>{
        if (window.event.keyCode === 13) {
            userSearch()
        }
    }
</script>
</html>
