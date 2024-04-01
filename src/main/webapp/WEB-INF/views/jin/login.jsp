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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jin/login.css">
    <title>Login</title>
</head>
<body>
<div class="login-container">
    <h2>진혁</h2>
    <form action="/jin/login" method="post" class="login-form" id="loginForm" name="jinLogin">
        <input type="text" id="jinId" name="jinId" required autofocus>
        <input type="password" id="jinPwd" name="jinPwd" required>
        <button onclick="login()">Login</button>
    </form>
</div>

<script>
    function login() {
        let jinId = document.getElementById("jinId");
        let jinPwd = document.getElementById("jinPwd");

        if(jinId !== null && jinPwd !== null){
            document.jinLogin.submit();
        } else {
            alert("정보를 입력해 주세요.")
        }
    }
</script>
</body>
</html>
