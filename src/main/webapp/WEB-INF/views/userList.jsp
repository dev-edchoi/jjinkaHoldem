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
        <button onclick="location.href='/alphaAdmin'" class="button">메인 화면</button>
    </div>
    <div style="margin:auto">
        <!-- 검색 입력창 -->
        <label for="searchInput">유저 검색 : </label>
        <input type="text" id="searchInput" style="width: 300px" placeholder="유저 이름이나 전화번호로 검색" onkeyup="fnEnterKeyUp()" onblur="fnSearchUser()">
        <button onclick="fnSearchUser()" class="button">회원 검색</button>
    </div>
    <div style="margin-top: 20px">
        <table class="brown-table">
            <thead>
            <tr>
                <th>No.</th>
                <th>회원 전화번호</th>
                <th>회원 이름</th>
                <th>잔여 포인트</th>
                <th>추천 포인트</th>
                <th>가입 일자</th>
                <th>조회</th>
            </tr>
            </thead>
            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>${user.userNo}</td>
                    <td>
                        <a href="/alphaAdmin/user?userNo=${user.userNo}&page=${paging.page}">${user.phoneNumber}</a>
                    </td>
                    <td>${user.userName}</td>
                    <td><c:out value="${user.userPoint}">0</c:out></td>
                    <td><c:out value="${user.recPoint}">0</c:out></td>
                    <td>${user.registDate}</td>
                    <td>
                        <button class="table-button" onclick="fnUserDetail('${user.userNo}','${paging.page}')">조회
                        </button>
                    </td>
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
                <a href="/alphaAdmin/user/?page=${paging.page-1}">[이전]</a>
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
                    <a href="/alphaAdmin/user/?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${paging.page>=paging.maxPage}">
                <span>[다음]</span>
            </c:when>
            <c:otherwise>
                <a href="/alphaAdmin/user/?page=${paging.page+1}">[다음]</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
<script>
    const deleteMember = (userNo, userName) => {
        if (confirm(userName + " 회원을 삭제 하시겠습니까?")) {
            location.href = "/alphaAdmin/user/delete?userNo=" + userNo;
        } else {
            alert("회원 삭제가 취소 됐습니다.")
            return false;
        }
    }

    const fnUserDetail = (userNo, page) => {
        location.href = "/alphaAdmin/user?userNo=" + userNo + "&page=" + page;
    }

    const fnSearchUser = () => {
        let searchWord = document.getElementById("searchInput").value;
        console.log(searchWord);
        location.href = "/alphaAdmin/user/?searchWord=" + searchWord;

        // $.ajax({
        //     type: "post",
        //     url: "/user/searchUserByNameOrNum",
        //     data: {
        //         "searchWord": searchWord
        //     },
        //     success: function (res) {
        //         console.log(res);
        //         location.href = "/user/?searchWord=" + searchWord;
        //     },
        //     error: function (err) {
        //         console.log("에러 발생", err);
        //     }
        // });
    }

    const fnEnterKeyUp = () =>{
        if (window.event.keyCode === 13) {
            fnSearchUser()
        }
    }
</script>
</html>