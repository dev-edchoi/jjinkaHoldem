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
    <title>JJinkaPub</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userRegister.css">
</head>
<body>
<form action="/user/save" method="post" class="joinForm">
    <h2>회원 등록</h2>
    <div class="textForm">
        <input name="phoneNumber" id="phoneNumber" type="number" class="cellphoneNo" placeholder="전화번호" oninput="handleOnInput(this, 11)" onblur="numberCheck()">
    </div>
    <p id="check-result"></p>
    <div class="textForm">
        <input name="userName" type="text" class="name" placeholder="이름" maxlength="11">
    </div>
    <input type="submit" class="btn" id="userRegister" disabled="true" value="회원 등록"/>
</form>
</body>
<script>
    // 이메일 입력값을 가져오고,
    // 입력값을 서버로 전송하고 똑같은 이메일이 있는지 체크한 후
    // 사용 가능 여부를 이메일 입력창 아래에 표시
    const numberCheck = () => {
        let phoneNumber = document.getElementById("phoneNumber").value;
            phoneNumber = phoneNumber.toString();
        const checkResult = document.getElementById("check-result");
        console.log("입력한 이메일 : ", phoneNumber);
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
                    document.getElementById("userRegister").disabled = false;
                } else {
                    checkResult.style.color = "red";
                    checkResult.innerHTML = "이미 사용 중인 번호";
                }
            },
            error: function (err) {
                console.log("에러발생", err);
            }
        });
    }

    function handleOnInput(el, maxlength) {
        if(el.value.length > maxlength)  {
            el.value = el.value.substr(0, maxlength);
        }
    }
</script>
</html>