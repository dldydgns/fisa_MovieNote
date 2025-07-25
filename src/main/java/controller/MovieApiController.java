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
        	
            MovieRequestDTO dto = parseRequest(req);
            MovieResponseDTO saved = movieService.save(dto);

            req.setAttribute("movie", saved);
            req.setAttribute("msg", "저장에 성공했습니다.");
            req.getRequestDispatcher("/MovieNote/views/movies/result.jsp").forward(req, resp);

        } else if (pathInfo != null && pathInfo.matches("/\\d+/edit")) {
        	
            int id = extractIdFromPath(pathInfo);
            MovieRequestDTO dto = parseRequest(req);
            MovieResponseDTO updated = movieService.update(id, dto);

            req.setAttribute("movie", updated);
            req.setAttribute("msg", "수정에 성공했습니다.");
            req.getRequestDispatcher("/MovieNote/views/movies/result.jsp").forward(req, resp);

        } else if (pathInfo != null && pathInfo.matches("/\\d+/delete")) {
            int id = extractIdFromPath(pathInfo);
            movieService.delete(id);

            req.setAttribute("msg", "삭제에 성공했습니다.");
            req.getRequestDispatcher("/MovieNote/views/movies/result.jsp").forward(req, resp);

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
