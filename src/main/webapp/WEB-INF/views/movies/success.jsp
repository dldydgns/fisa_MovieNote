<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>작업 성공</title>
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Pretendard', sans-serif;
            background: radial-gradient(circle at top left, #1a1a1a, #0e0e0e);
            color: #fff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }
        .container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
            text-align: center;
            animation: fadeIn 0.6s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .msg {
            font-size: 22px;
            color: #E50914;
            margin-bottom: 30px;
        }
        .movie {
            text-align: left;
            background: rgba(255, 255, 255, 0.08);
            padding: 20px;
            border-radius: 12px;
            font-size: 15px;
            color: #ddd;
        }
        .movie p {
            margin: 10px 0;
        }
        a {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 24px;
            text-decoration: none;
            border: 1px solid #888;
            color: #aaa;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        a:hover {
            color: #fff;
            border-color: #fff;
            background: rgba(255,255,255,0.1);
        }
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
