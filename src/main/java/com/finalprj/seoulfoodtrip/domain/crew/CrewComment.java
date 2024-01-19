package com.finalprj.seoulfoodtrip.domain.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CREW_BOARD_COMMENT_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SequenceGenerator(
        name="CREW_BOARD_COMMENT_SEQ_GEN",
        sequenceName="CREW_BOARD_COMMENT_SEQ",
        allocationSize=1)
@Setter
@ToString
public class CrewComment {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CREW_BOARD_COMMENT_SEQ_GEN")
    @Column(name = "COMMENT_NO")
    private Long commentNo;

    @ManyToOne
    @JoinColumn(name = "CREW_POST_NO")
    private CrewPost crewPost;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Member member;

    private String content;

    @Column(name = "w_date")
    private LocalDateTime wDate;
}
