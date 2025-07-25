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
