package com.finalprj.seoulfoodtrip.service;

import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.domain.Member;

public interface LoginService {
    MemberDTO login(MemberDTO dto);

    default Member dtoToEntity(MemberDTO dto){
        Member entity = Member.builder()
                .id(dto.getId())
                .password(dto.getPassword())
                .name(dto.getName())
                .nickname(dto.getNickname())
                .gender(dto.getGender())
                .email(dto.getEmail())
                .phone(dto.getPhone())
                .birth(dto.getBirth())
                .member_img(dto.getMember_img())
                .crleader(dto.getCrleader())
                .build();
        return entity;
    }

    default MemberDTO entityToDto(Member member){
        MemberDTO dto = MemberDTO.builder()
                .id(member.getId())
                .password(member.getPassword())
                .name(member.getName())
                .nickname(member.getNickname())
                .gender(member.getGender())
                .email(member.getEmail())
                .phone(member.getPhone())
                .birth(member.getBirth())
                .member_img(member.getMember_img())
                .crleader(member.getCrleader())
                .build();
        return dto;
    }
}
