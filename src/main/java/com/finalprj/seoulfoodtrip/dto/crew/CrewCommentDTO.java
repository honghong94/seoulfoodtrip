package com.finalprj.seoulfoodtrip.dto.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.domain.crew.CrewPost;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class CrewCommentDTO {
    private Long commentNo;
    private CrewPost crewPost;
    private Member member;
    private String content;
    private LocalDateTime wDate;
}
