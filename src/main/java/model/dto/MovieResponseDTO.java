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
}

