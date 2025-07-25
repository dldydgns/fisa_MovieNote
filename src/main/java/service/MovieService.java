package service;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import model.domain.Movie;
import model.dto.MovieDetailDTO;
import model.dto.MovieListDTO;
import model.dto.MovieRequestDTO;
import model.dto.MovieResponseDTO;
import util.DBUtil;

public class MovieService {

    // 영화 목록 조회 (정렬 + 페이징)
    public List<MovieListDTO> getMovies(String sort, int page, int size) {
        EntityManager em = DBUtil.getEntityManager();
        
        try {
        	
            String jpql = "SELECT m FROM Movie m";
            
            if ("score".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.score DESC";
            } else if ("date".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.watchDate DESC";
            } else if ("title".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.title ASC";
            }

            TypedQuery<Movie> query = em.createQuery(jpql, Movie.class);
            query.setFirstResult((page - 1) * size);
            query.setMaxResults(size);
            
            List<Movie> movies = query.getResultList();

            return movies.stream().map(m -> new MovieListDTO(m.getId(), m.getTitle(), m.getScore(), m.getWatchDate()))
                .collect(Collectors.toList());

        } finally {
            em.close();
        }
    }

    
    // ID로 영화 조회
    public MovieDetailDTO findById(long id) {
        EntityManager em = DBUtil.getEntityManager();
        
        try {
        	
            Movie movie = em.find(Movie.class, (int) id);
            
            if (movie == null) 
            	return null;
            
            return new MovieDetailDTO(movie.getId(), movie.getTitle(), movie.getContent(), movie.getScore(), movie.getWatchDate());
            
        } finally {
            em.close();
        }
    }

    
    // 영화 저장 (신규) - 저장 후 MovieResponseDTO 반환
    public MovieResponseDTO save(MovieRequestDTO dto) {
    	
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
        	
            tx.begin();
            
            Movie movie = new Movie();
            movie.setTitle(dto.getTitle());
            movie.setContent(dto.getContent());
            movie.setScore(dto.getScore());
            movie.setWatchDate(dto.getWatchDate());
            movie.setCreateDate(new java.sql.Date(System.currentTimeMillis()));
            movie.setIsfix(false);
            
            em.persist(movie);
            
            tx.commit();

            return new MovieResponseDTO(movie.getId(), movie.getTitle(), movie.getContent(), movie.getScore(), movie.getWatchDate());
        
        } catch (Exception e) {
            if (tx.isActive())
            	tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    

    // 영화 수정 - 수정 후 MovieResponseDTO 반환
    public MovieResponseDTO update(int id, MovieRequestDTO dto) {
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
        	
            tx.begin();
            
            Movie movie = em.find(Movie.class, id);
            
            if (movie != null) {
                movie.setTitle(dto.getTitle());
                movie.setContent(dto.getContent());
                movie.setScore(dto.getScore());
                movie.setWatchDate(dto.getWatchDate());
                
                em.merge(movie);
            }
            
            tx.commit();

            if (movie == null) return null;
            
            return new MovieResponseDTO(movie.getId(), movie.getTitle(), movie.getContent(), movie.getScore(), movie.getWatchDate());

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    
    // 영화 삭제
    public void delete(int id) {
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
        	
            tx.begin();
            
            Movie movie = em.find(Movie.class, id);
            
            if (movie != null) {
                em.remove(movie);
            }
            
            tx.commit();
            
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
}
