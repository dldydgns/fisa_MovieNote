package model.domain;

import java.sql.Date;

// 영화제목, 날짜, 시청일, 수정여부, 평점, 내용
public class Movie {
	private int id;
	private String title;
	private Date createDate;
	private Date watchDate;
	private int score;
	private String content;
	private boolean isfix;
}
