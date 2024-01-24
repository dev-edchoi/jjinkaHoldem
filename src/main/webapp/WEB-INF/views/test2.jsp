<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Brown Table Page</title>
    <style>
        /* 브라운 계열의 기본 스타일 정의 */
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            margin: 0;
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

        .table-button {
            background-color: #795548; /* 버튼 배경색 */
            color: #fff; /* 버튼 텍스트 색상 */
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .table-button:hover {
            background-color: #4e342e; /* 버튼에 호버 효과 시 배경색 변경 */
        }
    </style>
</head>
<body>

<table class="data-table">
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>1</td>
        <td>John Doe</td>
        <td><button class="table-button">Edit</button></td>
    </tr>
    <tr>
        <td>2</td>
        <td>Jane Doe</td>
        <td><button class="table-button">Delete</button></td>
    </tr>
    <!-- Add more rows as needed -->
    </tbody>
</table>

</body>
</html>