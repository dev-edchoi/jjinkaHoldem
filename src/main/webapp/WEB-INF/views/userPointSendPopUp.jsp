<%--
  Created by IntelliJ IDEA.
  User: ddilg
  Date: 2024-02-01
  Time: 오후 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .popup-container {
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 630px;
            height: 570px;
            padding: 20px;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .user-info {
            font-weight: bold;
            color: #6c757d;
        }

        .gift-input-container {
            display: flex;
            align-items: center;
        }

        #giftPoints {
            margin-left: 10px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .popup-body {
            text-align: center;
        }

        #searchInput {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        #userTable {
            width: 100%;
            border-collapse: collapse;
        }

        #userTable th,
        #userTable td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        #userTable th {
            background-color: #6c757d;
            color: #fff;
        }

        .gift-button {
            background-color: #6c757d;
            color: #fff;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="popup-container">
    <div class="popup-header">
        <span class="user-info">User No: ${userInfo.userNo} | User Point: ${userInfo.userPoint}</span>
        <div class="gift-input-container">
            <label for="giftPoints">Gift Points:</label>
            <input type="number" id="giftPoints" placeholder="Enter points">
        </div>
    </div>
    <div class="popup-body">
        <input type="text" id="searchInput" placeholder="Search by user name" onblur="findUserByName()">
        <div class="search-results" id="search-list">
            <!-- Results will be displayed dynamically here -->
            <table id="userTable">
                <!-- Table rows will be dynamically added here -->
                <thead>
                    <tr>
                        <th>유저 이름</th>
                        <th>유저 전화 번호</th>
                        <th>선물</th>
                    </tr>
                </thead>
            </table>
        </div>

    </div>
</div>
</body>
<script>
    const findUserByName = () => {
        let userName = document.getElementById("searchInput").value
        if(userName != null || userName !== ""){
            $.ajax({
                type: "post",
                url: "/user/findByUserName",
                data: {
                    "userName": userName
                },
                success: function (res) {
                    let output = "<table id='userTable'>";
                        output += "<thead><tr><th>유저 이름</th>";
                        output += "<th>유저 전화 번호</th>";
                        output += "<th>선물</th>";
                        output += "</tr></thead>";

                    for (let i in res) {
                        output += "<tr>";
                        output += "<td>" + res[i].userName + "</td>";
                        output += "<td>" + res[i].phoneNumber + "</td>";
                        output += "<td><button class='gift-button' onclick='sendPointToUser(" + res[i].userNo + ",\"" + res[i].userName + "\")'>" + "포인트 선물" + "</button></td>";
                        output += "</tr>";
                    }
                    output += "</table>";
                    document.getElementById('search-list').innerHTML = output;
                },
                error: function (err) {
                    console.log("에러 발생", err);
                }
            });
        }
    }

    const sendPointToUser = (receiverUserNo, receiverUserName) => {
        let pointToSend = document.getElementById('giftPoints').value
        let senderUserNo = '${userInfo.userNo}';
        let pointUserHave = '${userInfo.userPoint}';

        if(!pointToSend) {
            alert("선물 할 포인트를 입력하세요.");
            return false;
        }

        if(parseInt(pointUserHave) < parseInt(pointToSend)){
            alert("선물 할 포인트가 충분하지 않습니다.")
        } else {
            if(confirm(receiverUserName + "에게 포인트 : " + pointToSend + " 만큼 보내겠습니까?" )) {
                $.ajax({
                    type: "post",
                    url: "/user/sendPointToUser",
                    data: {
                        "senderUserNo" : senderUserNo,
                        "receiverUserNo": receiverUserNo,
                        "pointToSend" : pointToSend,
                    },
                    success: function (res) {
                        if(res === "true"){
                            window.open('', '_self', '');
                            window.close();
                            window.opener.location.reload();
                        } else {
                            alert("에러가 발생했습니다.");
                        }
                    },
                    error: function (err) {
                        console.log("에러 발생", err);
                    }
                });
            } else {
                return false;
            }
        }
    }
</script>
</html>
