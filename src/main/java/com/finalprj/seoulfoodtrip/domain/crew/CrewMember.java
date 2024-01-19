package com.finalprj.seoulfoodtrip.domain.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Entity
@Table(name = "CREW_MEMBER_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SequenceGenerator(
        name = "CREW_MEMBER_SEQ_GEN",
        sequenceName = "CREW_MEMBER_SEQ",
        allocationSize = 1)
@Setter
@DynamicInsert
public class CrewMember {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CREW_MEMBER_SEQ_GEN")
    @Column(name = "CREW_REG_NO")
    private Long regNo;

    @ManyToOne
    @JoinColumn(name = "CREW_NO")
    private Crew crew;

    @OneToOne
    @JoinColumn(name = "ID")
    private Member member;

    private Boolean state;
    private String answer1;
    private String answer2;
    private String answer3;

}
