package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.domain.Movie;
import service.MovieService;

@WebServlet("/movies/api/*")
public class MovieApiController extends HttpServlet {

    private MovieService movieService = new MovieService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        if ("/new".equals(pathInfo)) {
            Movie movie = parseMovieFromRequest(req);
            movieService.save(movie);

            req.setAttribute("movie", movie);
            req.getRequestDispatcher("/WEB-INF/views/movies/result.jsp").forward(req, resp);

        } else if (pathInfo != null && pathInfo.matches("/\\d+/edit")) {
            int id = extractIdFromPath(pathInfo);
            Movie movie = parseMovieFromRequest(req);
            movie.setId(id);
            movieService.update(movie);

            req.setAttribute("movie", movie);
            req.getRequestDispatcher("/WEB-INF/views/movies/result.jsp").forward(req, resp);

        } else if (pathInfo != null && pathInfo.matches("/\\d+/delete")) {
            int id = extractIdFromPath(pathInfo);
            movieService.delete(id);

            req.getRequestDispatcher("/WEB-INF/views/movies/deleteResult.jsp").forward(req, resp);

        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private Movie parseMovieFromRequest(HttpServletRequest req) throws UnsupportedEncodingException {
        req.setCharacterEncoding("UTF-8");
        String title = req.getParameter("title");
        String watchDate = req.getParameter("watchDate");
        String scoreStr = req.getParameter("score");
        String content = req.getParameter("content");

        Movie movie = new Movie();
        movie.setTitle(title);
        if (watchDate != null && !watchDate.isEmpty()) {
            movie.setWatchDate(Date.valueOf(watchDate));
        }
        if (scoreStr != null && !scoreStr.isEmpty()) {
            movie.setScore(Integer.parseInt(scoreStr));
        }
        movie.setContent(content);

        return movie;
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
