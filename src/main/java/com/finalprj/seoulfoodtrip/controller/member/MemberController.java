package com.finalprj.seoulfoodtrip.controller.member;
import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.service.MemberService;
import com.finalprj.seoulfoodtrip.util.UploadProfileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public class MemberController {

    @Autowired
    private MemberService service;

    @Autowired
    private UploadProfileUtil profileUtil;

    // 가입한 회원 등록
    @RequestMapping("/register")
    public String register(@RequestParam(value = "memberimg") MultipartFile file, MemberDTO memberDTO, Model model, HttpServletRequest request) throws Exception{
        String profileImg = "sample.png";
        if(!(file.isEmpty())){
            profileImg = profileUtil.uploadProfile(file, memberDTO);
        }
        memberDTO.setMember_img(profileImg);
        MemberDTO member = service.save(memberDTO);

        request.setAttribute("id",member.getId());
        request.setAttribute("nickname",member.getNickname());
        return "/member/memberJoinResult";
    }

    // 회원가입시 ID 중복체크
    @RequestMapping(value="/member/checkId")
    @ResponseBody
    public Map<Object, Object> checkId(@RequestBody String id) {
        Map<Object, Object> map = new HashMap<Object, Object>();
        int result = service.checkId(id);
        map.put("result", result);
        return map;
    }

    // 회원가입시 닉네임 중복체크
    @RequestMapping(value="/member/checkNickname")
    @ResponseBody
    public Map<Object, Object> checkNickname(@RequestBody String nickname) {
        Map<Object, Object> map = new HashMap<Object, Object>();
        int result = service.checkNickname(nickname);
        map.put("result", result);
        return map;
    }

    // 회원가입 등록 폼
    @GetMapping("/member")
    public String memberJoin() throws Exception{
        return "/member/memberJoin";
    }

    // 회원가입 완료 여부 페이지
    @RequestMapping("/memberJR")
    public String memberJoinResult() throws Exception{
        return "/member/memberJoinResult";
    }

    // 이용방침 페이지
    @RequestMapping("/memberP")
    public String memberPolicy() throws Exception{
        return "/member/memberPolicy";
    }

    // 가입약관 페이지
    @RequestMapping("/memberR")
    public String memberRule() throws Exception{
        return "/member/memberRule";
    }
}
