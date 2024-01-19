package com.finalprj.seoulfoodtrip.repository.crew;

import com.finalprj.seoulfoodtrip.domain.crew.CrewComment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface CrewCommentRepository extends JpaRepository<CrewComment, Long> {

    List<CrewComment> findAllByCrewPost_PostNo(Long postNo);

    CrewComment findByCommentNo(Long commentNo);

    // 사용자 id로 댓글 검색
    Page<CrewComment> findAllByMemberId(String id, Pageable pageable);

    // 사용자 id로 조회되는 댓글 삭제
    @Transactional
    void deleteAllByMemberId(String id);

    // 특정 게시글의 모든 댓글 삭제
    @Transactional
    void deleteAllByCrewPostPostNo(Long postNo);
}
