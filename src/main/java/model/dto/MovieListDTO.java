package model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MovieListDTO {
    private int id;
    private String title;
    private int score;
    private Date watchDate;
}
