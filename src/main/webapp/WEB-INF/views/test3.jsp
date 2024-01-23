<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-23(023)
  Time: 오후 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>

    </style>
</head>
<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>
<div class="buttons-container">
    <button class="button">Button 1</button>
    <button class="button">Button 2</button>
</div>
<div class="container">
    <div class="game-info">
        <h2>Game Information</h2>
        <table class="brown-table">
            <tr>
                <th>게임 번호</th>
                <td>1</td>
            </tr>
            <tr>
                <th>테이블 번호</th>
                <td>1</td>
            </tr>
            <tr>
                <th>참가 비용</th>
                <td>1234</td>
            </tr>
            <tr>
                <th>보상 비율</th>
                <td>123123</td>
            </tr>
            <tr>
                <th>리워드 포인트</th>
                <td>123123</td>
            </tr>
            <tr>
                <th>게임 생성 시각</th>
                <td>123123</td>
            </tr>
        </table>
    </div>

    <div class="member-search">
        <h2>Member Search</h2>
        <label for="searchInput">Search Member:</label>
        <input type="text" id="searchInput" name="searchInput" placeholder="Enter member name">

        <!-- Display search results here -->
        <div class="search-results">
            <!-- Results will be displayed dynamically here -->
        </div>
    </div>


</div>

<div style="margin: 10px 0 10px 0">
    <label for="totalGamerCnt">총 참여 수 : <input type="number" id="totalGamerCnt" readonly
                                               style="border:none; outline:none;"></label>
    <label for="totalReward">총 참여 수 : <input type="number" id="totalReward" readonly
                                             style="border:none; outline:none;"></label>
</div>
<H3>참여 유저</H3>
<div>
    <table id='gamerTable' class="brown-table">
        <tr>
            <th>회원 번호</th>
            <th>참가자 이름</th>
            <th>참여 횟수</th>
            <th>추가 참여</th>
            <th>게임 종료</th>
            <th>참여 시간</th>
        </tr>
        <tr>
            <td>1</td>
            <td>asdf</td>
            <td>112312</td>
            <td>
                <button>추가 참여</button>
            </td>
            <td>
                <button>게임 종료</button>
            </td>
            <td>12312312</td>
        </tr>
        <tr>
            <td>1</td>
            <td>asdf</td>
            <td>112312</td>
            <td>
                <button class="table-button">추가 참여</button>
            </td>
            <td>
                <button class="table-button">게임 종료</button>
            </td>
            <td>12312312</td>
        </tr>
        <tr>
            <td>1</td>
            <td>asdf</td>
            <td>112312</td>
            <td>
                <button class="table-button">추가 참여</button>
            </td>
            <td>
                <button class="table-button">게임 종료</button>
            </td>
            <td>12312312</td>
        </tr>

    </table>
</div>
</body>
</html>
