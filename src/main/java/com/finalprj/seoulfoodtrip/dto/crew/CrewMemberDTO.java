package com.finalprj.seoulfoodtrip.dto.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.domain.crew.Crew;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class CrewMemberDTO {
        private Long regNo;
        private Crew crew;
        private Member member;
        private Boolean state;
        private String answer1;
        private String answer2;
        private String answer3;
}
