<%--
  Created by IntelliJ IDEA.
  User: ddilg
  Date: 2024-01-28
  Time: 오후 3:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #e8d8c3; /* 배경색상 설정 */
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .user-info {
            background-color: #d4a373; /* 박스 배경색상 설정 */
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        h1 {
            color: #503c2c; /* 제목 글자색 설정 */
        }

        label {
            display: block;
            margin-top: 10px;
            color: #503c2c; /* 라벨 글자색 설정 */
        }

        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #503c2c; /* 입력창 테두리색상 설정 */
            border-radius: 4px;
        }

        button {
            background-color: #503c2c; /* 버튼 배경색상 설정 */
            color: #fff; /* 버튼 글자색 설정 */
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #7f5e4a; /* 호버시 버튼 배경색상 변경 */
        }
    </style>
</head>
<body>
<div class="user-info">
    <form action="/user/userUpdate" method="post" name="updateForm">
        <input type="hidden" name="userNo" value="${user.userNo}" readonly>
        <h1>User Information</h1>

        <label for="userName">User Name:</label>
        <input type="text" id="userName" name="userName" value="${user.userName}" readonly>

        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">

        <label for="userPoint">Points:</label>
        <input type="text" id="userPoint" name="userPoint" value="${user.userPoint}">

        <button onclick="editUserInfo()">수정</button>
        <button onclick="location.href='/'">취소</button>
    </form>
    <button onclick="delUser('${user.userNo}')">회원 삭제</button>
</div>
<script>
    function editUserInfo() {
        if(confirm("회원 정보를 수정하시겠습니까?")){
            document.updateForm.submit();
        } else {
            return false;
        }
    }

    const delUser = (userNo) => {
        if(confirm("해당 회원을 삭제 하겠습니까?")){
            location.href = "/user/delete?userNo="+userNo;
        } else {
            return false;
        }
    }
</script>
</body>
</html>
