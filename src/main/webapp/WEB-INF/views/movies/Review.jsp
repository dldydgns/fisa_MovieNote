<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // POST 요청일 경우에만 인코딩 설정 (GET일 땐 하지 않는 게 안전)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
    }

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String score = request.getParameter("score");
    String createDate = request.getParameter("createDate");
    String watchDate = request.getParameter("watchDate");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 확인</title>
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
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .review-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.6s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            text-align: center;
            color: #E50914;
            font-size: 28px;
            margin-bottom: 30px;
        }
        .label {
            font-weight: bold;
            margin-top: 18px;
            color: #ccc;
            font-size: 15px;
        }
        .value {
            margin-top: 6px;
            padding: 10px 14px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 10px;
            font-size: 15px;
            color: #f0f0f0;
            white-space: pre-wrap;
        }
        .button-group {
            margin-top: 30px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }
        button {
            padding: 12px 24px;
            font-size: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s;
        }
        .edit-btn {
            background-color: #E50914;
            color: white;
        }
        .edit-btn:hover {
            background-color: #b00610;
            transform: translateY(-1px);
        }
        .back-btn {
            background-color: transparent;
            border: 1px solid #777;
            color: #aaa;
        }
        .back-btn:hover {
            border-color: #aaa;
            color: #fff;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="review-container">
    <h2>✅ 리뷰 확인</h2>
    <div class="review-box">
        <div class="label">영화 제목</div>
        <div class="value"><%= title != null ? title : "" %></div>

        <div class="label">작성일</div>
        <div class="value"><%= createDate != null ? createDate : "" %></div>

        <div class="label">시청일</div>
        <div class="value"><%= watchDate != null ? watchDate : "" %></div>

        <div class="label">평점</div>
        <div class="value"><%= score != null ? score : "" %> 점</div>

        <div class="label">리뷰 내용</div>
        <div class="value"><pre style="white-space: pre-wrap;"><%= content != null ? content : "" %></pre></div>
    </div>

    <form action="Review_edit.jsp" method="post">
        <!-- 수정 페이지로 전달할 데이터 hidden 처리 -->
        <input type="hidden" name="title" value="<%= title != null ? title : "" %>">
        <input type="hidden" name="content" value="<%= content != null ? content : "" %>">
        <input type="hidden" name="score" value="<%= score != null ? score : "" %>">
        <input type="hidden" name="watchDate" value="<%= watchDate != null ? watchDate : "" %>">

        <button type="submit">✏️ 수정하기</button>
        <button type="button" onclick="history.back();">이전으로</button>
    </form>
</body>
</html>
