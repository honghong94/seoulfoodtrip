package com.finalprj.seoulfoodtrip.service.review;

import com.finalprj.seoulfoodtrip.dto.review.ReviewCommentDTO;

import java.util.List;

public interface ReviewCommentService {
    List<ReviewCommentDTO> getCommentList(Long reviewNo);

    void insertComment(ReviewCommentDTO dto);

    void updateComment(ReviewCommentDTO dto);

    void deleteComment(Long commentNo);
}
