<%--
  Created by IntelliJ IDEA.
  User: Tobesoft
  Date: 2024-01-03(003)
  Time: 오후 3:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/paging.css">
</head>
<body>
<header>
    <jsp:include page="header.jsp"></jsp:include>
</header>
<div>
    <div class="buttons-container">
        <button onclick="fnBackToUserDetail()" class="button">유저 상세</button>
    </div>
    <div style="margin-top: 20px">
        <table class="blue-table">
            <thead>
            <tr>
                <th>No.</th>
                <th>변동 포인트</th>
                <th>변동 이유</th>
                <th>참가 게임 번호</th>
                <th>Etc.</th>
                <th>포인트 받은 사람</th>
                <th>포인트 준 사람</th>
                <th>변동 전 금액</th>
                <th>변동 후 금액</th>
                <th>변동 일자</th>
            </tr>
            </thead>
            <c:forEach items="${userPointList}" var="userPointList">
                <tr>
                    <td>${userPointList.userNo}</td>
                    <td>${userPointList.point}</td>
                    <td>${userPointList.typeName}</td>
                    <td>${userPointList.joinGameNo}</td>
                    <td>${userPointList.etcReason}</td>
                    <td>${userPointList.receiverUserName}</td>
                    <td>${userPointList.senderUserName}</td>
                    <td>${userPointList.previous_balance}</td>
                    <td>${userPointList.later_balance}</td>
                    <td>${userPointList.date}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<div class="wrap">
    <div class="pagination">
        <c:choose>
            <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
            <c:when test="${paging.page<=1}">
                <span>[이전]</span>
            </c:when>
            <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
            <c:otherwise>
                <a href="/alphaAdmin/userPoint/userPointLog?userNo=${userNo}&page=${paging.page-1}">[이전]</a>
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
                    <a href="/alphaAdmin/userPoint/userPointLog?userNo=${userNo}&page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${paging.page>=paging.maxPage}">
                <span>[다음]</span>
            </c:when>
            <c:otherwise>
                <a href="/alphaAdmin/userPoint/userPointLog?userNo=${userNo}&page=${paging.page+1}">[다음]</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
<script>
    window.onload = function (){

    }

    const fnBackToUserDetail = () => {
        let userNo = '${userNo}'
        location.href="/alphaAdmin/user?userNo=" + userNo;
    }
</script>
</html>