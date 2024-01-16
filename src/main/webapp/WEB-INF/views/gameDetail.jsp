<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-16(016)
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>detail</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/table.css">
</head>
<body>
<header>
    <div class="header_container">
        <div class="logo_container">
            <a href="/">jjinka-Pub</a>
        </div>
    </div>
</header>
<button onclick="updateFn()">수정</button>
<table>
    <tr>
        <th>게임 번호</th>
        <td>${gameList.gameNo}</td>
    </tr>
    <tr>
        <th>테이블 번호</th>
        <td>${gameList.tableNo}</td>
    </tr>
    <tr>
        <th>보상 비율</th>
        <td>${gameList.rewardRate}</td>
    </tr>
    <tr>
        <th>리워드 포인트</th>
        <td>${gameList.makeDate}</td>
    </tr>
</table>
<br><br>
<H1>참여 유저</H1>
<br><br>
<div>
    <label for="searchUser"> 유저 검색 :
        <input type="text" id="searchUser" name="userName" onblur="userSearch()"/>
    </label>
</div>
<input type="submit" class="btn" id="btnSearchUser" value="회원 검색" onclick="userSearch()"/>
<div id="search-list">
</div>
<div>
    <table>
        <tr>
            <th>유저</th>
            <th>포인트</th>
        </tr>
        <tr>
            <td>유저1</td>
            <td>30000</td>
        </tr>
        <tr>
            <td>유저2</td>
            <td>30000</td>
        </tr>
        <tr>
            <td>유저3</td>
            <td>30000</td>
        </tr>
    </table>
</div>
</body>
<script>
    const userSearch = () => {
        const userName = document.getElementById("searchUser").value;
        console.log("검색할 이름 : ", userName);
        $.ajax({
            type: "post",
            url: "/user/findByUserName",
            data: {
                "userName": userName
            },
            success: function (res) {
                console.log("res : " + res);
                let output = "<table>";
                    output += "<tr><th>번호</th>";
                    output += "<th>이름</th>";
                    output += "<th>전화번호</th>";
                    output += "<th>게임 참가</th>";

                for(let i in res){
                    output += "<tr>";
                    output += "<td>"+res[i].userNo+"</td>";
                    output += "<td>"+res[i].userName+"</td>";
                    output += "<td>"+res[i].phoneNumber+"</td>";
                    output += "<td><a href='/user?userNo=" + res[i].userNo + "'>참가</a></td>";
                    output += "</tr>";
                }
                    output += "</table>";
                    document.getElementById('search-list').innerHTML = output;
            },
            error: function (err) {
                console.log("에러발생", err);
            }
        });
    }

</script>
</html>
