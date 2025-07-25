package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.dto.MovieRequestDTO;
import model.dto.MovieResponseDTO;
import service.MovieService;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/reviews/edit")
public class ReviewEditController extends HttpServlet {

    private MovieService movieService = new MovieService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            int score = Integer.parseInt(req.getParameter("score"));
            String watchDateStr = req.getParameter("watchDate");

            String page = req.getParameter("page");
            String sort = req.getParameter("sort");

            Date watchDate = (watchDateStr != null && !watchDateStr.isEmpty()) ? Date.valueOf(watchDateStr) : null;

            MovieRequestDTO dto = new MovieRequestDTO(title, content, score, watchDate);

            MovieResponseDTO updated = movieService.update(id, dto);

            if (updated != null) {
                String redirectURL = req.getContextPath() + "/movies";
                if (page != null || sort != null) {
                    redirectURL += "?";
                    if (page != null) redirectURL += "page=" + page;
                    if (sort != null) redirectURL += (page != null ? "&" : "") + "sort=" + sort;
                } else {
                    redirectURL += "?page=1";
                }
                resp.sendRedirect(redirectURL);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 영화 정보를 찾을 수 없습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "수정 중 오류 발생");
        }
    }
}



