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
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 5px 10px;
        }

        /* Popup styles */
        .popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .popup-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>

</head>
<body>

<table>
    <tr>
        <td>Member 1</td>
        <td><button onclick="openPopup(1)">Open Popup</button></td>
    </tr>
    <tr>
        <td>Member 2</td>
        <td><button onclick="openPopup(2)">Open Popup</button></td>
    </tr>
    <!-- Add more rows as needed -->
</table>

<div id="popup" class="popup">
    <div class="popup-content">
        <span class="close" onclick="closePopup()">&times;</span>
        <h2>Member List</h2>
        <ul id="memberList"></ul>
        <button onclick="getSelectedMember()">Get Selected Member</button>
    </div>
</div>
</body>
<script>
    function openPopup(memberId) {
        // Open the popup
        document.getElementById('popup').style.display = 'block';

        // Fetch member list and update the popup content
        fetchMemberList(memberId);
    }

    function closePopup() {
        // Close the popup
        document.getElementById('popup').style.display = 'none';
    }

    function fetchMemberList(selectedMemberId) {
        // Simulate fetching member list (replace with actual API call)
        const memberList = ['Member 1', 'Member 2', 'Member 3'];

        // Update the popup content with the member list
        const memberListElement = document.getElementById('memberList');
        memberListElement.innerHTML = '';

        memberList.forEach((member, index) => {
            const listItem = document.createElement('li');
            listItem.textContent = member;
            listItem.onclick = () => selectMember(index + 1, selectedMemberId);
            memberListElement.appendChild(listItem);
        });
    }

    function selectMember(selectedId, originalId) {
        // Handle the selected member
        alert(`Selected Member: ${selectedId}`);

        // Close the popup (optional)
        closePopup();
    }

    function getSelectedMember() {
        // Logic to get the selected member if needed
        // (you can implement additional functionality here)
    }
</script>
</html>
