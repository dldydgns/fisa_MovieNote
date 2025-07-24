package model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class MovieRequestDTO {
    private String title;
    private String content;
    private int score;
    private Date watchDate;
}