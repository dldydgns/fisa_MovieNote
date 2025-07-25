package model.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "movie")
@Getter
@Setter
@NoArgsConstructor
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;

    @Column(name = "createDate")
    private Date createDate;

    @Column(name = "watchDate")
    private Date watchDate;

    @Column(columnDefinition = "INT CHECK (score BETWEEN 0 AND 5)")
    private int score;

    @Column(columnDefinition = "TEXT")
    private String content;

    private boolean isfix;
    
    @PrePersist
    protected void onCreate() {
        if (this.createDate == null) {
            this.createDate = new Date(System.currentTimeMillis());
        }
    }
}
