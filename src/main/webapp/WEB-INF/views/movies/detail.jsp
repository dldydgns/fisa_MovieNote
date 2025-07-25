<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.dto.MovieDetailDTO" %>
<%! 
    private String getOrDefault(String param, String defaultVal) {
        return (param != null && !"null".equals(param)) ? param : defaultVal;
    }
%>
<%
    MovieDetailDTO movie = (MovieDetailDTO) request.getAttribute("movie");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= movie.getTitle() %> - 상세 보기</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #141414;
            color: #fff;
            padding: 40px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
            background-color: #1c1c1c;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(229, 9, 20, 0.3);
        }

        h1 {
            font-size: 32px;
            color: #e50914;
            margin-bottom: 20px;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
        }

        .info {
            font-size: 18px;
            margin-bottom: 14px;
        }

        .stars {
            color: #f5c518;
            font-size: 20px;
        }

        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }

        .btn {
            display: inline-block;
            padding: 10px 16px;
            font-size: 14px;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.2s;
            border: 1px solid transparent;
            cursor: pointer;
        }

        .btn-back {
            background-color: transparent;
            color: #f5c518;
            border: 1px solid #f5c518;
        }

        .btn-back:hover {
            background-color: #f5c518;
            color: #141414;
        }

        .btn-edit {
            background-color: #e50914;
            color: #fff;
        }

        .btn-edit:hover {
            background-color: #b00610;
        }
    </style>
</head>
<body>
<div class="container">
    <h1><%= movie.getTitle() %></h1>

    <div class="info">
        <strong>🗓 시청일:</strong> <%= movie.getWatchDate() %>
    </div>

    <div class="info">
        <strong>⭐ 평점:</strong> 
        <span class="stars">
            <%
                for (int i = 0; i < 5; i++) {
                    out.print(i < movie.getScore() ? "★" : "☆");
                }
            %>
        </span>
    </div>

    <div class="info">
        <strong>📝 리뷰:</strong><br>
        <pre style="white-space: pre-wrap;"><%= movie.getContent() %></pre>
    </div>

    <div class="button-group">
		<a href="/MovieNote/movies?page=<%= getOrDefault(request.getParameter("page"), "1") %>&sort=<%= getOrDefault(request.getParameter("sort"), "dateDesc") %>&size=<%= getOrDefault(request.getParameter("size"), "15") %>" class="btn btn-back">← 목록으로</a>
		<a href="/MovieNote/movies/<%= movie.getId() %>/edit?page=<%= request.getParameter("page") != null ? request.getParameter("page") : "" %>&sort=<%= request.getParameter("sort") != null ? request.getParameter("sort") : "" %>&size=<%= request.getParameter("size") != null ? request.getParameter("size") : "" %>" class="btn btn-edit">✏ 수정하기</a>

    </div>
</div>
</body>
</html>
