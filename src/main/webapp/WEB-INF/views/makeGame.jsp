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
</head>
<body>
<header>
    <div class="header_container">
        <div class="logo_container">
            <a href="/">jjinka-Pub</a>
        </div>
    </div>
</header>

<form action="/game/makeGame" method="post" class="makeGame">
    <div>
        <label> 테이블 번호 :
            <select name="tableNo" >
                <option value="0">=== 선택 ===</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </label>
    </div>
    <div>
        <label for="rewardRate"> 상금 비율 :
            <input type="text" id="gameFee" name="gameFee"/>
        </label>
    </div>
    <div>
        <label for="rewardRate"> 상금 비율 :
            <input type="text" id="rewardRate" name="rewardRate"/>
        </label>
    </div>
    <input type="submit" class="btn" id="userRegister" value="게임 만들기"/>
</form>
</body>
<script>

</script>
</html>