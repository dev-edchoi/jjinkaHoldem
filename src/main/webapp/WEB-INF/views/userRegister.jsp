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
    <h2 style="text-align: center; color: #4e342e;">회원 정보 입력</h2>
    <form action="/user/save" method="post" class="joinForm" name="joinForm">
        <label for="phoneNumber">전화 번호:</label>
        <input type="number" id="phoneNumber" name="phoneNumber" class="cellphoneNo" placeholder="전화 번호" maxlength="11" required oninput="handleOnInput(this, 11)" onblur="numberCheck()">
        <p id="check-result"></p>
        <label for="userName">회원 이름:</label>
        <input type="text" id="userName" name="userName" placeholder="회원 이름" >
        <label for="visitRoute">방문 경로:</label>
        <select id="visitRoute" name="visitRoute">
            <option value="0">=== 선택 ===</option>
            <option value="1">친구 소개</option>
            <option value="2">SNS(인스타그램 등)</option>
            <option value="3">지도 검색</option>
        </select>
        <input type="button" value="회원 등록" onclick="userRegist()">
        <input type="button" value="등록 취소" onclick="location.href='/'">
    </form>
</div>
</body>
<script>
    const userRegist =() => {
        let phoneNumber = document.getElementById("phoneNumber").value;
        let userName = document.getElementById("userName").value;

        if(phoneNumber.length < 11){
            alert("휴대폰 번호는 11자리를 입력해주세요..");
            return false;
        }

        if(!phoneNumber || !userName){
            alert("정보를 입력해주세요.");
            return false;
        } else {
            document.joinForm.submit();
        }
    }
    // 이메일 입력값을 가져오고,
    // 입력값을 서버로 전송하고 똑같은 이메일이 있는지 체크한 후
    // 사용 가능 여부를 이메일 입력창 아래에 표시
    const numberCheck = () => {
        let phoneNumber = document.getElementById("phoneNumber").value;
            phoneNumber = phoneNumber.toString();
        const checkResult = document.getElementById("check-result");

        if(phoneNumber.length === 11){
            $.ajax({
                // 요청방식: post, url: "email-check", 데이터: 이메일
                type: "post",
                url: "/user/phoneNumberChk",
                data: {
                    "phoneNumber": phoneNumber
                },
                success: function (res) {
                    if (res === "ok") {
                        checkResult.style.color = "green";
                        checkResult.innerHTML = "사용 가능 한 번호";
                    } else {
                        checkResult.style.color = "red";
                        checkResult.innerHTML = "이미 사용 중인 번호";
                    }
                },
                error: function (err) {
                    console.log("에러발생", err);
                }
            });
        } else {
            return false;
        }
    }

    function handleOnInput(el, maxlength) {
        if(el.value.length > maxlength)  {
            el.value = el.value.substr(0, maxlength);
        }
    }
</script>
</html>