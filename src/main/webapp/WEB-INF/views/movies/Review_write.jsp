<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
    private String getOrDefault(String param, String defaultVal) {
        return (param != null && !"null".equals(param)) ? param : defaultVal;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
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
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 50px 40px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 8px 40px rgba(0, 0, 0, 0.4);
            animation: fadeIn 0.6s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            text-align: center;
            color: #E50914;
            font-size: 30px;
            margin-bottom: 35px;
        }
        label {
            display: block;
            margin-top: 20px;
            margin-bottom: 6px;
            font-size: 15px;
            color: #ddd;
        }
        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 12px 14px;
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            color: #fff;
            font-size: 15px;
            transition: 0.2s;
        }
        input:focus,
        select:focus,
        textarea:focus {
            border-color: #E50914;
            outline: none;
            background: rgba(255, 255, 255, 0.1);
        }
        textarea {
            resize: vertical;
            min-height: 120px;
        }
        .button-group {
            margin-top: 35px;
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
    <h2>🎬 영화 리뷰 작성</h2>


    <!-- action 경로는 컨트롤러로 설정할 것! -->
    <form action="/MovieNote/movies/api/new" method="post">

        <label for="title">영화 제목</label>
        <input type="text" name="title" id="title" required>

        <label for="watchDate">시청일</label>
        <input type="date" name="watchDate" id="watchDate">

        <label for="score">평점</label>
        <select name="score" id="score" required>
            <option value="">선택하세요</option>
            <option value="1">⭐</option>
            <option value="2">⭐⭐</option>
            <option value="3">⭐⭐⭐</option>
            <option value="4">⭐⭐⭐⭐</option>
            <option value="5">⭐⭐⭐⭐⭐</option>
            
        </select>

        <label for="content">리뷰 내용</label>
        <textarea name="content" id="content" rows="6" required></textarea>

        <button type="submit">작성 완료</button>
        <button type="button" class="cancel" onclick="location.href='/MovieNote/movies?page=<%= getOrDefault(request.getParameter("page"), "1") %>&sort=<%= getOrDefault(request.getParameter("sort"), "dateDesc") %>&size=<%= getOrDefault(request.getParameter("size"), "15") %>'">취소</button>

    </form>
</body>
</html>
