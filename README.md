# 📌 프로젝트 개요

JSP와 JPA를 활용한 영화 감상 리뷰 게시판 웹 애플리케이션  
사용자는 영화 정보 등록 및 감상 리뷰 작성가능  
CRUD 기능 중심,  MVC 패턴과 DB 연동 등을 학습하고 구현한 프로젝트

---

## 👥팀소개
<table align ="center">
  <tbody>
    <tr>
      <td align="center"><a href="https://github.com/GIHYUN-LEE"><img src="https://github.com/GIHYUN-LEE.png" width="100px;" alt=""/><br /><sub><b> @GIHYUN-LEE</b></sub></a><br /></td>
      <td align="center"><a href="https://github.com/0-zoo"><img src="https://github.com/0-zoo.png" width="100px;" alt=""/><br /><sub><b> @0-zoog</b></sub></a><br /></td>
      <td align="center"><a href="https://github.com/dldydgns"><img src="https://github.com/dldydgns.png" width="100px;" alt=""/><br /><sub><b> @dldydgns</b></sub></a><br /></td>
      <td align="center"><a href="https://github.com/Jsumin07"><img src="https://github.com/Jsumin07.png" width="100px;" alt=""/><br /><sub><b> @Jsumin07</b></sub></a><br /></td>

  </tbody>
</table>
---


## 💻 기술 스택

- **Frontend**: JSP, HTML
- **Backend**: Java Servlet, JSP, JPA  
- **Database**: MySQL 8.0.42  
- **Build Tool**: Maven  
- **WAS**: Apache Tomcat 10.1.43
- **IDE**: Eclipse
---

## 📂 프로젝트 구조
📁 src/ <br>
┣ 📂 main <br>
┃ ┗ 📂 webapp <br>
┃   ┣ 📂 META-INF <br>
┃   ┗ 📂 WEB-INF <br>
┃      ┣ 📂 lib <br>
┃     ┗ 📂 views <br>
┃       ┗ 📂 movies <br>
┃         ┣ 📄 Review_write.jsp <br>
┃         ┣ 📄 success.jsp <br>
┃         ┗ 📄 fail.jsp <br>
📁 src/main/java <br>
┣ 📂 controller <br>
┃ ┣ 📄 MOvieApiController.java <br>
┃ ┗ 📄 MOviePageController.java <br>
┣ 📂 model.domain <br>
┃ ┗ 📄 Movie.java <br>
┣ 📂 model.dto <br>
┃ ┣ 📄 MovieDetailDTO.java <br>
┃ ┣ 📄 MovieListDTO.java <br>
┃ ┣ 📄 MovieRequestDTO.java <br>
┃ ┗ 📄 MovieResponseDTO.java <br>
┣ 📂 service <br>
┃ ┗ 📄 MovieService.java <br>
┣ 📂 util <br>
┃ ┣ 📄 DBUtil.java <br>
┃ ┗ 📄 MovieConverter.java <br>
┣ 📂 META-INF <br>
┃ ┗ 📄 persistence.xml <br>
┃   ┣ 📂 META-INF <br>
┃   ┗ 📂 WEB-INF <br>
┃      ┣ 📂 lib <br>
┃     ┗ 📂 views <br>
┃       ┗ 📂 moviesd <br>
┃         ┣ 📄 Review_write.jsp <br>
┃         ┣ 📄 success.jsp <br>
┃         ┗ 📄 fail.jsp <br>
📄 pom.xml <br>

---
## 📄 API 명세서

<img width="1778" height="137" alt="api명세서" src="https://github.com/user-attachments/assets/c26c9ecc-8242-48d8-8daa-47363957f569" />
<a href="https://livewsuac-my.sharepoint.com/:x:/g/personal/201910739_live_wsu_ac_kr/EUZrQNvGWtdHocF-8z-TAfIBzwhvicKWGjEMR3UreA_BaA?e=HZsZtK">테이블 보기</a>

---

## 🧩 설계 과정

### 1.DB 테이블 설계

- 테이블 생성
```sql

CREATE TABLE movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    createDate DATE,
    watchDate DATE,
    score INT CHECK (score BETWEEN 0 AND 5),
    content TEXT,
    isfix BOOLEAN
);

```

- DB 구조 확인
<img width="757" height="250" alt="DB구조" src="https://github.com/user-attachments/assets/2f79101a-a4ee-4f8f-9100-2df9e82b6dc4" />

- ERD
<img width="140" height="237" alt="DB ERD" src="https://github.com/user-attachments/assets/50b0a8f4-ddae-4640-9e99-aa551697ef9d" />

---
### 2.DB 연동

- Dynamic Web project → Convert to Maven
- pom.xml 라이브러리 추가

``` xml
  
<!-- 표준 JPA API -->
<dependency>
	<groupId>javax.persistence</groupId>
	<artifactId>javax.persistence-api</artifactId>
	<version>2.2</version>
</dependency>

<!-- 실제 구현체 -->
<dependency>
	<groupId>org.hibernate</groupId>
	<artifactId>hibernate-entitymanager</artifactId>
	<version>5.4.2.Final</version>
</dependency>

<!-- Mysql -->
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>8.0.33</version>
</dependency>

```

- persistence.xml 설정

```xml

 <!-- 엔티티 클래스 자동 검색 or 명시 가능 -->
        <class>model.domain.Movie</class>

        <properties>
            <!-- JDBC 연결 설정 -->
            <property name="javax.persistence.jdbc.driver" value="com.mysql.cj.jdbc.Driver"/>
            <property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/fisa"/>
            <property name="javax.persistence.jdbc.user" value="root"/>
            <property name="javax.persistence.jdbc.password" value="root"/>
```
- 엔티티 클래스

```java
package model.domain;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "movie")
@Getter
@Setter
@NoArgsConstructor
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;

    @Column(name = "createDate")
    private Date createDate;

    @Column(name = "watchDate")
    private Date watchDate;

    @Column(columnDefinition = "INT CHECK (score BETWEEN 0 AND 5)")
    private int score;

    @Column(columnDefinition = "TEXT")
    private String content;

    private boolean isfix;
    
    @PrePersist
    protected void onCreate() {
        if (this.createDate == null) {
            this.createDate = new Date(System.currentTimeMillis());
        }
    }
}

```
- DriverManager로 DB 접근

  ---

### 3. 기능 구현(Back)
- 리뷰 조회
- 리뷰 목록 조회(정렬, 페이징)
- 신규 리뷰 저장
- 리뷰 수정
- 리뷰 삭제

 <br>

<details>
<summary>MovieApiController.java </summary>

``` java
package controller;

import java.io.IOException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.MovieRequestDTO;
import model.dto.MovieResponseDTO;
import service.MovieService;

@WebServlet("/movies/api/*")
public class MovieApiController extends HttpServlet {

    private MovieService movieService = new MovieService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        req.setAttribute("sort", req.getParameter("sort"));
        req.setAttribute("page", req.getParameter("page"));
        req.setAttribute("size", req.getParameter("size"));

        if ("/new".equals(pathInfo)) {
        	
        	try {
                MovieRequestDTO dto = parseRequest(req);
                MovieResponseDTO saved = movieService.save(dto);

                req.setAttribute("movie", saved);
                req.setAttribute("msg", "저장에 성공했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);
        	} catch(Exception e) {
                req.setAttribute("msg", "저장에 실패했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/fail.jsp").forward(req, resp);
        	}

        } else if (pathInfo != null && pathInfo.matches("/\\d+/edit")) {
        	
        	try {
                int id = extractIdFromPath(pathInfo);
                MovieRequestDTO dto = parseRequest(req);
                MovieResponseDTO updated = movieService.update(id, dto);

                req.setAttribute("movie", updated);
                req.setAttribute("msg", "수정에 성공했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);
        	} catch(Exception e) {
                req.setAttribute("msg", "저장에 실패했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/fail.jsp").forward(req, resp);
        	}

        } else if (pathInfo != null && pathInfo.matches("/\\d+/delete")) {
        	
        	try {
                int id = extractIdFromPath(pathInfo);
                movieService.delete(id);

                req.setAttribute("msg", "삭제에 성공했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);
        	} catch(Exception e) {
                req.setAttribute("msg", "저장에 실패했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/fail.jsp").forward(req, resp);
        	}

        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    
    private MovieRequestDTO parseRequest(HttpServletRequest req) throws IOException {
        req.setCharacterEncoding("UTF-8");

        return MovieRequestDTO.builder()
                .title(req.getParameter("title"))
                .score(Integer.parseInt(req.getParameter("score")))
                .content(req.getParameter("content"))
                .watchDate(Date.valueOf(req.getParameter("watchDate")))
                .build();
    }

    
    private int extractIdFromPath(String pathInfo) {
        String[] parts = pathInfo.split("/");
        for (String part : parts) {
            if (part.matches("\\d+")) {
                return Integer.parseInt(part);
            }
        }
        return -1;
    }
}


```
 </details>


 <details>
<summary>MoviePageController.java </summary>

``` java
package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.MovieDetailDTO;
import model.dto.MovieListDTO;
import service.MovieService;

@WebServlet("/movies/*")
public class MoviePageController extends HttpServlet {

    private MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
        String pathInfo = req.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {

        	String sort = req.getParameter("sort");
        	if (sort == "" || sort == null || "null".equals(sort)) {
        	    sort = "dateDesc";
        	}
        	int page = parseIntOrDefault(req.getParameter("page"), 1);
        	int size = parseIntOrDefault(req.getParameter("size"), 15);


            List<MovieListDTO> movies = movieService.getMovies(sort, page, size);
            
            req.setAttribute("movies", movies);
            req.setAttribute("sort", sort);
            req.setAttribute("page", page);
            req.setAttribute("size", size);
            req.getRequestDispatcher("/WEB-INF/views/movies/list.jsp").forward(req, resp);

        } else if ("/new".equals(pathInfo)) {
        	
        	req.getRequestDispatcher("/WEB-INF/views/movies/Review_write.jsp").forward(req, resp);

        } else if (pathInfo.matches("/\\d+/edit")) {

            long id = extractIdFromPath(pathInfo);
            MovieDetailDTO movie = movieService.findById(id);

            if (movie == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            String page = req.getParameter("page");
            String sort = req.getParameter("sort");
            String size = req.getParameter("size");
            
            
            req.setAttribute("review", movie);
            req.setAttribute("page", page);  // ✅ 추가
            req.setAttribute("sort", sort);  // ✅ 추가
            req.setAttribute("size", size);  // ✅ 추가
            req.getRequestDispatcher("/WEB-INF/views/movies/Review_edit.jsp").forward(req, resp); // ✅ 파일명도 명확히

            
        } else if (pathInfo.matches("/\\d+")) {
        	
            long id = extractIdFromPath(pathInfo);
            MovieDetailDTO movie = movieService.findById(id);

            if (movie == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            req.setAttribute("movie", movie);
            req.getRequestDispatcher("/WEB-INF/views/movies/detail.jsp").forward(req, resp);
            
        }else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private int parseIntOrDefault(String s, int def) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return def;
        }
    }

    private long extractIdFromPath(String pathInfo) {
        String[] parts = pathInfo.split("/");
        for (String part : parts) {
            if (part.matches("\\d+")) {
                return Long.parseLong(part);
            }
        }
        return -1;
    }
}


```
</details>


 <details>
  <summary>MovieService.java </summary>

``` java
package model.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "movie")
@Getter
@Setter
@NoArgsConstructor
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;

    @Column(name = "createDate")
    private Date createDate;

    @Column(name = "watchDate")
    private Date watchDate;

    @Column(columnDefinition = "INT CHECK (score BETWEEN 0 AND 5)")
    private int score;

    @Column(columnDefinition = "TEXT")
    private String content;

    private boolean isfix;
    
    @PrePersist
    protected void onCreate() {
        if (this.createDate == null) {
            this.createDate = new Date(System.currentTimeMillis());
        }
    }
}


```

</details>


 <details>
<summary>DTO 예시:MovieDetailDTO.java</summary>

``` java
package model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MovieDetailDTO {
    private int id;
    private String title;
    private String content;
    private int score;
    private Date watchDate;
}

```
</details>

---

### 4. 페이지 구현(front)

| JSP 파일명         | 설명                     | 주요 기능                                         | 
|--------------------|--------------------------|--------------------------------------------------|
| `list.jsp`         | 영화 감상 리스트 조회 페이지 | 영화 목록 출력, 정렬, 삭제, 페이징                  |  
| `Review.jsp`      | 리뷰 정보 확인 페이          | 영화 제목, 시청일, 평점, 내용 출력           | 
| `Review_write.jsp` | 리뷰 작성 폼              | 영화 제목, 시청일, 평점, 내용 입력 후 POST 전송           | 
| `Review_edit.jsp`         | 리뷰 수정 폼          | 기존 리뷰 정보 불러오기 및 수정 제출                     | 
| `success.jsp`       | 작업 성공 안내 페이지     | 성공 메시지 출력                    | 
| `fail.jsp`         | 작업 실패 안내 페이지      | 에러 메시지 출력 및 목록으로 돌아가기 링크                 | 
| `detail.jsp`        | 리뷰 상세보기 페이지      | 사용자가 등록한 리뷰 상세 조회                    | 


 <details>
<summary>list.jsp</summary>

``` java
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*, model.dto.MovieListDTO"%>
<%! 
    private String getOrDefault(String param, String defaultVal) {
        return (param != null && !"null".equals(param)) ? param : defaultVal;
    }
%>
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
		
			<a href="/MovieNote/movies/new?page=<%= getOrDefault(request.getParameter("page"), "1") %>&sort=<%= getOrDefault(request.getParameter("sort"), "dateDesc") %>&size=<%= getOrDefault(request.getParameter("size"), "15") %>" class="new-review-btn">
				+ 새로운 리뷰
			</a>
			<form class="sort-bar" method="get" action="/MovieNote/movies">
				<input type="hidden" name="page" value="<%=currentPage%>">
				<select name="sort" onchange="this.form.submit()">
					<option value="dateDesc"
						<%="dateDesc".equals(sort) ? "selected" : ""%>>📅 최신순</option>
					<option value="dateAsc"
						<%="dateAsc".equals(sort) ? "selected" : ""%>>📅 오래된순</option>
					<option value="scoreDesc"
						<%="scoreDesc".equals(sort) ? "selected" : ""%>>⭐ 평점 높은순</option>
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
				<a href="/MovieNote/movies/<%=m.getId()%>?
				sort=<%=request.getParameter("sort")%>&
				page=<%=request.getParameter("page")%>&
				size=<%=request.getParameter("size")%>"
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


```
</details>

 <details>
<summary>Review.jsp</summary>

``` java
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


```
</details>

 <details>
<summary>Review_write.jsp</summary>

``` java
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


```
</details>

 <details>
<summary>Review_edit.jsp</summary>

``` java
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

		<form action="<%= request.getContextPath() %>/movies/api/<%= review.getId() %>/edit" method="post">
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
				<button type="button" class="cancel-btn" 
				    onclick="location.href='<%= request.getContextPath() %>/movies/<%= review.getId() %>?sort=<%= request.getParameter("sort") != null ? request.getParameter("sort") : "" %>&page=<%= request.getParameter("page") != null ? request.getParameter("page") : "" %>&size=<%= request.getParameter("size") != null ? request.getParameter("size") : "" %>'">
				    취소
				</button>
            </div>
        </form>
    </div>
</body>
</html>



```
</details>

 <details>
<summary>success.jsp</summary>

``` java
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

```
</details>

 <details>
<summary>fail.jsp</summary>

``` java
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

        <a href="${pageContext.request.contextPath}/movies?sort=${sort}&page=${page}&size=${size}">목록으로 돌아가기</a>
    </div>
</body>
</html>



```
</details>

<details>
<summary>detail.jsp</summary>
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

</details>

---
## 🖼️ 화면 시안

### 영화 리뷰 작성화면
<img width="1920" height="1020" alt="영화 리뷰 작성화면" src="https://github.com/user-attachments/assets/9a1d7a26-d930-40cb-8c7b-c6393b6ffbc6" />
<br>

- 영화제목 작성
<img width="1920" height="1020" alt="영화 제목 작성" src="https://github.com/user-attachments/assets/7e425780-b74a-4289-9e93-6439d7f3a23b" />
<br>

- 평점 입력(별 1~5개)
<img width="1920" height="1019" alt="평점 선택" src="https://github.com/user-attachments/assets/ea0e15d2-6d56-471e-ae30-3492c66a2554" />
<br>

- 시청일 및 리뷰 작성
<img width="1920" height="1020" alt="영화 리뷰 작성" src="https://github.com/user-attachments/assets/40aed043-f0ca-45f5-8b49-27646bc30f86" />
<br>

- 작성 완료 클릭 시
<img width="1920" height="1020" alt="저장성공 팝업" src="https://github.com/user-attachments/assets/2f918377-8afd-4751-ad2d-67829c1de10a" />



---
## 🛠️ 고찰
- 향후 각 사용자 IP에 따른 로그인 기능 구현
- 각 기능별 테스트 시나리오 구성해서 테스트 필요
