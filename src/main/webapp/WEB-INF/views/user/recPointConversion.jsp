<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-11-19(019)
  Time: 오전 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Point Update Popup</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/recPointPop.css">
    <style>

    </style>
</head>
<body>
<div class="popup-container">
    <div class="popup-header">
        <span class="referral-points" >추천인 포인트: ${userInfo.recPoint}</span>
        <span class="remaining-points">잔여포인트: ${userInfo.userPoint}</span>
    </div>
    <div class="popup-body">
        <label for="convPoint" class="input-label">전환 할 포인트:</label>
        <input type="number" id="convPoint" placeholder="Enter new points" onblur="chkRecPoint()">
        <!-- Message Display -->
        <div id="message" class="message">
            <p id="check-result">전환할 포인트를 입력 해 주세요.</p>
        </div>

        <div class="button-group">
            <button id="confirmButton" class="confirm-button" onclick="recPointConv()">확인</button>
            <button id="cancleButton" class="confirm-button" onclick="closePopup()">취소</button>
        </div>
    </div>
</div>

</body>
</html>
<script>
    window.onload = function() {

    };
    const messageTag = document.getElementById("message");
    let isPass = 0;                                                                     // 값이 1이여야 통과.

    // 입력한 숫자가 잔여 추천인 포인트보다 많은지 확인.
    const chkRecPoint = () => {
        const recPoint = parseInt(${userInfo.recPoint}, 10); // JSP 변수
        const convPoint = parseInt(document.getElementById("convPoint").value, 10);     // 사용자 입력 값

        if (isNaN(convPoint)) {
            messageTag.style.color = "red";
            messageTag.innerHTML = "숫자를 입력해주세요.";
            isPass = 0;
            return;
        } else if (convPoint < 0) {
            messageTag.style.color = "red";
            messageTag.innerHTML = "음의 값은 입력할 수 없습니다.";
            document.getElementById("convPoint").value = 0; // 음수 입력 시 0으로 설정
            isPass = 0;
            return;
        } else if (convPoint === 0){
            messageTag.style.color = "red";
            messageTag.innerHTML = "유효한 포인트를 입력해주세요.";
            isPass = 0;
            return;
        }

        if(recPoint < convPoint) {
            isPass = 0;

            messageTag.style.color = "red";
            messageTag.innerHTML = "입력된 포인트가 잔여 추천인 포인트보다 많습니다.";
        } else if(recPoint >= convPoint){
            isPass = 1;

            messageTag.style.color = "green";
            messageTag.innerHTML = "PASS";
        }
    }

    const recPointConv = () => {
        if(isPass === 1){
            const userNo = ${userInfo.userNo};
            const recPoint = parseInt(${userInfo.recPoint}, 10);
            const userPoint = parseInt(${userInfo.userPoint}, 10);
            const convPoint = parseInt(document.getElementById("convPoint").value, 10);

            let convRecPoint = recPoint - convPoint;
            let convUserPoint = userPoint + convPoint;

            if (confirm("[" +convPoint + "] 추천 포인트 만큼 포인트를 전환 하시겠습니까?")) {
                $.ajax({
                    type: "post",
                    url: "/alphaAdmin/userPoint/recPointConv",
                    data: {
                        "userNo" : userNo,
                        "convPoint": convPoint,
                        "convRecPoint": convRecPoint,
                        "convUserPoint": convUserPoint
                    },
                    success: function (res) {
                        messageTag.style.color = "green";
                        messageTag.innerHTML = res;
                        window.close();
                        window.opener.location.reload();
                    },
                    error: function (err) {
                        console.log("에러 발생", err);
                        messageTag.style.color = "red";
                        messageTag.innerHTML = "에러 발생.";
                    }
                });
            } else {
                messageTag.style.color = "red";
                messageTag.innerHTML = "취소됐습니다.";
            }
        } else {
            messageTag.style.color = "red";
            messageTag.innerHTML = "유효한 포인트를 입력해주세요.";
        }
    }

    const closePopup = () => {
        if (confirm("포인트 전환을 취소하고 창을 닫습니다.")) {
            window.close();
        }
    }
</script>
