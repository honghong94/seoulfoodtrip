package com.finalprj.seoulfoodtrip.repository;

import com.finalprj.seoulfoodtrip.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LoginRepository extends JpaRepository<Member, String> {
    Optional<Member> findByIdAndPassword(String id, String password);
}
