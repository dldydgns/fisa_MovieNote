package service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import model.domain.Movie;
import util.DBUtil;

public class MovieService {

    // 영화 목록 조회 (정렬 + 페이징)
    public List<Movie> getMovies(String sort, int page, int size) {
        EntityManager em = DBUtil.getEntityManager();
        try {
            String jpql = "SELECT m FROM Movie m";
            if ("rating".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.score DESC";
            } else if ("date".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.watchDate DESC";
            } else if ("title".equalsIgnoreCase(sort)) {
                jpql += " ORDER BY m.title ASC";
            }

            TypedQuery<Movie> query = em.createQuery(jpql, Movie.class);
            query.setFirstResult((page - 1) * size);
            query.setMaxResults(size);
            return query.getResultList();

        } finally {
            em.close();
        }
    }

    // ID로 영화 조회
    public Movie findById(long id) {
        EntityManager em = DBUtil.getEntityManager();
        try {
            return em.find(Movie.class, (int) id);
        } finally {
            em.close();
        }
    }

    // 영화 저장 (신규)
    public void save(Movie movie) {
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(movie);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // 영화 수정
    public void update(Movie movie) {
        EntityManager em = DBUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.merge(movie);
            tx.commit();
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
