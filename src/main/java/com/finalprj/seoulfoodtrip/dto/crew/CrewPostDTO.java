package com.finalprj.seoulfoodtrip.dto.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.domain.crew.Crew;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class CrewPostDTO {
    private Long postNo;
    private Crew crew;
    private Member member;
    private String category;
    private String title;
    private String content;
    private String memberList;
    private String uploadImg;
    private LocalDateTime wDate;
    private Integer hit;
}
