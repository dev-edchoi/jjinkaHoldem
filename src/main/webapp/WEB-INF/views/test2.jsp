<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Alpha Page</title>
</head>
<style>
    /* 브라운 계열의 기본 스타일 정의 */
    body {
        background-color: #f5f5f5;
        font-family: Arial, sans-serif;
        margin: 0;
    }

    .header {
        background-color: #795548; /* 헤더 배경색 */
        text-align: center;
        height: fit-content;
    }

    .logo {
        max-width: 100%;
        height: auto;
    }

    .container {
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        background-color: #d2b48c; /* 배경색 */
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .header-button {
        background-color: #795548; /* 버튼 배경색 */
        color: #fff; /* 버튼 텍스트 색상 */
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-bottom: 20px;
    }

    .header-button:hover {
        background-color: #4e342e; /* 버튼에 호버 효과 시 배경색 변경 */
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .data-table th, .data-table td {
        border: 1px solid #795548; /* 테이블 테두리 색상 */
        padding: 8px;
        text-align: left;
    }

    .data-table th {
        background-color: #795548; /* 테이블 헤더 배경색 */
        color: #fff; /* 테이블 헤더 텍스트 색상 */
    }
</style>
<body>

<header class="header">
    <img src="${pageContext.request.contextPath}/img/ALPHA_black_60.png" alt="Alpha Logo" class="logo">
</header>

<div class="container">
    <button class="header-button">Click me</button>

    <table class="data-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>John Doe</td>
            <td>30</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Jane Doe</td>
            <td>25</td>
        </tr>
        <!-- Add more rows as needed -->
        </tbody>
    </table>
</div>

</body>
</html>