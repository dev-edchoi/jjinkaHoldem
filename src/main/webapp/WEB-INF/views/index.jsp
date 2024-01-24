<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-15(015)
  Time: 오전 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <!--          meta 선언          -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--          link 선언          -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_index.css">
    <!--          script 선언          -->
    <script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <title>ALPHA</title>
</head>

<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>
<div class="main_container">
    <div class="conB">
        <div class="conB_title">
            <h3>Task</h3>
        </div>
        <div class="conB_container">
            <div class="conB_small_container">
                <div class="conB_icon" onclick="location.href='game/gameList'">
                    <i class="fas fa-cogs icon"></i>
                </div>
                <div class="conB_content">
                    <h3>게임 관리</h3>
                    <p>Game Setting</p>
                </div>
            </div>
            <div class="conB_small_container">
                <div class="conB_icon" onclick="location.href='user/userRegister'">
                    <i class="fas fa-code icon"></i>
                </div>
                <div class="conB_content">
                    <h3>회원 등록</h3>
                    <p>Member Register</p>
                </div>
            </div>
            <div class="conB_small_container">
                <div class="conB_icon" onclick="location.href='user/'">
                    <i class="fas fa-cogs icon"></i>
                </div>
                <div class="conB_content">
                    <h3>회원 관리</h3>
                    <p>Member</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
