package com.finalprj.seoulfoodtrip.dto.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class CrewDTO {
    private Long crewNo;
    private Member member;
    private String crewName;
    private String areaList;
    private String intro;
    private String introDetail;
    private String recruit;
    private String question1;
    private String question2;
    private String question3;
    private String crewImgFileName;
    private LocalDateTime cDate;

    //관심 지역 String[] 전송받을 파라미터
    private String[] areaListValues;
}
