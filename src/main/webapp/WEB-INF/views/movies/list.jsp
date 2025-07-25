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
<title>🎬 나의 영화 감상 리스트</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background: linear-gradient(to right, #141e30, #243b55);
	color: #fff;
	padding: 40px 0;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

h2 {
	text-align: center;
	font-size: 48px; /* 더 큼 */
	margin-top: 40px; margin-bottom : 30px;
	color: #ffffff;
	margin-bottom: 30px; /* 흰색 */
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.new-review-btn {
	background-color: #e50914;
	padding: 12px 20px;
	color: #fff;
	border: none;
	border-radius: 5px;
	font-size: 14px;
	cursor: pointer;
	text-decoration: none;
}

.new-review-btn:hover {
	background-color: #b00610;
}

.sort-bar select {
	background-color: #222;
	color: #fff;
	border: 1px solid #444;
	padding: 10px;
	border-radius: 4px;
}

.movie-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
	gap: 20px;
}

/*
.movie-card {
	background-color: #1c1c1c;
	border-radius: 10px;
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	padding: 0;
	position: relative;
}
*/
.movie-card {
	background-color: #1c1c1c;
	border-radius: 8px;
	padding: 12px;
	transition: transform 0.2s ease;
	min-height: auto; /* ← 기본 높이만 사용 */
	height: fit-content; /* ← 내용에 따라 높이 자동 조절 */
}

.movie-card:hover {
	transform: scale(1.05);
	box-shadow: 0 0 15px rgba(229, 9, 20, 0.6);
}

/*
.movie-thumbnail {
	width: 100%;
	height: 280px;
	background-image:
		url('https://via.placeholder.com/300x400?text=No+Image');
	background-size: cover;
	background-position: center;
	border-radius: 10px 10px 0 0;
}
*/
.movie-info {
	padding: 15px;
}

.movie-title {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 5px;
	color: #fff;
}

.movie-date, .movie-score {
	font-size: 14px;
	color: #ccc;
	margin-bottom: 6px;
}

.stars {
	color: #f5c518;
	letter-spacing: 1px;
}

.delete-form {
	margin-top: 10px;
}

.delete-btn {
	background-color: #e50914;
	border: none;
	color: white;
	padding: 6px 10px;
	font-size: 13px;
	border-radius: 4px;
	cursor: pointer;
}

.pagination {
	text-align: center;
	margin-top: 30px;
}

.pagination a, .pagination span {
	display: inline-block;
	margin: 0 6px;
	padding: 8px 14px;
	font-size: 14px;
	border-radius: 4px;
	text-decoration: none;
	color: #fff;
	border: 1px solid #555;
}

.pagination a:hover {
	background-color: #e50914;
}

.pagination span {
	background-color: #e50914;
}

.no-data {
	text-align: center;
	padding: 40px 0;
	font-size: 18px;
	color: #999;
}

@media ( max-width : 768px) {
	.movie-grid {
		grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
		gap: 15px;
	}
}
</style>
</head>
<body>
	<div class="container">
		<h2>🎬 MovieNote</h2>

		<div class="top-bar">
			<a href="/MovieNote/movies/new" class="new-review-btn">+ 새로운 리뷰
				작성</a>
			<form class="sort-bar" method="get" action="/MovieNote/movies">
				<input type="hidden" name="page" value="<%=currentPage%>">
				<select name="sort" onchange="this.form.submit()">
					<option value="dateDesc"
						<%="dateDesc".equals(sort) ? "selected" : ""%>>📅 최신순</option>
					<option value="dateAsc"
						<%="dateAsc".equals(sort) ? "selected" : ""%>>📅 오래된순</option>
					<option value="scoreDesc"
						<%="scoreDesc".equals(sort) ? "selected" : ""%>>⭐ 평점
						높은순</option>
					<option value="scoreAsc"
						<%="scoreAsc".equals(sort) ? "selected" : ""%>>⭐ 평점 낮은순</option>
				</select>
			</form>
		</div>

		<div class="movie-grid">
			<%
			if (list != null && !list.isEmpty()) {
				for (MovieListDTO m : list) {
					int score = m.getScore();
					StringBuilder stars = new StringBuilder();
					for (int i = 0; i < 5; i++) {
				stars.append(i < score ? "★" : "☆");
					}
			%>
			<div class="movie-card">
				<a href="/MovieNote/movies/<%=m.getId()%>"
					style="text-decoration: none; color: inherit;">
					<div class="movie-info">
						<div class="movie-title"><%=m.getTitle()%></div>
						<div class="movie-date">
							시청일:
							<%=m.getWatchDate()%></div>
						<div class="movie-score">
							평점: <span class="stars"><%=stars.toString()%></span>
						</div>
					</div>
				</a>
				<form class="delete-form" method="post"
					action="/MovieNote/movies/api/<%=m.getId()%>/delete"
					onsubmit="return confirm('정말 삭제하시겠습니까?');">
					<button type="submit" class="delete-btn">삭제</button>
				</form>
			</div>
			<%
			}
			} else {
			%>
			<div class="no-data">등록된 영화가 없습니다.</div>
			<%
			}
			%>
		</div>

		<div class="pagination">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="/MovieNote/movies?page=<%=currentPage - 1%>&sort=<%=sort%>">◀
				이전</a>
			<%
			}
			%>
			<span><%=currentPage%></span>
			<%
			if (hasNextPage) {
			%>
			<a
				href="/MovieNote/movies?page=<%=currentPage + 1%>&sort=<%=sort%>">다음
				▶</a>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
