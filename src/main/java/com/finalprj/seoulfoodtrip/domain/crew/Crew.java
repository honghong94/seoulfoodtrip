package com.finalprj.seoulfoodtrip.domain.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CREW_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SequenceGenerator(
        name = "CREW_SEQ_GEN",
        sequenceName = "CREW_SEQ",
        allocationSize = 1)
@Setter
@DynamicInsert
@ToString
public class Crew {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CREW_SEQ_GEN")
    @Column(name = "CREW_NO")
    private Long crewNo;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Member member;

    @Column(name = "CREW_NAME")
    private String crewName;

    @Column(name = "AREALIST")
    private String areaList;

    private String intro;

    @Column(name = "INTRO_DETAIL")
    private String introDetail;
    private String recruit;

    @Column(name = "QUESTION1")
    private String question1;
    private String question2;
    private String question3;

    @Column(name = "CREW_IMG")
    private String crewImgFileName;


    @Column(name = "C_DATE")
    private LocalDateTime cDate;
}
