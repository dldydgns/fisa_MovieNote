<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.dto.MovieDetailDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    MovieDetailDTO review = (MovieDetailDTO) request.getAttribute("review");
    if (review == null) {
%>
    <p>리뷰 정보를 불러올 수 없습니다.</p>
<%
        return;
    }

    // 날짜 포맷 예시 (필요 시 사용)
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String formattedWatchDate = (review.getWatchDate() != null) ? sdf.format(review.getWatchDate()) : "";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 수정</title>
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <style>
        /* ...기존 스타일 생략 (변경 없음)... */
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
        .form-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
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
        label {
            display: block;
            margin-top: 18px;
            font-size: 15px;
            color: #ddd;
        }
        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 12px 14px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            color: #fff;
            font-size: 15px;
            margin-top: 6px;
            transition: 0.2s;
        }
        input:focus,
        select:focus,
        textarea:focus {
            border-color: #E50914;
            outline: none;
        }
        textarea {
            resize: vertical;
            min-height: 120px;
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
        .submit-btn {
            background-color: #E50914;
            color: white;
        }
        .submit-btn:hover {
            background-color: #b00610;
            transform: translateY(-1px);
        }
        .cancel-btn {
            background-color: transparent;
            border: 1px solid #777;
            color: #aaa;
        }
        .cancel-btn:hover {
            border-color: #aaa;
            color: #fff;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>✏️ 영화 리뷰 수정</h2>

        <form action="<%= request.getContextPath() %>/reviews/edit" method="post">
            <input type="hidden" name="id" value="<%= review.getId() %>">
    		<input type="hidden" name="page" value="<%= request.getParameter("page") != null ? request.getParameter("page") : "1" %>">
    		<input type="hidden" name="sort" value="<%= request.getAttribute("sort") != null ? request.getAttribute("sort") : "" %>">

            <label for="title">영화 제목</label>
            <input type="text" name="title" id="title" value="<%= review.getTitle() %>" required>

            <label for="watchDate">시청일</label>
            <input type="date" name="watchDate" id="watchDate" value="<%= formattedWatchDate %>">

            <label for="score">평점</label>
            <select name="score" id="score" required>
                <option value="">선택하세요</option>
                <% for (int i = 1; i <= 5; i++) {
                       String stars = "⭐".repeat(i);
                       String selected = (review.getScore() == i) ? "selected" : "";
                %>
                    <option value="<%= i %>" <%= selected %>><%= stars %></option>
                <% } %>
            </select>

            <label for="content">리뷰 내용</label>
            <textarea name="content" id="content" rows="6" required><%= review.getContent() %></textarea>

            <!-- isfix 필드는 현재 MovieDetailDTO에 없으므로 주석처리
            <label for="isfix">수정 여부</label>
            <select name="isfix" id="isfix" required>
                <option value="">선택하세요</option>
                <option value="true">예</option>
                <option value="false">아니오</option>
            </select>
            -->

            <div class="button-group">
                <button type="submit" class="submit-btn">수정 완료</button>
                <button type="button" class="cancel-btn" onclick="location.href='<%= request.getContextPath() %>/reviews/edit'">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
