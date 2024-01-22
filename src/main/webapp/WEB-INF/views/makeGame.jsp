<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-05(005)
  Time: 오전 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JJinkaPub</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <div class="header_container">
        <div class="logo_container">
            <a href="/">jjinka-Pub</a>
        </div>
    </div>
</header>
<div class="wrapper">
    <form action="/game/makeGame" method="post" class="makeGame" name="makeGameForm" style="margin-bottom: 100px">
        <div style="margin: 20px">
            <label class="label-wrapper"> 테이블 번호 :
                <select id="tableNo" name="tableNo" class="defaultSelector">
                    <option value="0">=== 선택 ===</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
            </label>
        </div>
        <div style="margin: 20px">
            <label class="label-wrapper" for="gameFee"> 참가 비용   :
                <input type="number" id="gameFee" name="gameFee" class="defaultInput"/>
            </label>
        </div>
        <div style="margin: 10px 10px 30px 10px">
            <label class="label-wrapper" for="rewardRate"> 상금 비율    :
                <input type="number" id="rewardRate" name="rewardRate" class="defaultInput"/>
            </label>
        </div>
        <input type="button" class="defaultBtn" id="makeGame" value="게임 만들기" onclick="fnMakeGame()"/>
    </form>
</div>
</body>
<script>
    const fnMakeGame = () => {
        let sTableNo = document.getElementById("tableNo").value;
        console.log("테이블 번호 : " + sTableNo);
        if(sTableNo === "0"){
            alert("테이블 번호를 선택 해 주세요.");
            return false;
        } else {
            fnChkGame(sTableNo);
        }
    }

    const fnChkGame = (tableNo) => {
        $.ajax({
            type: "post",
            url: "/game/chkInGame",
            data: {
                "tableNo": tableNo
            },
            success: function (res) {
                if(res === "ok"){
                    document.makeGameForm.submit();
                } else {
                    alert("해당 테이블은 게임 중 입니다.")
                }
            },
            error: function (err) {
                console.log("에러 발생", err);
                return false;
            }
        });
    }
</script>
</html>