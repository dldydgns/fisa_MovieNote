<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*, model.dto.MovieListDTO"%>
<%
    List<MovieListDTO> list = (List<MovieListDTO>) request.getAttribute("movies");
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int pageSize = 15;
    boolean hasNextPage = list != null && list.size() == pageSize;
    String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "dateDesc";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>🎬 영화 감상 리스트</title>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background: linear-gradient(120deg, #f8f9fa, #e9ecef);
	padding: 40px 0;
}

.top-actions {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 20px;
}

.new-review-btn {
    background-color: #38a3a5;
    color: white;
    padding: 10px 18px;
    text-decoration: none;
    font-size: 14px;
    border-radius: 6px;
    transition: background-color 0.2s ease;
}

.new-review-btn:hover {
    background-color: #2c7a7b;
}


h2 {
	text-align: center;
	font-size: 32px;
	margin-bottom: 30px;
	color: #212529;
}

.container {
	width: 95%;
	max-width: 1100px;
	margin: 0 auto;
	background: white;
	border-radius: 12px;
	padding: 30px 40px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
}

.sort-bar {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.sort-bar select {
	padding: 10px 15px;
	font-size: 14px;
	border: 1px solid #ced4da;
	border-radius: 6px;
	background-color: #fff;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

thead th {
	background-color: #495057;
	color: white;
	padding: 14px 12px;
	text-align: center;
	font-size: 15px;
	border-top: 1px solid #dee2e6;
}

tbody td {
	padding: 14px 12px;
	text-align: center;
	border-bottom: 1px solid #e9ecef;
	color: #495057;
	font-size: 15px;
}

tbody tr:hover {
	background-color: #f1f3f5;
}

.star {
	color: #f59f00;
	font-size: 16px;
}

.delete-btn {
	background: #ff6b6b;
	border: none;
	padding: 7px 14px;
	color: white;
	border-radius: 5px;
	cursor: pointer;
	font-size: 13px;
	transition: background 0.2s ease;
}

.delete-btn:hover {
	background: #fa5252;
}

.pagination {
	margin-top: 30px;
	text-align: center;
}

.pagination a, .pagination span {
	display: inline-block;
	margin: 0 5px;
	padding: 8px 14px;
	font-size: 14px;
	border-radius: 5px;
	text-decoration: none;
}

.pagination a {
	color: #495057;
	border: 1px solid #adb5bd;
}

.pagination a:hover {
	background-color: #ced4da;
}

.pagination span {
	background-color: #343a40;
	color: white;
}

.no-data {
	text-align: center;
	padding: 30px 0;
	font-size: 16px;
	color: #868e96;
}
</style>
</head>
<body>
	<div class="container">
		<h2>🎬 나의 영화 감상 리스트</h2>

		<div class="top-actions">
			<a href="/MovieNote/movies/new" class="new-review-btn">+ 새로운 리뷰
				쓰기</a>
		</div>


		<div class="sort-bar">
			<form method="get" action="/MovieNote/movies">
				<input type="hidden" name="page" value="<%= currentPage %>">
				<select name="sort" onchange="this.form.submit()">
					<option value="dateDesc"
						<%= "dateDesc".equals(sort) ? "selected" : "" %>>📅 시청일순
						(최신)</option>
					<option value="dateAsc"
						<%= "dateAsc".equals(sort) ? "selected" : "" %>>📅 시청일순
						(오래된)</option>
					<option value="scoreDesc"
						<%= "scoreDesc".equals(sort) ? "selected" : "" %>>⭐ 평점순
						(높은)</option>
					<option value="scoreAsc"
						<%= "scoreAsc".equals(sort) ? "selected" : "" %>>⭐ 평점순
						(낮은)</option>
				</select>
			</form>
		</div>

		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>시청일</th>
					<th>제목</th>
					<th>평점</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
            if (list != null && !list.isEmpty()) {
                for (MovieListDTO m : list) {
                    int score = m.getScore();
                    StringBuilder stars = new StringBuilder();
                    for (int i = 0; i < 5; i++) {
                        stars.append(i < score ? "★" : "☆");
                    }
        %>
				<tr>
					<td><%= m.getId() %></td>
					<td><%= m.getWatchDate() %></td>
					<td><%= m.getTitle() %></td>
					<td class="star"><%= stars.toString() %></td>
					<td>
						<form method="post"
							action="/MovieNote/movies/api/<%= m.getId() %>/delete"
							onsubmit="return confirm('정말 삭제하시겠습니까?');">
							<button type="submit" class="delete-btn">삭제</button>
						</form>
					</td>
				</tr>
				<%
                }
            } else {
        %>
				<tr>
					<td colspan="5" class="no-data">등록된 영화가 없습니다.</td>
				</tr>
				<%
            }
        %>
			</tbody>
		</table>

		<div class="pagination">
			<%
            if (currentPage > 1) {
        %>
			<a
				href="/MovieNote/movies?page=<%= currentPage - 1 %>&sort=<%= sort %>">◀
				이전</a>
			<%
            }
        %>
			<span><%= currentPage %></span>
			<%
            if (hasNextPage) {
        %>
			<a
				href="/MovieNote/movies?page=<%= currentPage + 1 %>&sort=<%= sort %>">다음
				▶</a>
			<%
            }
        %>
		</div>
	</div>
</body>
</html>
