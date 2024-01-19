package com.finalprj.seoulfoodtrip.domain.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CREW_BOARD_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SequenceGenerator(
        name="CREW_BOARD_SEQ_GEN",
        sequenceName="CREW_BOARD_SEQ",
        allocationSize=1)
@Setter
@DynamicInsert
public class CrewPost {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CREW_BOARD_SEQ_GEN")
    @Column(name = "CREW_POST_NO")
    private Long postNo;

    @JoinColumn(name = "CREW_NO")
    @ManyToOne
    private Crew crew;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Member member;

    private String category;
    private String title;
    private String content;

    @Column(name = "MEMBERLIST")
    private String memberList;

    @Column(name = "UPLOAD_IMG")
    private String uploadImg;

    @Column(name = "W_DATE")
    private LocalDateTime wDate;

    private Integer hit;
}
