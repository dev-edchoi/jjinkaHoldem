<%--
  Created by IntelliJ IDEA.
  User: ddilg
  Date: 2024-01-31
  Time: 오후 8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userPop.css">
    <style>

    </style>
</head>
<body>
<div style="margin-top: 20px">
    <div class="popup-header" style="margin: 0 20px 0 20px">
        <span class="user-info" id="user-info"></span>
        <!-- Add input field and search button -->
        <input type="text" id="searchWord" placeholder="검색어 입력" onkeyup="fnEnterKeyUp()" style="margin-left: 20px;">
        <button id="searchButton" onclick="popRecommenderSearch()">검색</button>
    </div>
    <div>
        <table class="brown-table" id="userTable">
            <thead>
            <tr>
                <th>No.</th>
                <th>회원 전화번호</th>
                <th>회원 이름</th>
                <th>상금</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    window.onload = function() {
        // let recommender = getParameterByName('recommender');
        //
        // if(recommender){                                                                    // 파라미터 값이 있는 경우에만 검색 진행.
        //     document.getElementById("user-info").innerHTML = "검색어 : " + recommender;
        //     recommenderSearch(recommender);
        // } else {
        //     document.getElementById("user-info").innerHTML = "검색어 : ";
        // }

        document.getElementById("user-info").innerHTML = "검색어 : ";
    };

    // function getParameterByName(name) {
    //     name = name.replace(/[\[\]]/g, '\\$&');
    //     let url = window.location.href;
    //     let regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
    //     let results = regex.exec(url);
    //     if (!results) return null;
    //     if (!results[2]) return '';
    //     return decodeURIComponent(results[2].replace(/\+/g, ' '));
    // }

    const popRecommenderSearch = () => {                                                    // 팝업창에서 검색을 진행하는 경우.
        let searchParam = document.getElementById("searchWord").value;
        recommenderSearch(searchParam);
    }

    const recommenderSearch = (recommender) => {
        $.ajax({
            type: "post",
            url: "/alphaAdmin/user/findRecommender",
            data: {
                "recommender": recommender
            },
            success: function (res) {
                let recommenderList = "<table id='gamerTable'>";
                    recommenderList += "<th>회원 번호</th>";
                    recommenderList += "<th>참가자 이름</th>";
                    recommenderList += "<th>전화번호</th>";
                    recommenderList += "<th>확인</th>";
                for (let i in res) {
                    recommenderList += "<tr>";
                    recommenderList += "<td>" + res[i].userNo + "</td>";
                    recommenderList += "<td>" + res[i].userName + "</td>";
                    recommenderList += "<td>" + res[i].phoneNumber + "</td>";
                    recommenderList += "<td><button class='table-button' onclick='closePopup(" + res[i].userNo + ")'>" + "선택" + "</button></td>";
                    recommenderList += "</tr>";
                }
                    recommenderList += "</table>";
                document.getElementById('userTable').innerHTML = recommenderList;
            },
            error: function (err) {
                console.log("에러 발생", err);
            }
        });
    }

    const closePopup = (recommenderNo) => {
        if (confirm(recommenderNo + " 번을 추천인으로 등록 합니다.")) {
            opener.document.getElementById("recommenderNo").value = recommenderNo;
            opener.document.getElementById("recommenderNo").readOnly = true
            opener.document.getElementById("btnConfirm").focus();
            window.close();
        }
    }

    const fnEnterKeyUp = () =>{
        if (window.event.keyCode === 13) {
            popRecommenderSearch();
        }
    }
</script>
</body>
</html>
