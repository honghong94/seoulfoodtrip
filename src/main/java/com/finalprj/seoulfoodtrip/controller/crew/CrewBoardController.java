package com.finalprj.seoulfoodtrip.controller.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.domain.crew.Crew;
import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewMemberDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewPostDTO;
import com.finalprj.seoulfoodtrip.service.impl.MemberServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewBoardServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewMemberServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewServiceImpl;
import com.finalprj.seoulfoodtrip.util.PagingParam;
import com.finalprj.seoulfoodtrip.util.UploadCrewFileUtil;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class CrewBoardController {

    @Autowired
    CrewBoardServiceImpl crewBoardService;
    @Autowired
    CrewMemberServiceImpl crewMemberService;
    @Autowired
    MemberServiceImpl memberService;

    @Autowired
    CrewServiceImpl crewService;


    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UploadCrewFileUtil fileUtil;


    //크루활동게사글 목록
    @GetMapping("/crew/board")
    public String crewBoardList(Model model,
                                @RequestParam(name = "cat", required = false) String category,
                                @PageableDefault(size = 30, sort = "wDate", direction = Sort.Direction.DESC) Pageable pageable, HttpSession session) throws Exception {

        Page<CrewPostDTO> crewPosts;

        if (category == null) {
            crewPosts = crewBoardService.getCrewPosts(pageable);
        } else {
            crewPosts = crewBoardService.getCrewPostsByCat(category, pageable);
        }

        model.addAttribute("pagingParam", new PagingParam(10, crewPosts));
        model.addAttribute("crewPosts", crewPosts);

        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        boolean hasCrew = false;
        if(memberDTO != null){
            hasCrew = crewMemberService.isJoinedCrew(memberDTO.getId());
        }

        model.addAttribute("isJoinedCrew", hasCrew);
        return "/crew/crewBoard/crewBoardList";
    }

    //크루활동게사글 상세
    @GetMapping("/crew/board/{postNo}")
    public String crewBoardDetail(Model model,
                                  @PathVariable("postNo") Long postNo) throws Exception {
        CrewPostDTO crewPost = crewBoardService.getCrewPost(postNo);

        String content = crewPost.getContent();
        if (content != null) {
            crewPost.setContent(content.replace("temp", "" + crewPost.getPostNo()));
        }

        //멤버 리스트 전달객체
        List<Member> memberList = new ArrayList<>();

        String[] idList = crewPost.getMemberList().split(",");

        for (int i = 0; i < idList.length; i++) {
            MemberDTO memberDTO = memberService.selectMember(idList[i]);
            Member member = memberService.dtoToEntity(memberDTO);
            memberList.add(member);
        }

        model.addAttribute("crewPost", crewPost);
        model.addAttribute("memberList", memberList);

        return "/crew/crewBoard/crewBoardDetail";
    }

    //크루활동게사글 등록 폼
    @GetMapping("/crew/board/new")
    public String crewBoardInsertForm(Model model,
                                      @RequestParam String id) throws Exception {
        System.out.println(id);
        List<CrewMemberDTO> myCrewList = crewMemberService.getMyCrewList(id);
        model.addAttribute("myCrewList", myCrewList);
        return "/crew/crewBoard/crewBoardInsert";
    }

    //크루활동게사글 크루원 명단 -- 등록 폼 : 함께한 크루원 명단 출력 시
    @PostMapping("/crew/board/new")
    @ResponseBody
    public List<CrewMemberDTO> getCrewList(@RequestBody Map<String, Long> crewNo) throws Exception {
        return crewMemberService.getCrewMembers(crewNo.get("crewNo"));
    }

    //크루활동게사글 등록
    @PostMapping("/crew/board")
    @ResponseBody
    public void crewBoardInsert(@RequestParam(required = false) String[] uploadImgs,
                                @RequestParam(required = false) String[] memberName,
                                CrewPostDTO dto) {
        System.out.println(dto.getCrew().getCrewNo());
        System.out.println(dto.getMember().getId());
        if (uploadImgs != null) {
            //String배열 문자열 치환 후 문자열로 변경
            String uploadImg = Arrays.stream(uploadImgs).map(s -> s = s.split("temp")[1].substring(1)).collect(Collectors.joining(","));
            dto.setUploadImg(uploadImg);
        }


        CrewDTO crewDTO = crewService.getCrew(dto.getCrew().getCrewNo());
        MemberDTO memberDTO = memberService.selectMember(dto.getMember().getId());
        Member member = memberService.dtoToEntity(memberDTO);

        Crew crew = modelMapper.map(crewDTO, Crew.class);

        String memberList = null;

        if (memberName != null) {
            memberList = Arrays.stream(memberName).map(s -> s = s.split("/")[1].replace("\"", "")).collect(Collectors.joining(","));
        }

        CrewPostDTO post = crewBoardService.insertPost(dto, crew, member, memberList);
        if (post.getUploadImg() != null) {
            fileUtil.moveImagesCrew(post.getPostNo(), post.getUploadImg());
        }
        System.out.println("등록 완료");

    }


    //크루활동게사글 삭제
    @DeleteMapping("/crew/board/{postNo}")
    public String crewBoardDelete(@PathVariable("postNo") Long postNo) {
        crewBoardService.deletePost(postNo);
        fileUtil.deleteCrewImages(postNo);

        return "redirect:/crew/board";
    }

    //크루활동게사글 수정 폼
    @GetMapping("/crew/board/{postNo}/edit")
    public String crewBoardUpdateForm(Model model,
                                      @PathVariable("postNo") Long postNo) {
        CrewPostDTO dto = crewBoardService.getCrewPost(postNo);
        fileUtil.moveToTempCrew(postNo);

        model.addAttribute("crewPost", dto);
        return "/crew/crewBoard/crewBoardUpdate";
    }


    //크루활동게사글 수정
    @PutMapping("/crew/board/{postNo}")
    public String crewBoardUpdate(@PathVariable("postNo") Long postNo,
                                  CrewPostDTO dto,
                                  @RequestParam(required = false) String[] uploadImgs) {

        if (uploadImgs != null) {
            //String배열 문자열 치환 후 문자열로 변경
            dto.setUploadImg(dto.getUploadImg() + "," + Arrays.stream(uploadImgs).map(s -> s = s.split("temp")[1].substring(1)).collect(Collectors.joining(",")));
        }

        crewBoardService.updatePost(postNo, dto);
        fileUtil.moveImagesCrew(postNo, dto.getUploadImg());

        System.out.println(postNo + "번 게시글 수정 완료");
        return "redirect:/crew/board";
    }
}


