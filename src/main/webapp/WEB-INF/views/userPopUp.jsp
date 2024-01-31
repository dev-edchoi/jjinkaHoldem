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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div style="margin-top: 20px">
    <table class="brown-table">
        <thead>
        <tr>
            <th>No.</th>
            <th>회원 전화번호</th>
            <th>회원 이름</th>
            <th>우승자</th>
        </tr>
        </thead>
        <c:forEach items="${userList}" var="user">
            <tr>
                <td>${user.userNo}</td>
                <td>${user.phoneNumber}</td>
                <td>${user.userName}</td>
                <td>
                    <button class="table-button" onclick="setWinner('${user.userNo}','${user.userName}')">선택</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<script>
    const setWinner = (userNo, userName) => {
        let gameNo = ${gameInfo.gameNo};
        let gameReward = ${gameInfo.gameReward};

        if(confirm(userName + "에게 포인트 " + gameReward +" 만큼 적립됩니다.")) {
            $.ajax({
                type: "post",
                url: "/game/gameSet",
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
</script>
</body>
</html>
