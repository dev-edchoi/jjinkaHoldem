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
            font-family: Arial, sans-serif;
            background-color: #eee;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #container {
            background-color: #f5f5f5;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #8B4513; /* 브라운 계열의 색상 */
            color: #fff;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        input {
            padding: 8px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            padding: 12px 20px;
            background-color: #8B4513;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #6b3510; /* 더 진한 브라운 계열의 색상 */
        }
    </style>
</head>
<body>
<div id="container">
    <table id="userTable">
        <thead>
        <tr>
            <th>User Number</th>
            <th>Phone Number</th>
            <th>Member Name</th>
            <th>Prize</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>123-456-7890</td>
            <td>John Doe</td>
            <td><input type="text" placeholder="Enter Prize"></td>
        </tr>
        <tr>
            <td>1</td>
            <td>123-456-7890</td>
            <td>John Doe</td>
            <td><input type="text" placeholder="Enter Prize"></td>
        </tr>
        <tr>
            <td>1</td>
            <td>123-456-7890</td>
            <td>John Doe</td>
            <td><input type="text" placeholder="Enter Prize"></td>
        </tr>
        <!-- Add more rows as needed -->
        </tbody>
    </table>

    <button onclick="confirmAction()">Confirm</button>
</div>

<script>
    function getTableCellValues() {
        var table = document.getElementById('userTable');
        var rows = table.getElementsByTagName('tr');
        var values = [];

        for (var i = 1; i < rows.length; i++) {
            var cells = rows[i].getElementsByTagName('td');
            var rowData = [];

            for (var j = 0; j < cells.length - 1; j++) {
                // Exclude the last cell (input field) from the loop
                rowData.push(cells[j].innerText);
            }

            // Get the value from the input field
            var prizeInput = cells[cells.length - 1].getElementsByTagName('input')[0];
            console.log(i +"번째 : " +prizeInput.value)
            rowData.push(prizeInput.value);

            values.push(rowData);
        }

        console.log(values);
        // You can use the 'values' array as needed (e.g., send it to the server, process the data, etc.)
    }

    function confirmAction() {
        getTableCellValues();
        // Add your confirmation logic here
        alert("Confirmed!"); // Example: Show an alert
    }
</script>

</body>

</html>
