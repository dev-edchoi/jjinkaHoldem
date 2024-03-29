<%--
  Created by IntelliJ IDEA.
  User: ddilg
  Date: 2024-01-27
  Time: 오후 4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            text-align: center;
        }

        .login-container h2 {
            color: #333;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .login-form input {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .login-form button {
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-form button:hover {
            background-color: #0056b3;
        }

        /* 모바일 반응형 스타일 */
        @media screen and (max-width: 600px) {
            .login-container {
                width: 80%;
            }
        }
    </style>
    <title>Login</title>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="/alphaAdmin/adminLogin" method="post" class="login-form" id="loginForm" name="login">
        <input type="text" id="adminId" name="adminId" placeholder="adminId" required autofocus>
        <input type="password" id="adminPwd" name="adminPwd" placeholder="adminPwd" required>
        <button onclick="login()">Login</button>
    </form>
</div>

<script>
    function login() {
        let adminId = document.getElementById("adminId");
        let adminPwd = document.getElementById("adminPwd");

        if(adminId !== null && adminPwd !== null){
            document.login.submit();
        } else {
            alert("정보를 입력해 주세요.")
        }
    }
</script>
</body>
</html>
