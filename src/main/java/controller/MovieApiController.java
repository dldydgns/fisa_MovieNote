package controller;

import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;

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
    private ObjectMapper objectMapper = new ObjectMapper(); // JSON 파서

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        if ("/new".equals(pathInfo)) {
            // POST /movies/api/new
            Movie movie = objectMapper.readValue(req.getReader(), Movie.class);
            movieService.save(movie);
            resp.sendRedirect(req.getContextPath() + "/movies");

        } else if (pathInfo != null && pathInfo.matches("/\\d+/edit")) {
            // POST /movies/api/{id}/edit
            int id = extractIdFromPath(pathInfo);
            Movie movie = objectMapper.readValue(req.getReader(), Movie.class);
            movie.setId(id);
            movieService.update(movie);
            resp.sendRedirect(req.getContextPath() + "/movies");

        } else if (pathInfo != null && pathInfo.matches("/\\d+/delete")) {
            // POST /movies/api/{id}/delete
            int id = extractIdFromPath(pathInfo);
            movieService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/movies");

        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
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
