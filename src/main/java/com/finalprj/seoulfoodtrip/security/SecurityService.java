package com.finalprj.seoulfoodtrip.security;

import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.repository.LoginRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class SecurityService implements UserDetailsService {

    @Autowired
    private LoginRepository loginRepository;

    // MemberRepository로 회원 정보 조회
    // UserDetails 타입의 객체로 리턴
    @Override
    public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
        Member member = loginRepository.findById(id).get();

        if(member == null){
            return null;
        }

        MemberDTO memberDTO = MemberDTO.builder()
                .id(member.getId())
                .password(member.getPassword())
                .name(member.getName())
                .nickname(member.getNickname())
                .email(member.getEmail())
                .phone(member.getPhone())
                .birth(member.getBirth())
                .gender(member.getGender())
                .member_img(member.getMember_img())
                .crleader(member.getCrleader())
                .build();

        return new SecurityDetails(memberDTO);
        // 시큐리티의 세션에 유저정보 저장되는 시점
    }
}
