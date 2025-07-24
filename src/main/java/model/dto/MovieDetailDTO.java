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
