package com.finalprj.seoulfoodtrip.repository;

import com.finalprj.seoulfoodtrip.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, String> {
    Optional<Member> findByNickname(String nickname);
    Optional<Member> findById(String id);
    @Transactional
    void deleteById(String id);
    Member findOneById(String id);
}
