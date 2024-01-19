package com.finalprj.seoulfoodtrip.controller.review;

import com.finalprj.seoulfoodtrip.dto.review.ReviewCommentDTO;
import com.finalprj.seoulfoodtrip.service.impl.review.ReviewCommentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
public class ReviewCommentController {
    @Autowired
    ReviewCommentServiceImpl service;

    @GetMapping(value = "/review/{reviewNo}/comment")
    public ResponseEntity<List<ReviewCommentDTO>> getReviewComment(@PathVariable("reviewNo") Long reviewNo) {
        return ResponseEntity.ok(service.getCommentList(reviewNo));
    }

    @PostMapping("/review/{reviewNo}/comment")
    public void insertReviewComment(@PathVariable("reviewNo") Long reviewNo,
                                    ReviewCommentDTO dto) {
        service.insertComment(dto);
    }

    @DeleteMapping("/review/{reviewNo}/comment/{commentNo}")
    public void deleteReviewComment(@PathVariable("reviewNo") Long reviewNo,
                                    @PathVariable("commentNo") Long commentNo) {
        service.deleteComment(commentNo);
        System.out.println(commentNo + "번 댓글 삭제 완료");
    }

    @PutMapping("/review/{reviewNo}/comment/{commentNo}")
    public void putReviewComment(@PathVariable("reviewNo") Long reviewNo,
                                 @PathVariable("commentNo") Long commentNo,
                                 ReviewCommentDTO dto) {
        service.updateComment(dto);
        System.out.println(commentNo + "번 댓글 수정 완료");
    }
}
