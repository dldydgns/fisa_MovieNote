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
            req.getRequestDispatcher("/MovieNote/views/movies/list.jsp").forward(req, resp);
            

        } else if ("/new".equals(pathInfo)) {
        	
        	resp.sendRedirect("/MovieNote/views/movies/new.jsp");
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
            req.getRequestDispatcher("/MovieNote/views/movies/edit.jsp").forward(req, resp);

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
