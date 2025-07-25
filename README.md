# 📌 프로젝트 개요

JSP와 JPA를 활용한 영화 감상 리뷰 게시판 웹 애플리케이션  
사용자는 영화 정보 등록 및 감상 리뷰 작성가능  
CRUD 기능 중심,  MVC 패턴과 DB 연동 등을 학습하고 구현한 프로젝트

---

## 👥팀소개
<div align="center">
  
|이용훈|이영주|전수민|이기현|
|:---:|:---:|:---:|:---:|
|[dldydgns](https://github.com/dldydgns)|[0-zoo](https://github.com/0-zoo)|[Jsumin07](https://github.com/Jsumin07)|[GIHYUN-LEE](https://github.com/GIHYUN-LEE)|
|<img width="460" height="460" alt="image" src="https://github.com/user-attachments/assets/1073d700-137b-4007-8e34-422d2f29ec28" />|<img width="480" height="480" alt="image" src="https://github.com/user-attachments/assets/55201bed-aa5f-494c-a313-2d9ea2f80279" />|<img width="460" height="460" alt="image" src="https://github.com/user-attachments/assets/0a7ffa11-22a0-4316-8be0-c872f94e76c3" />|<img width="460" height="460" alt="image" src="https://github.com/user-attachments/assets/4e3eba16-866b-46d5-9a17-a20f8dc3ad8b" />
  
</div>

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
<img width="720" height="238" alt="image" src="https://github.com/user-attachments/assets/e8f11102-87ae-4cba-8904-eecbda708e60" />

- ERD
<img width="160" height="160" alt="image" src="https://github.com/user-attachments/assets/04050c4e-04f1-4a40-a987-e6ce8ed84f15" />

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

        if ("/new".equals(pathInfo)) {
        	
        	try {
                MovieRequestDTO dto = parseRequest(req);
                MovieResponseDTO saved = movieService.save(dto);

                req.setAttribute("movie", saved);
                req.setAttribute("msg", "저장에 성공했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);
        	} catch(Exception e) {
                req.setAttribute("msg", "저장에 성공했습니다.");
                req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);
        	}

        } else if (pathInfo != null && pathInfo.matches("/\\d+/edit")) {
        	
            int id = extractIdFromPath(pathInfo);
            MovieRequestDTO dto = parseRequest(req);
            MovieResponseDTO updated = movieService.update(id, dto);

            req.setAttribute("movie", updated);
            req.setAttribute("msg", "수정에 성공했습니다.");
            req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);

        } else if (pathInfo != null && pathInfo.matches("/\\d+/delete")) {
            int id = extractIdFromPath(pathInfo);
            movieService.delete(id);

            req.setAttribute("msg", "삭제에 성공했습니다.");
            req.getRequestDispatcher("/WEB-INF/views/movies/success.jsp").forward(req, resp);

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
            int page = parseIntOrDefault(req.getParameter("page"), 1);
            int size = parseIntOrDefault(req.getParameter("size"), 15);

            List<MovieListDTO> movies = movieService.getMovies(sort, page, size);
            
            req.setAttribute("movies", movies);
            req.setAttribute("sort", sort);
            req.getRequestDispatcher("/WEB-INF/views/movies/list.jsp").forward(req, resp);
            

        } else if ("/new".equals(pathInfo)) {
        	
        	req.getRequestDispatcher("/WEB-INF/views/movies/Review_write.jsp").forward(req, resp);
//        	resp.sendRedirect("/WEB-INF/views/movies/Review_write.jsp");
//            req.getRequestDispatcher("/WEB-INF/views/movies/new.jsp").forward(req, resp);

        } else if (pathInfo.matches("/\\d+/edit")) {
        	
            long id = extractIdFromPath(pathInfo);
            MovieDetailDTO movie = movieService.findById(id);
            
            if (movie == null) {
            	// id값에 해당하는 정보가 없는것이므로 에러페이지로 이동 필요	??
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            req.setAttribute("movie", movie);
            req.getRequestDispatcher("/WEB-INF/views/movies/edit.jsp").forward(req, resp);

        } else {
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
package service;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import model.domain.Movie;
import model.dto.MovieDetailDTO;
import model.dto.MovieListDTO;
import model.dto.MovieRequestDTO;
import model.dto.MovieResponseDTO;
import util.DBUtil;

public class MovieService {

    // 영화 목록 조회 (정렬 + 페이징)
    public List<MovieListDTO> getMovies(String sort, int page, int size) {
        EntityManager em = DBUtil.getEntityManager();
        
        try {
        	
            String jpql = "SELECT m FROM Movie m";
            
            if ("score".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.score DESC";
            } else if ("date".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.watchDate DESC";
            } else if ("title".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.title ASC";
            } else if ("scoreAsc".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.score ASC";
            } else if ("scoreDesc".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.score DESC";
            } else if ("dateAsc".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.watchDate ASC";
            } else if ("dateDesc".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.watchDate DESC";
            } else {
                jpql += " ORDER BY m.id ASC"; // 기본 정렬
            }
            
            

            TypedQuery<Movie> query = em.createQuery(jpql, Movie.class);
            query.setFirstResult((page - 1) * size);
            query.setMaxResults(size);
            
            List<Movie> movies = query.getResultList();

            return movies.stream().map(m -> new MovieListDTO(m.getId(), m.getTitle(), m.getScore(), m.getWatchDate()))
                .collect(Collectors.toList());

        } finally {
            em.close();
        }
    }

    
    // ID로 영화 조회
    public MovieDetailDTO findById(long id) {
        EntityManager em = DBUtil.getEntityManager();
        
        try {
        	
            Movie movie = em.find(Movie.class, (int) id);
            
            if (movie == null) 
            	return null;
            
            return new MovieDetailDTO(movie.getId(), movie.getTitle(), movie.getContent(), movie.getScore(), movie.getWatchDate());
            
        } finally {
            em.close();
        }
    }

    
    // 영화 저장 (신규) - 저장 후 MovieResponseDTO 반환
    public MovieResponseDTO save(MovieRequestDTO dto) {
    	
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
        	
            tx.begin();
            
            Movie movie = new Movie();
            movie.setTitle(dto.getTitle());
            movie.setContent(dto.getContent());
            movie.setScore(dto.getScore());
            movie.setWatchDate(dto.getWatchDate());
            movie.setCreateDate(new java.sql.Date(System.currentTimeMillis()));
            movie.setIsfix(false);
            
            em.persist(movie);
            
            tx.commit();

            return new MovieResponseDTO(movie.getId(), movie.getTitle(), movie.getContent(), movie.getScore(), movie.getWatchDate());
        
        } catch (Exception e) {
            if (tx.isActive())
            	tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    

    // 영화 수정 - 수정 후 MovieResponseDTO 반환
    public MovieResponseDTO update(int id, MovieRequestDTO dto) {
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
        	
            tx.begin();
            
            Movie movie = em.find(Movie.class, id);
            
            if (movie != null) {
                movie.setTitle(dto.getTitle());
                movie.setContent(dto.getContent());
                movie.setScore(dto.getScore());
                movie.setWatchDate(dto.getWatchDate());
                
                em.merge(movie);
            }
            
            tx.commit();

            if (movie == null) return null;
            
            return new MovieResponseDTO(movie.getId(), movie.getTitle(), movie.getContent(), movie.getScore(), movie.getWatchDate());

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    
    // 영화 삭제
    public void delete(int id) {
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
        	
            tx.begin();
            
            Movie movie = em.find(Movie.class, id);
            
            if (movie != null) {
                em.remove(movie);
            }
            
            tx.commit();
            
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
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
| `list.jsp`         | 영화 감상 리스트 조회 페이지 | 영화 목록 출력, 정렬, 삭제, 페이지네이션                  |       
| `Review_write.jsp` | 리뷰 작성 폼              | 영화 제목, 시청일, 평점, 내용 입력 후 POST 제출           | 
| `edit.jsp`         | 리뷰 수정 폼              | 기존 리뷰 정보 불러오기 및 수정 제출                     | 
| `result.jsp`       | 작성 후 결과 출력         | 영화 ID, 제목, 감상일, 평점, 내용 표시                    | 
| `fail.jsp`         | 작업 실패 안내 페이지      | 에러 메시지 출력 및 목록으로 돌아가기 링크                 | 
| `check.jsp`        | 리뷰 작성 확인 페이지      | 제출 전 리뷰 내용 확인, 수정 버튼 제공                    | 

 <details>
<summary>list.jsp</summary>

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

        <a href="${pageContext.request.contextPath}/movies">목록으로 돌아가기</a>
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
        <button type="button" class="cancel" onclick="location.href='/MovieNote/movies'">취소</button>
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

<%
	MovieDetailDTO review = (MovieDetailDTO) request.getAttribute("review");
    if (review == null) {
%>
    <p>리뷰 정보를 불러올 수 없습니다.</p>
<%
        return;
    }


%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 수정</title>
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

    <!-- 반드시 POST로 요청 보내야 ReviewController에서 처리됨 -->
    <form action="<%= request.getContextPath() %>/reviews/edit" method="post">
        <input type="hidden" name="id" value="<%= review.getId() %>">

        <label for="title">영화 제목</label>
        <input type="text" name="title" id="title" value="<%= review.getTitle() %>" required>

<!--
        <label for="createDate">작성일</label>
        <input type="date" name="createDate" id="createDate" value="<%= formattedCreateDate %>" required>

        <label for="watchDate">시청일</label>
        <input type="date" name="watchDate" id="watchDate" value="<%= formattedWatchDate %>">
  -->
        <label for="score">평점</label>
        <select name="score" id="score" required>
            <option value="">선택하세요</option>
<%
    for (int i = 1; i <= 5; i++) {
        String stars = "⭐".repeat(i);
        String selected = (review.getScore() == i) ? "selected" : "";
%>
        <option value="<%= i %>" <%= selected %>><%= stars %></option>
<%
    }
%>
        </select>

        <label for="content">리뷰 내용</label>
        <textarea name="content" id="content" rows="6" required><%= review.getContent() %></textarea>

        <label for="isfix">수정 여부</label>
        <select name="isfix" id="isfix" required>
            <option value="">선택하세요</option>
            <!-- 
            <option value="true" <%= review.isIsfix() ? "selected" : "" %>>예</option>
            <option value="false" <%= !review.isIsfix() ? "selected" : "" %>>아니오</option>
              -->
        </select>

        <button type="submit">수정 완료</button>
        <button type="button" class="cancel" onclick="location.href='<%= request.getContextPath() %>/reviews'">취소</button>
    </form>
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

        <a href="${pageContext.request.contextPath}/movies">목록으로 돌아가기</a>
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

        <a href="${pageContext.request.contextPath}/movies">목록으로 돌아가기</a>
    </div>
</body>
</html>


```
</details>

---
## 🖼️ 화면 시안

### 영화 리뷰 작성화면
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/1fa1e9fa-5212-4944-a77c-8d1116f4ca44" />
<br>
- 영화제목 작성
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/b7109a61-590c-45f7-9508-eb669fa5097f" />
<br>
- 평점 입력(별 1~5개)
<img width="1920" height="1019" alt="image" src="https://github.com/user-attachments/assets/deabd689-e234-4fb4-a6ef-0a8f75ec8c59" />
<br>
- 시청일 및 리뷰 작성
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/87febcc7-19d5-4887-b203-c2112669817e" />
<br>
- 작성 완료 클릭 시
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/ae86394b-fa99-4fb8-965c-c93b24a9f556" />

---
## ⚠️ 트러블 슈팅
- ???

---
## 🛠️ 고찰
- 추후 각 사용자 IP에 따른 로그인 기능 구현
- 각 기능별 테스트 시나리오 구성해서 테스트 필요
