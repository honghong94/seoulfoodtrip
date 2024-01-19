package com.finalprj.seoulfoodtrip.controller.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewDTO;
import com.finalprj.seoulfoodtrip.service.impl.MemberServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewMemberServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewServiceImpl;
import com.finalprj.seoulfoodtrip.util.PagingParam;
import com.finalprj.seoulfoodtrip.util.UploadCrewFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
public class CrewController {

    @Autowired
    CrewServiceImpl crewService;
    @Autowired
    CrewMemberServiceImpl crewMemberService;

    @Autowired
    UploadCrewFileUtil fileUtil;

    //추가코드
    @Autowired
    MemberServiceImpl memberService;

    /* 크루 목록 보기 */
    @RequestMapping("/crewL")
    public String goCrewListView(Model model,
                                 @PageableDefault(size = 16, sort = "cDate", direction = Sort.Direction.DESC) Pageable pageable) throws Exception {

        Page<CrewDTO> crewPage = crewService.getCrewPage(pageable);
        model.addAttribute("pagingParam", new PagingParam(10, crewPage));
        model.addAttribute("crewPage", crewPage);

        return "/crew/crewList";
    }

    /* 크루 생성페이지로 이동 */
    @RequestMapping(value = "/crewI", method = RequestMethod.GET)
    public String goCrewInsertView() throws Exception {
        return "/crew/crewInsert";
    }

    /* 크루 생성 */
    @RequestMapping(value = "/crewI", method = RequestMethod.POST)
    public String createCrew(CrewDTO dto,
                             MultipartFile crewImgFile,
                             HttpSession session) throws Exception {


        // 추가코드 --> 양방향 연관관계 적용 후 해당 코드 삭제
        memberService.setMemberToCrleader(dto.getMember().getId(), session); //해당 멤버 크루장으로
        Member member = memberService.selectMemberEntity(dto.getMember());
        session.setAttribute("member", memberService.entityToDto(member));
        //update추가
//        memberService.updateMemberSecurity(, session);
        dto.setMember(member);
        // end of 추가코드
        // 추가코드 --> 양방향 연관관계 적용 후 해당 코드 삭제

        crewService.insertCrew(dto, crewImgFile);

        return "redirect:/crewL";
    }

    /* 크루명 중복 체크 */
    @RequestMapping(value = "/crewI/check", method = RequestMethod.GET)
    @ResponseBody
    public boolean checkCrewNameExist(@RequestParam String crewName) throws Exception {

        return crewService.isExistCrewName(crewName);
    }

    /* 크루 상세 보기 */
    @RequestMapping(value = "/crewD", method = RequestMethod.GET)
    public String goCrewDetailView(Model model,
                               @RequestParam Long crewNo) throws Exception {

        model.addAttribute("crewMembers", crewMemberService.getCrewMembers(crewNo));
        model.addAttribute("crew", crewService.getCrew(crewNo));

        return "/crew/crewDetail";
    }

    /* 크루관리 폼 */
    @PreAuthorize("isAuthenticated() and hasAuthority('y')")
    @RequestMapping("/crewM")
    public String goCrewManageView(Model model,
                             HttpSession session) throws Exception {

        // 추가코드 --> 양방향 연관관계 적용 후 해당 코드 삭제
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        CrewDTO crew = crewService.getCrewById(member.getId());
        // 추가코드 --> 양방향 연관관계 적용 후 해당 코드 삭제

        model.addAttribute("crew", crewService.getCrewById(member.getId()));
        model.addAttribute("crewMembers", crewMemberService.getCrewMembers(crew.getCrewNo()));
        model.addAttribute("watingMembers", crewMemberService.getWatingMember(crew.getCrewNo()));

        return "/crew/crewManage";
    }

    /* 크루관리 - 수정 */
    @RequestMapping(value = "/crewM/edit/{action}", method = RequestMethod.POST)
    public void crewManageEdit(@PathVariable("action") String action,
                               CrewDTO dto,
                               MultipartFile crewImgFile) throws Exception {

        if (action.equals("img")) {
            CrewDTO crew = crewService.getCrew(dto.getCrewNo());
            String imgFileName = fileUtil.updateCrewLogo(dto, crewImgFile);
            System.out.println(imgFileName);
            dto.setCrewImgFileName(imgFileName);
        }

        crewService.updateCrew(dto, action);

//        return "redirect:/crewM?crewNo="+dto.getCrewNo();
    }

    /* 크루 가입 양식 수정 폼 */
    @RequestMapping(value = "/crewM/editJoin", method = RequestMethod.GET)
    public String getEditJoinForm(Model model, CrewDTO dto) throws Exception {


        model.addAttribute("crew", dto);
        return "/crew/popup_crewEditJoin";
    }

}
