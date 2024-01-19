package com.finalprj.seoulfoodtrip.controller.crew;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.domain.crew.Crew;
import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewMemberDTO;
import com.finalprj.seoulfoodtrip.service.impl.MemberServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewMemberServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewServiceImpl;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@Controller
public class CrewMemberController {

    @Autowired
    CrewMemberServiceImpl crewMemberService;
    @Autowired
    CrewServiceImpl crewService;
    @Autowired
    MemberServiceImpl memberService;

    @Autowired
    ModelMapper modelMapper;

    // crewDetail -> 크루 가입 버튼 클릭시 팝업창 생성
    @RequestMapping(value = "/crewJ", method = RequestMethod.GET)
    public String getCrewJoinForm(Model model,
                                  @RequestParam Long crewNo) {
        CrewDTO crew = crewService.getCrew(crewNo);

        model.addAttribute("crew", crew);
        return "/crew/popup_crewJoin";
    }

    //크루 가입
    @RequestMapping(value = "/crewJ", method = RequestMethod.POST)
    @ResponseBody
    public String joinCrew(CrewMemberDTO dto) throws IOException {
        CrewDTO crewDTO = crewService.getCrew(dto.getCrew().getCrewNo());

        String joinMemberId = dto.getMember().getId();

        if (crewMemberService.countMember(joinMemberId) >= 3) {
            return "가입 하실 수 있는 크루는 최대 3개 입니다.";
        }

        //크루장 가입 방지
        if (crewDTO.getMember().getId().equals(joinMemberId)) {
            System.out.println("이미 해당 크루의 크루장 입니다.");
            return "이미 해당 크루의 크루장 입니다.";
        } else {
            //크루 재가입 방지
            if (crewMemberService.hasThisCrewMember(dto.getCrew().getCrewNo(), dto.getMember().getId())) {
                System.out.println("이미 가입된 크루원 입니다.");
                return "이미 가입된 크루원 입니다.";
            } else {

                MemberDTO memberDTO = memberService.selectMember(joinMemberId);
                Member member = memberService.dtoToEntity(memberDTO);
                Crew crew = modelMapper.map(crewDTO, Crew.class);
                dto.setMember(member);
                dto.setCrew(crew);
                dto.setState(false);//todo
                //크루원 등록
                crewMemberService.insertCrewMember(dto);
                return "크루가입이 요청 되었습니다.";
            }
        }
    }

    //크루 가입 승인
    @RequestMapping(value = "/crewJ/agree", method = RequestMethod.POST)
    public String agreeCrewJoin(@RequestBody Map<String, Long> regNoMap) {

        crewMemberService.updateCrew(regNoMap.get("regNo"));
        return "redirect:/crewL";
    }

    //크루 가입 거절 및 강퇴
    @RequestMapping(value = "/crewJ/deny", method = RequestMethod.POST)
    public String denyCrewJoinOrKick(@RequestBody Map<String, Long> regNoMap) {

        crewMemberService.deleteCrew(regNoMap.get("regNo"));
        return "redirect:/crewL";
    }

    //크루장 위임
    @ResponseBody
    @RequestMapping(value = "/crewJ/give", method = RequestMethod.POST)
    public String giveMaster(CrewMemberDTO dto, HttpSession session) throws IOException {
        CrewMemberDTO crewMemberDTO = crewMemberService.getCrewMember(dto.getRegNo());


        MemberDTO memberDTO = memberService.selectMember(dto.getMember().getId());
        Member member = memberService.dtoToEntity(memberDTO);

        if (member.getCrleader() == 'y') {
            return "해당 멤버는 이미 크루장 입니다.";
        } else {
            crewMemberService.deleteCrew(dto.getRegNo());//크루원 삭제
            crewService.updateCrewMaster(crewMemberDTO.getCrew().getCrewNo(), member);
            //권한 부여
            memberDTO.setCrleader('y');
            memberService.updateMmeber(memberDTO);

            //권한 박탈
            MemberDTO user = (MemberDTO) session.getAttribute("member");
            user.setCrleader('n');
            MemberDTO userNoLeader = memberService.updateMmeber(user);
            session.setAttribute("member", userNoLeader);
        }

        return "해당 멤버가 크루장으로 위임되었습니다.";
    }

    //대기멤버 가입서 보기
    @RequestMapping(value = "/crewJ/info", method = RequestMethod.GET)
    public String getJoinInfo(Model model,
                              @RequestParam String id,
                              @RequestParam Long crewNo) throws IOException {
        CrewMemberDTO crewMember = crewMemberService.getCrewMember(id, crewNo);
        CrewDTO crew = crewService.getCrew(crewNo);

        model.addAttribute("crewMember",crewMember);
        model.addAttribute("crew",crew);

        return "crew/popup_joinInfo";
    }


}
