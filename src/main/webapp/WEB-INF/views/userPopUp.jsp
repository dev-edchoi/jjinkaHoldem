<%--
  Created by IntelliJ IDEA.
  User: ddilg
  Date: 2024-01-31
  Time: 오후 8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userPop.css">
    <style>

    </style>
</head>
<body>
<div style="margin-top: 20px">
    <div class="popup-header">
        <span class="user-info">게임 번호 : ${gameInfo.gameNo} | 총 우승 상금 : ${gameInfo.gameReward}</span>
    </div>
    <div>
        <table class="brown-table" id="userTable">
            <thead>
            <tr>
                <th>No.</th>
                <th>회원 전화번호</th>
                <th>회원 이름</th>
                <th>상금</th>
            </tr>
            </thead>
            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>${user.userNo}</td>
                    <td>${user.phoneNumber}</td>
                    <td>${user.userName}</td>
                    <td><input type="number" placeholder="Enter Prize"></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <button onclick="confirmAction()">Confirm</button>
</div>
<script>
    const setWinner = (userNo, userName) => {
        let gameNo = ${gameInfo.gameNo};
        let gameReward = ${gameInfo.gameReward};

        if (confirm(userName + "에게 포인트 " + gameReward + " 만큼 적립됩니다.")) {
            $.ajax({
                type: "post",
                url: "/alphaAdmin/game/gameSet",
                data: {
                    "gameNo": parseInt(gameNo),
                    "gameReward": parseInt(gameReward),
                    "userNo": userNo
                },
                success: function (res) {
                    window.open('', '_self', '');
                    window.close();
                    window.opener.location.reload();
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        } else {
            return false;
        }
    }

    const confirmAction = () => {
        let gameNo = ${gameInfo.gameNo};
        let gameReward = ${gameInfo.gameReward};
        let table = document.getElementById('userTable');
        let rows = table.getElementsByTagName('tr');
        let values = [];
        let chkPrize = 0;

        for (let i = 1; i < rows.length; i++) {
            let cells = rows[i].getElementsByTagName('td');
            let rowData = {};
            let prizeInput = cells[cells.length - 1].getElementsByTagName('input')[0];
            if(!isNaN(parseInt(prizeInput.value))) {
                chkPrize += parseInt(prizeInput.value);
                rowData.userNo = cells[0].innerText;
                rowData.gameReward = prizeInput.value;
                values.push(rowData);
            }
        }

        if(parseInt(gameReward) !== chkPrize){
            alert("우승 상금과 입력 값이 다릅니다.");
        } else {
            if (confirm("게임을 종료 하겠습니까?")) {
                $.ajax({
                    type: "post",
                    url: "/alphaAdmin/game/gameSet",
                    data: {
                        "values": JSON.stringify(values),
                        "gameNo": parseInt(gameNo)
                    },
                    success: function (res) {
                        console.log(res);
                        if(res === "success"){
                            window.open('', '_self', '');
                            window.close();
                            window.opener.location.reload();
                        }
                    },
                    error: function (err) {
                        console.log("에러 발생", err);
                    }
                });
            }
        }
    }
</script>
</body>
</html>
