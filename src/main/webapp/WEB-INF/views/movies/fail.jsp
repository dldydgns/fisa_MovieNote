<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>작업 실패</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #fff0f0; padding: 20px; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); max-width: 600px; margin: auto; text-align: center; }
        .msg { font-size: 20px; color: #d32f2f; margin-bottom: 20px; }
        a { display: inline-block; margin-top: 30px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <div class="msg">
            <c:out value="${msg}" />
        </div>

        <a href="${pageContext.request.contextPath}/movies">목록으로 돌아가기</a>
    </div>
</body>
</html>
