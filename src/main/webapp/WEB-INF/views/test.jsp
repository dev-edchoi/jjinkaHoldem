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
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

    <script type="text/javascript">
        $(function () {
            $("#date1").datepicker();
        });

        $(function () {
            $("#date2").datepicker({
                showOn: "both",
                buttonImage: "images/calendar.gif",
                buttonImageOnly: true,
                buttonText: "Select date"
            });
        });
        $(function () {
            $("#date3").datepicker({
                onSelect: function (dateText, inst) {
                    console.log(dateText);
                }
            });
        });

    </script>
    <style>
        input {
            width: 200px;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #a1887f; /* 브라운 계통 테두리 색상 */
            border-radius: 4px;
            background-color: #f5f5f5;
            color: #4e342e; /* 브라운 계통 글자색 */
        }

        .small-button {
            background-color: #795548;
            color: #fff;
            padding: 5px 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }

        .small-button:hover {
            background-color: #4e342e;
        }
    </style>

</head>
<body>
<input type="text" name="date" id="date1" size="12"/>
<input type="text" name="date" id="date2" size="12"/>
<input type="text" name="date" id="date3" size="12"/>
<input type="button" class="small-button" value="달력" onclick="$('#date3').datepicker('show');"/>
</body>
</html>
