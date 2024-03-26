<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-03-06(006)
  Time: 오후 4:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/paging.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/point/checkUserPoint.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap">
    <title>포인트 조회</title>
    <style>
        .header {
            display: flex;
            justify-content: center; /* 가로 중앙 정렬 */
        }

        .logo {
            max-width: 100%; /* 로고 이미지의 최대 너비를 100%로 설정하여 반응형으로 만듭니다. */
            height: auto; /* 이미지의 높이를 자동으로 조정하여 비율을 유지합니다. */
        }
    </style>
</head>
<body>
<header class="header">
    <img src="${pageContext.request.contextPath}/img/ALPHA_black_60.png" alt="Alpha Logo" class="logo">
</header>
<div class="container">
    <h2 style="text-align: center">${userName}님의 포인트 변동 내역</h2>
    <table>
        <thead>
            <tr>
                <th>변동일자</th>
                <th>변동포인트</th>
                <th>변동이유</th>
                <th>잔액</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${userPointLog}" var="pointLog">
            <tr onclick="showPointModal('${pointLog.date}','${pointLog.point}','${pointLog.typeName}','${pointLog.joinGameNo}', '${pointLog.previous_balance}', '${pointLog.later_balance}')">
                <td>${pointLog.date}</td>
                <td>${pointLog.point}</td>
                <td>${pointLog.typeName}</td>
                <td>${pointLog.later_balance}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="wrap">
    <div class="pagination">
        <c:choose>
            <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
            <c:when test="${paging.page<=1}">
                <span>[이전]</span>
            </c:when>
            <c:otherwise>
                <a onclick="tranPage('${userNo}', ${paging.page-1})">[이전]</a>
            </c:otherwise>
        </c:choose>

        <%--  for(int i=startPage; i<=endPage; i++)      --%>
        <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
            <c:choose>
                <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                <c:when test="${i eq paging.page}">
                    <span class="active">${i}</span>
                </c:when>
                <c:otherwise>
                    <a onclick="tranPage('${userNo}', ${i})">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${paging.page>=paging.maxPage}">
                <span>[다음]</span>
            </c:when>
            <c:otherwise>
                <a onclick="tranPage('${userNo}', ${paging.page+1})">[다음]</a>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="modal" class="modal-overlay" style="display: none">
        <div class="modal-window">
            <div class="content" id="content"></div>
            <div class="close-area">닫기</div>
        </div>
    </div>

</div>
<script>
    window.onload = function () {
        let userName = '${userName}';
        if(!userName){
            alert("포인트 조회를 먼저 진행해주세요.");
            location.href ="/point";
        }
    }

    const tranPage = (userNo, idx) => {
        let userName = '${userName}';
        let form = document.createElement('form'); // 폼객체 생성

        let obj1 = document.createElement('input'); // 값이 들어있는 녀석의 형식
            obj1.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
            obj1.setAttribute('name', 'userNo'); // 객체이름
            obj1.setAttribute('value', userNo); //객체값

        let obj2 = document.createElement('input'); // 값이 들어있는 녀석의 형식
            obj2.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
            obj2.setAttribute('name', 'userName'); // 객체이름
            obj2.setAttribute('value', userName); //객체값

        let obj3 = document.createElement('input'); // 값이 들어있는 녀석의 형식
            obj3.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
            obj3.setAttribute('name', 'page'); // 객체이름
            obj3.setAttribute('value', idx); //객체값

        form.appendChild(obj1);
        form.appendChild(obj2);
        form.appendChild(obj3);

        form.setAttribute('name', 'tranPageForm');
        form.setAttribute('method', 'post');
        form.setAttribute('action', "/point/checkUserPoint");

        document.body.appendChild(form);
        document.tranPageForm.submit();
    }

    const modal = document.getElementById("modal");
    const closeBtn = modal.querySelector(".close-area");
    closeBtn.addEventListener("click", e => {
        modal.style.display = "none"
    });

    const showPointModal = (date, point, typeName, joinGameNo,previous_balance ,later_balance) => {
        let pointLogTable = "<table>";
            pointLogTable += "<tr><th>변동일자</th></tr>";
            pointLogTable += "<tr><td>" + date + "</td></tr>";
            pointLogTable += "<tr><th>변경 전 포인트</th></tr>";
            pointLogTable += "<tr><td>" + previous_balance + "</td></tr>";
            pointLogTable += "<tr><th>변동포인트</th></tr>";
            pointLogTable += "<tr><td>" + point + "</td></tr>";
            pointLogTable += "<tr><th>변경 후 포인트</th></tr>";
            pointLogTable += "<tr><td>" + later_balance + "</td></tr>";
            pointLogTable += "<tr><th>변동이유</th></tr>";pointLogTable += "<tr><td>" + typeName + "</td></tr>";
            pointLogTable += "<tr><th>참가게임</th></tr>";
            pointLogTable += "<tr><td>" + joinGameNo + "</td></tr>";
            pointLogTable += "</table>";

        document.getElementById('content').innerHTML = pointLogTable;
        modal.style.display = "flex"
    }
</script>
</body>
</html>
