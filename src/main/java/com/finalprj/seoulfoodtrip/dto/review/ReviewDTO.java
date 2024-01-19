package com.finalprj.seoulfoodtrip.dto.review;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.finalprj.seoulfoodtrip.domain.Member;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReviewDTO {
    private Long reviewNo;
    private Member member;
    private String title;
    private String content;
    private String courseImgName;
    private String uploadImgNames;
    private LocalDateTime wDate;
    private int hit;
    private int areaNo;

    //DTO Only
    private MultipartFile courseImgFile;
    private String[] uploadImgs;

}
