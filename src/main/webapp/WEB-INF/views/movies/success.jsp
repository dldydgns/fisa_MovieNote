<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>작업 성공</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0fff0; padding: 20px; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); max-width: 600px; margin: auto; text-align: center; }
        .msg { font-size: 20px; color: #2e7d32; margin-bottom: 20px; }
        .movie { text-align: left; background: #f9f9f9; padding: 15px; border-radius: 6px; }
        a { display: inline-block; margin-top: 30px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <div class="msg">
            <c:out value="${msg}" />
        </div>

        <c:if test="${not empty movie}">
            <div class="movie">
                <p><strong>영화 ID:</strong> <c:out value="${movie.id}" /></p>
                <p><strong>제목:</strong> <c:out value="${movie.title}" /></p>
                <p><strong>감상일:</strong> <c:out value="${movie.watchDate}" /></p>
                <p><strong>평점:</strong> <c:out value="${movie.score}" /></p>
                <p><strong>내용:</strong><br/><c:out value="${movie.content}" /></p>
            </div>
        </c:if>

        <a href="${pageContext.request.contextPath}/movies?sort=${sort}&page=${page}&size=${size}">목록으로 돌아가기</a>
    </div>
</body>
</html>
