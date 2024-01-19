package com.finalprj.seoulfoodtrip.repository.crew;

import com.finalprj.seoulfoodtrip.domain.crew.Crew;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CrewRepository extends JpaRepository<Crew, Long> {

    /* 크루명으로 크루 존재 유무 반환 */
    boolean existsByCrewName(String crewName);

    /* 크루번호로 크루 조회 */
    Crew findByCrewNo(Long crewNo);

    /* 멤버 ID로 크루 조회 */
    Crew findByMemberId(String id);

    /* 크루번호, 아이디로 해당 ID가 크루장인지 조회*/
    boolean existsByCrewNoAndMemberId(Long crewNo, String id);

    /* 신생 크루 조회 */
    List<Crew> findTop3ByOrderByCrewNoDesc();

}
