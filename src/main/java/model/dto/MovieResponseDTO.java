package model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import model.domain.Movie;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MovieResponseDTO {
    private int id;
    private String title;
    private String content;
    private int score;
    private Date watchDate;

    // Entity -> DTO 변환 생성자
    public MovieResponseDTO(Movie movie) {
        this.id = movie.getId();
        this.title = movie.getTitle();
        this.content = movie.getContent();
        this.score = movie.getScore();
        this.watchDate = movie.getWatchDate();
    }
}

