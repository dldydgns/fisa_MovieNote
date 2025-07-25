<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <style>
        body {
            font-family: Arial;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
        }
        label {
            display: block;
            margin-top: 15px;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-top: 5px;
        }
        button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
        button.cancel {
            background-color: gray;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h2>🎬 영화 리뷰 작성</h2>


    <!-- action 경로는 컨트롤러로 설정할 것! -->
    <form action="/MovieNote/views/movies/Review.jsp" method="post">

        <label for="title">영화 제목</label>
        <input type="text" name="title" id="title" required>

		<label for="createDate">작성일</label>
		<input type="date" name="createDate" id="createDate" required>

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

        <label for="isfix">수정 여부</label>
        <select name="isfix" id="isfix" required>
            <option value="">선택하세요</option>
            <option value="true">예</option>
            <option value="false">아니오</option>
        </select>

        <button type="submit">작성 완료</button>
        <button type="button" class="cancel" onclick="location.href='/MovieNote/views/movies/Review.jsp'">취소</button>
    </form>
</body>
</html>
