package com.finalprj.seoulfoodtrip.dto.review;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.domain.review.Review;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class ReviewCommentDTO {
    private Long commentNo;
    private Review review;
    private Member member;
    private String content;
    private LocalDateTime wDate;
}
