<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-23(023)
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>테이블 정보 입력</title>
    <style>
        body {
            background-color: #efebe9; /* 브라운 계통 배경색 */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            background-color: #d7ccc8; /* 브라운 계통 컨테이너 배경색 */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #4e342e; /* 브라운 계통 글자색 */
        }

        select, input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #a1887f; /* 브라운 계통 테두리 색상 */
            border-radius: 4px;
            background-color: #fff; /* 백그라운드 색상 */
            color: #4e342e; /* 브라운 계통 글자색 */
        }

        input[type="submit"] {
            background-color: #8d6e63; /* 브라운 계통 버튼 배경색 */
            color: #fff; /* 버튼 글자색 */
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #6d4c41; /* 버튼 호버 배경색 */
        }
    </style>

</head>
<body>
<div class="container">
    <h2 style="text-align: center; color: #4e342e;">테이블 정보 입력</h2>
    <form action="#" method="post">
        <label for="tableNumber">테이블 번호:</label>
        <select id="tableNumber" name="tableNumber" required>
            <option value="table1">테이블 1</option>
            <option value="table2">테이블 2</option>
            <option value="table3">테이블 3</option>
            <!-- 필요한 만큼 옵션을 추가하세요 -->
        </select>

        <label for="entryFee">참가 비용:</label>
        <input type="number" id="entryFee" name="entryFee" placeholder="참가 비용을 입력하세요" required>

        <label for="prizeMoney">상금 비용:</label>
        <input type="number" id="prizeMoney" name="prizeMoney" placeholder="상금 비용을 입력하세요" required>

        <input type="submit" value="제출">
    </form>
</div>
</body>
</html>
