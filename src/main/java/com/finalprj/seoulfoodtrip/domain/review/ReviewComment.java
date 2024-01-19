package com.finalprj.seoulfoodtrip.domain.review;

import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "REVIEW_BOARD_COMMENT_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SequenceGenerator(
        name="REVIEW_BOARD_COMMENT_SEQ_GEN",
        sequenceName="REVIEW_BOARD_COMMENT_SEQ",
        allocationSize=1)
@Setter
@ToString
public class ReviewComment {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "REVIEW_BOARD_COMMENT_SEQ_GEN")
    @Column(name = "COMMENT_NO")
    private Long commentNo;

    @ManyToOne
    @JoinColumn(name = "REVIEW_NO")
    private Review review;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Member member;

    private String content;

    @Column(name = "w_date")
    private LocalDateTime wDate;
}
