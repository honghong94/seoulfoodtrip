package com.finalprj.seoulfoodtrip.controller.mypage;

import com.finalprj.seoulfoodtrip.dto.MemberDTO;

import com.finalprj.seoulfoodtrip.dto.crew.CrewCommentDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewMemberDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewPostDTO;
import com.finalprj.seoulfoodtrip.dto.review.ReviewCommentDTO;
import com.finalprj.seoulfoodtrip.dto.review.ReviewDTO;
import com.finalprj.seoulfoodtrip.service.MemberService;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewBoardServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.review.ReviewServiceImpl;
import com.finalprj.seoulfoodtrip.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MyPageController {

    @Autowired
    private MemberService service;

    @Autowired
    UploadProfileUtil profileUtil;

    @Autowired
    UploadReviewFileUtil reviewFileUtil;

    @Autowired
    private ReviewServiceImpl reviewService;

    @Autowired
    private CrewBoardServiceImpl crewBoardService;

    @Autowired
    UploadCrewFileUtil crewFileUtil;

    @RequestMapping("/updateMember")
    public String updateMember(@RequestParam(value = "memberimg") MultipartFile file,
                               @PageableDefault(size = 5, sort = "wDate", direction = Sort.Direction.DESC) Pageable pageable,
                               MemberDTO dto, Model model, HttpServletRequest request) throws Exception {
        MemberDTO originUser = service.selectMember(dto.getId());
        MemberDTO changeUser = profileUtil.updateProfile(originUser, dto, file);
        MemberDTO updatedUser = service.save(changeUser);
        HttpSession session = request.getSession();
        session.setAttribute("member", updatedUser);

        // 스프링 시큐리티 세션 갱신
        service.updateMemberSecurity(updatedUser, session);

        // 크루 목록 생성
        CrewDTO crewDTO = service.getCrew(dto.getId());
        List<CrewMemberDTO> crewMemberDTO = service.getCrewList(dto.getId());
        model.addAttribute("crewDTO", crewDTO);
        model.addAttribute("crewMemberDTO", crewMemberDTO);

        // 사용자 크루활동글 목록
        Page<CrewPostDTO> crewPostList = service.getCrewPostListByUser(dto.getId(), pageable);

        model.addAttribute("crewPostPaging", new PagingParam(5, crewPostList));
        model.addAttribute("crewPostList", crewPostList);

        // 사용자 크루활동댓글 목록
        Page<CrewCommentDTO> crewCommentList = service.getCrewCommentListByUser(dto.getId(), pageable);

        model.addAttribute("crewCommentPaging", new PagingParam(5, crewCommentList));
        model.addAttribute("crewCommentList", crewCommentList);


        // 사용자 후기글 목록
        Page<ReviewDTO> reviewList = service.getReviewListByUser(dto.getId(), pageable);
        model.addAttribute("reviewListPaging", new PagingParam(5, reviewList));
        model.addAttribute("reviewList", reviewList);

        // 사용자 댓글 목록
        Page<ReviewCommentDTO> reviewCommentList = service.getReviewCommentListByUser(dto.getId(), pageable);
        model.addAttribute("reviewCommentPaging", new PagingParam(5, reviewCommentList));
        model.addAttribute("commentList", reviewCommentList);

        return "/mypage/mypageDetail";
    }

    @RequestMapping("/mypageD")
    public String mypageDetail(@PageableDefault(size = 5, sort = "wDate", direction = Sort.Direction.DESC) Pageable pageable
            , MemberDTO dto, Model model) throws Exception {
        // 크루 목록 생성
        CrewDTO crewDTO = service.getCrew(dto.getId());
        List<CrewMemberDTO> crewMemberDTO = service.getCrewList(dto.getId());
        model.addAttribute("crewDTO", crewDTO);
        model.addAttribute("crewMemberDTO", crewMemberDTO);

        // 사용자 크루활동글 목록
        Page<CrewPostDTO> crewPostList = service.getCrewPostListByUser(dto.getId(), pageable);

        model.addAttribute("crewPostPaging", new PagingParam(5, crewPostList));
        model.addAttribute("crewPostList", crewPostList);

        // 사용자 크루활동댓글 목록
        Page<CrewCommentDTO> crewCommentList = service.getCrewCommentListByUser(dto.getId(), pageable);

        model.addAttribute("crewCommentPaging", new PagingParam(5, crewCommentList));
        model.addAttribute("crewCommentList", crewCommentList);


        // 사용자 후기글 목록
        Page<ReviewDTO> reviewList = service.getReviewListByUser(dto.getId(), pageable);
        model.addAttribute("reviewListPaging", new PagingParam(5, reviewList));
        model.addAttribute("reviewList", reviewList);

        // 사용자 댓글 목록
        Page<ReviewCommentDTO> reviewCommentList = service.getReviewCommentListByUser(dto.getId(), pageable);
        model.addAttribute("reviewCommentPaging", new PagingParam(5, reviewCommentList));
        model.addAttribute("commentList", reviewCommentList);

        return "/mypage/mypageDetail";
    }

    // 후기, 댓글 삭제 구현해야함
    @RequestMapping("/removeMember")
    public String removeMember(MemberDTO dto, Model model, HttpServletRequest request) {

        // 사용자 후기게시판 댓글, 글 모두 삭제
        service.deleteCommentListByUser(dto.getId());
        List<ReviewDTO> reviewList = service.getReviewListByMember(dto.getId());
        for (ReviewDTO reviewDTO : reviewList) {
            service.deleteCommentListByReviewNo(reviewDTO.getReviewNo());
            reviewService.deleteReview(reviewDTO.getReviewNo());
            reviewFileUtil.deleteReviewImgs(reviewDTO.getReviewNo());
        }

        // 사용자 크루 게시판 글,댓글 삭제
        service.deleteCrewCommentListByUser(dto.getId());
        List<CrewPostDTO> crewPostList = service.getCrewPostListByMember(dto.getId());
        for (CrewPostDTO crewPostDTO : crewPostList) {
            service.deleteCrewCommentListByPostNo(crewPostDTO.getPostNo());
            crewBoardService.deletePost(crewPostDTO.getPostNo());
            crewFileUtil.deleteCrewImages(crewPostDTO.getPostNo());
        }

        // 사용자 크루 탈퇴
        service.deleteCrewMember(dto.getId());

        // 사용자 프로필, 계정 삭제
        MemberDTO member = service.selectMember(dto.getId());
        profileUtil.deleteProfile(member);
        int result = service.deleteMember(dto.getId());
        SecurityContextHolder.clearContext();

        String url = "";

        if (result == 0) {
            HttpSession session = request.getSession();
            session.invalidate();
            model.addAttribute("removeResult", 0);
            url = "redirect:/main";
        } else {
            model.addAttribute("removeResult", 1);
            url = "redirect:/mypageD?id=" + dto.getId();
        }

        return url;
    }
}
