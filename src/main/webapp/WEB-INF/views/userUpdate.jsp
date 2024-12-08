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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userUpdate.css">
    <title>회원 정보 수정</title>
</head>
<body>
<div class="container">
    <form action="/alphaAdmin/user/userUpdate" method="post" name="updateForm">
        <input type="hidden" name="userNo" value="${user.userNo}" readonly>
        <h1>User Information</h1>

        <label for="userName">User Name:</label>
        <input type="text" id="userName" name="userName" value="${user.userName}">

        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">

        <label for="memLevel">Member Level:</label>
        <input type="text" id="memLevel" name="memLevel" value="${user.memLevel}">

        <label for="recommenderNo">추천인 :</label>
        <input type="number" id="recommenderNo" name="recommenderNo" value="${user.recommenderNo}" onfocus="userSearch()">
        <input type="button" value="추천인 재검색" onclick="userSearch()">
        <br><br>

        <button id="btnConfirm" onclick="editUserInfo()">수정</button>
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
            location.href = "/alphaAdmin/user/delete?userNo="+userNo;
        } else {
            return false;
        }
    }

    const userSearch = () => {
        let url = "/alphaAdmin/user/recommenderPopup";

        window.open(url, "PopupWindow", "width=600,height=400,scrollbars=yes");
    }
</script>
</body>
</html>
