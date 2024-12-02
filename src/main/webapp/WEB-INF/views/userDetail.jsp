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
    <!--          meta 선언          -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>detail</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<style>
    /* 모바일 반응형 CSS */
    @media only screen and (max-width: 1000px) {
        .buttons-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 10px;
        }

        .button {
            width: 45%;
            margin: 5px;
        }

        #etcReason {
            width: calc(100% - 20px);
        }
    }

</style>
</head>
<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>
<div class="buttons-container">
    <button class="button" onclick="recPointConversion()">포인트 전환</button>
    <button class="button" onclick="userPointSend()">포인트 선물</button>
    <button class="button" onclick="updateFn()">유정 정보 수정</button>
    <button class="button" onclick="userPointLog()">전체 포인트 목록</button>
    <button class="button" onclick="listFn()">유저 목록</button>
</div>
<div class="container">
    <div class="game-info">
        <table class="blue-table">
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
            <tr>
                <th>추천 포인트</th>
                <td>${userList.recPoint}</td>
            </tr>
            <tr>
                <th>회원 레벨</th>
                <td>${userList.memLevel}</td>
            </tr>
            <tr>
                <th>방문 경로</th>
                <c:choose>
                    <c:when test="${userList.visitRoute == 1}">
                        <td>친구 소개</td>
                    </c:when>
                    <c:when test="${userList.visitRoute == 2}">
                        <td>SNS(인스타그램 등)</td>
                    </c:when>
                    <c:when test="${userList.visitRoute == 3}">
                        <td>지도 검색</td>
                    </c:when>
                    <c:when test="${userList.visitRoute == 4}">
                        <td>${userList.etcVisitRoute}</td>
                    </c:when>
                    <c:otherwise>
                        <td>방문 경로 없음</td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </table>
    </div>
</div>
<form action="/alphaAdmin/user/userUpdatePoint" method="post" name="userPointUpdate">
    <input type="hidden" name="userNo" value="${userList.userNo}">
    <div class="buttons-container">
        <label for="userPoint" style="font-size: 16px; margin-top: 4px"> 포인트 수정 :</label>
        <input name="userPoint" id="userPoint" type="number" value="0" style="width: 150px;" readonly/>
        <button type="button" class="button" id="userPointUpdate" onclick="userUpdatePoint()"
                style="margin-right: 20px">확인
        </button>
        <input type="number" id="point" onblur="updatePoint(value)" style="width: 150px"/>
        <button type="button" class="button" id="minus2M" value="-20000" onclick="updatePoint(value)">-20,000</button>
        <button type="button" class="button" id="plus2M" value="+20000" onclick="updatePoint(value)">+20,000</button>
        <button type="button" class="button" id="minus3M" value="-30000" onclick="updatePoint(value)">-30,000</button>
        <button type="button" class="button" id="plus3M" value="+30000" onclick="updatePoint(value)">+30,000</button>
        <button type="button" class="button" id="minus5M" value="-50000" onclick="updatePoint(value)">-50,000</button>
        <button type="button" class="button" id="plus5M" value="+50000" onclick="updatePoint(value)">+50,000</button>
        <select id="reasonForChange" name="reasonForChange" required onchange="toggleInputs()">
            <option value="0" selected>일반 충전</option>
            <option value="3">기타</option>
        </select>
        <input type="text" id="etcReason" name="etcReason" style="width: 300px"/>
    </div>
</form>
<div>
    <table class="blue-table">
        <thead>
        <tr>
            <th>변동 금액</th>
            <th>변동 이유</th>
            <th>참가 게임 번호</th>
            <th>Etc.</th>
            <th>포인트 받은 사람</th>
            <th>포인트 준 사람</th>
            <th>변동 후 금액</th>
            <th>변동 일자</th>
        </tr>
        </thead>
        <c:forEach items="${userPoint}" var="userPoint">
            <tr>
                <td>${userPoint.point}</td>
                <td>${userPoint.typeName}</td>
                <td>${userPoint.joinGameNo}</td>
                <td>${userPoint.etcReason}</td>
                <td>${userPoint.receiverUserName}</td>
                <td>${userPoint.senderUserName}</td>
                <td>${userPoint.later_balance}</td>
                <td>${userPoint.date}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    window.onload = function () {
        toggleInputs();
    }

    const updateFn = () => {
        const userNo = '${userList.userNo}';
        location.href = "/alphaAdmin/user/userUpdate?userNo=" + userNo;
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
        let etcReason = document.getElementById("etcReason").value;
        let reasonForChange = document.getElementById("reasonForChange").value;

        if(reasonForChange === '3' && !etcReason){
            alert("포인트 변동 사유를 입력해 주세요.");
            return false;
        }

        document.userPointUpdate.submit();
    }

    const listFn = () => {
        const page = '${page}';
        location.href = "/alphaAdmin/user/?page=" + page;
    }

    const userPointSend = () => {
        let userNo = '${userList.userNo}';
        let userPoint = '${userList.userPoint}';

        let _width = '650';
        let _height = '600';
        let _left = Math.ceil((window.screen.width - _width) / 2);
        let _top = Math.ceil((window.screen.height - _height) / 2);

        window.open('/alphaAdmin/user/userPointPopUp?userNo=' + userNo + "&userPoint=" + userPoint, 'childForm', 'width=' + _width + ',height=' + _height + ',left=' + _left + ',top=' + _top);
    }

    const toggleInputs = () => {
        let reasonForChange = document.getElementById('reasonForChange').value;
        let etcReason = document.getElementById('etcReason');

        etcReason.disabled = reasonForChange === '0';
    }

    const userPointLog = () => {
        let userNo = ${userList.userNo};

        location.href = "/alphaAdmin/userPoint/userPointLog?userNo=" + userNo
    }

    const recPointConversion = () => {
        let userNo = '${userList.userNo}';
        //let userPoint = '${userList.userPoint}';

        let _width = '650';
        let _height = '600';
        let _left = Math.ceil((window.screen.width - _width) / 2);
        let _top = Math.ceil((window.screen.height - _height) / 2);

        window.open('/alphaAdmin/userPoint/recPointConversion?userNo=' + userNo, 'childForm', 'width=' + _width + ',height=' + _height + ',left=' + _left + ',top=' + _top);
    }
</script>
</html>