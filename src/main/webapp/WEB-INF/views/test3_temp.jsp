<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-23(023)
  Time: 오후 4:11
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Game Page</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            margin: 0;
        }

        .container {
            display: flex;
            margin: 20px auto;
        }

        .brown-table {
            width: 100%;
            border-collapse: collapse;
        }

        .brown-table th,
        .brown-table td {
            padding: 8px;
            border: 1px solid #cda45e;
            background-color: #e2c8a6;
            color: #5a3a20;
        }

        .brown-table th {
            font-weight: bold;
            text-align: left;
            background-color: #795548;
            color: #fff;
            width: 240px;
        }

        .brown-table td {
            text-align: left;
        }

        .game-info,
        .member-search {
            flex: 1;
            padding: 20px;
            background-color: #d2b48c;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 0 10px;
        }

        h2 {
            color: #795548;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .data-table th, .data-table td {
            border: 1px solid #795548;
            padding: 8px;
            text-align: left;
        }

        .data-table th {
            background-color: #795548;
            color: #fff;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #3e2723;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #795548;
            border-radius: 5px;
            box-sizing: border-box;
        }

        /* Optional: Style for displaying search results */
        .search-results {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #795548;
            border-radius: 5px;
            background-color: #fff;
            max-height: 200px;
            overflow-y: auto;
        }

        .buttons-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .button {
            background-color: #795548;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }

        .button:hover {
            background-color: #4e342e;
        }

        /* Add more styles as needed */
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
<H1>참여 유저</H1>
<div style="margin: 10px 0 10px 0">
    <label for="totalGamerCnt">총 참여 수 : <input type="number" id="totalGamerCnt" readonly
                                               style="border:none; outline:none;"></label>
</div>
<div style="margin: 10px 0 15px 0">
    <label for="totalReward">총 참여 수 : <input type="number" id="totalReward" readonly
                                             style="border:none; outline:none;"></label>
</div>
<div id="gamerList">
    <table id='gamerTable'>
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
                <button>추가 참여</button>
            </td>
            <td>
                <button>게임 종료</button>
            </td>
            <td>12312312</td>
        </tr>

    </table>
</div>
</body>
</html>