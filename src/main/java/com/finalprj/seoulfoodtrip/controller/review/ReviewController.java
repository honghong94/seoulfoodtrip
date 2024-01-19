package com.finalprj.seoulfoodtrip.controller.review;

import com.finalprj.seoulfoodtrip.dto.review.ReviewDTO;
import com.finalprj.seoulfoodtrip.service.impl.review.ReviewServiceImpl;
import com.finalprj.seoulfoodtrip.util.PagingParam;
import com.finalprj.seoulfoodtrip.util.UploadReviewFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReviewController {

    @Autowired
    private ReviewServiceImpl reviewService;
    @Autowired
    UploadReviewFileUtil fileUtil;

    @GetMapping("/review")
    public String getReviewListView(Model model,
                                    @RequestParam(name = "areaNo", required = false) Integer areaNo,
                                    @PageableDefault(size = 30, sort = "wDate", direction = Sort.Direction.DESC) Pageable pageable) throws Exception {
        Page<ReviewDTO> reviewPage = reviewService.getReviewPage(areaNo, pageable);

        model.addAttribute("areaNo", areaNo);
        model.addAttribute("pagingParam", new PagingParam(5, reviewPage));
        model.addAttribute("reviewList", reviewPage.getContent());
        return "/review/reviewList";
    }

    @GetMapping(value = "/review/{reviewNo}")
    public String getReviewDetailView(Model model,
                                      @PathVariable("reviewNo") Long reviewNo) {
        model.addAttribute("review", reviewService.getReviewHitAndChangeContentImgSource(reviewNo));
        return "/review/reviewDetail";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping(value = "/review/new")
    public String getReviewInsert() {
        return "/review/reviewInsert";
    }

    @PostMapping(value = "/review")
    @ResponseBody
    public void insertReview(ReviewDTO dto) {
        reviewService.getDTOfilledValues(dto);
        ReviewDTO insertedReivew = reviewService.insertReview(dto);
        fileUtil.moveImgsTempToReviewNoDir(insertedReivew.getReviewNo(), insertedReivew.getUploadImgNames());
        fileUtil.saveCourseImg(insertedReivew.getReviewNo(), dto.getCourseImgFile());
    }

    @DeleteMapping(value = "/review/{reviewNo}")
    public String deleteReview(@PathVariable("reviewNo") Long reviewNo) {
        reviewService.deleteReview(reviewNo);
        fileUtil.deleteReviewImgs(reviewNo);
        return "redirect:/review";
    }

    @GetMapping(value = "/review/{reviewNo}/edit")
    public String getReviewUpdateView(Model model,
                                      @PathVariable("reviewNo") Long reviewNo) {
        ReviewDTO dto = reviewService.getReview(reviewNo);
        fileUtil.moveImgsReviewNoDirToTemp(reviewNo);

        model.addAttribute("review", dto);
        return "/review/reviewUpdate";
    }

    @PutMapping(value = "/review/{reviewNo}")
    public String updateReview(@PathVariable("reviewNo") Long reviewNo,
                               ReviewDTO dto) {
        reviewService.updateUploadImgName(dto);
        reviewService.updateReview(reviewNo, dto);
        fileUtil.moveImgsTempToReviewNoDir(reviewNo, dto.getUploadImgNames());

        return "redirect:/review";
    }

}
