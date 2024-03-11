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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 10px auto;
            padding: 5px 0 5px 0;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            table-layout: fixed;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
            width: 33%; /* 각 열이 동일한 크기로 나눠집니다. */
            box-sizing: border-box;
            word-wrap: break-word;
        }

        th {
            background-color: #f2f2f2;
        }

        @media screen and (max-width: 600px) {
            th, td {
                width: 100%; /* 모바일 화면에서 각 열이 전체 너비를 차지하도록 설정합니다. */
            }
        }
    </style>
    <title>포인트 조회</title>
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
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${userPointLog}" var="pointLog">
            <tr>
                <td>${pointLog.date}</td>
                <td>${pointLog.point}</td>
                <c:choose>
                    <c:when test="${pointLog.reasonForChange == 4}">
                        <td>게임 참여</td>
                    </c:when>
                    <c:when test="${pointLog.reasonForChange == 3}">
                        <td>기타</td>
                    </c:when>
                    <c:when test="${pointLog.reasonForChange == 2}">
                        <td>포인트 선물</td>
                    </c:when>
                    <c:when test="${pointLog.reasonForChange == 1}">
                        <td>게임 우승 상금</td>
                    </c:when>
                    <c:otherwise>
                        <td>일반 충전</td>
                    </c:otherwise>
                </c:choose>
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
</script>

</body>
</html>
