<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-03-06(006)
  Time: 오후 4:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <title>Point Checker</title>

    <style>
        body {
            background-color: #f8f8f8;
            font-family: Arial, sans-serif;
            margin: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .point-checker {
            background-color: #333;
            color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 400px; /* Optional: Set a maximum width for larger screens */
            margin: auto;
        }

        h2 {
            color: #fff;
        }

        form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .result {
            margin-top: 20px;
        }

        .success {
            color: #fff;
        }

        .error {
            color: #FF5733;
        }

        .header {
            background-color: #d2b48c;
            text-align: center;
            height: fit-content;
        }

        .logo {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
<header class="header">
    <img src="${pageContext.request.contextPath}/img/ALPHA_black_60.png" alt="Alpha Logo" class="logo">    </a>
</header>
<div class="container">
    <div class="point-checker">
        <h2>잔여 포인트</h2>
        <form id="pointForm">
            <div class="form-group">
                <label for="nickname">닉네임:</label>
                <input type="text" id="nickname" name="nickname" class="form-control" placeholder="닉네임을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="phoneNumber">전화번호:</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="전화번호를 입력하세요" required>
            </div>

            <button type="button" onclick="checkPoint()" class="btn btn-primary">잔여 포인트 확인</button>
        </form>

        <div id="result" class="result"></div>
    </div>
</div>

<script>
    function checkPoint() {
        var userName = document.getElementById('nickname').value;
        var phoneNumber = document.getElementById('phoneNumber').value;

        $.ajax({
            type: "post",
            url: "/point/checkPoint",
            data: {
                "userName": userName,
                "phoneNumber": phoneNumber
            },
            success: function (res) {
                console.log(res);
                if (res) {
                    document.getElementById('result').innerHTML = '<p class="success">잔여 포인트: ' + res + '</p>';
                } else {
                    document.getElementById('result').innerHTML = '<p class="error">닉네임 혹은 전화번호를 확인해주세요.</p>';
                }
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }
</script>

</body>
</html>
