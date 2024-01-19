package com.finalprj.seoulfoodtrip.controller.crew;

import com.finalprj.seoulfoodtrip.dto.crew.CrewCommentDTO;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewCommentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class CrewCommentController {
    @Autowired
    CrewCommentServiceImpl service;

    /* 크루 활동 게시판 댓글 조회 */
    @GetMapping(value = "/crew/board/{postNo}/comment")
    public ResponseEntity<List<CrewCommentDTO>> getCrewComment(@PathVariable("postNo") Long postNo) {
        return ResponseEntity.ok(service.getComments(postNo));
    }

    /* 크루 활동 게시판 댓글 등록 */
    @PostMapping("/crew/board/{postNo}/comment")
    public void insertCrewComment(@PathVariable("postNo") Long postNo, CrewCommentDTO dto) {
        service.insertComment(dto);
    }

    /* 크루 활동 게시판 댓글 삭제 */
    @DeleteMapping("/crew/board/{postNo}/comment/{commentNo}")
    public void deleteCrewComment(@PathVariable("postNo") Long postNo,
                                    @PathVariable("commentNo") Long commentNo) {
        service.deleteComment(commentNo);
        System.out.println(commentNo + "댓글 삭제 완료");
    }

    /* 크루 활동 게시판 댓글 수정 */
    @PutMapping("/crew/board/{postNo}/comment/{commentNo}")
    public void putCrewComment(@PathVariable("postNo") Long postNo,
                                 @PathVariable("commentNo") Long commentNo,
                                 CrewCommentDTO dto) {

        service.updateComment(commentNo, dto);
        System.out.println(commentNo + "번 댓글 수정 완료");
    }

}
