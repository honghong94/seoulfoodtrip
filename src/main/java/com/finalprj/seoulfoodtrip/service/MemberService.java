package com.finalprj.seoulfoodtrip.service;

import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.dto.crew.CrewCommentDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewMemberDTO;
import com.finalprj.seoulfoodtrip.dto.crew.CrewPostDTO;
import com.finalprj.seoulfoodtrip.dto.review.ReviewCommentDTO;
import com.finalprj.seoulfoodtrip.dto.review.ReviewDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public interface MemberService {
    MemberDTO save(MemberDTO memberDTO) throws IOException;
    MemberDTO selectMember(String id);
    Page<ReviewDTO> getReviewListByUser(String id, Pageable pageable);
    Page<ReviewCommentDTO> getReviewCommentListByUser(String id, Pageable pageable);
    List<ReviewDTO> getReviewListByMember(String id);
    void deleteCommentListByUser(String id);
    void deleteCommentListByReviewNo(Long reviewNo);
    void updateMemberSecurity(MemberDTO dto, HttpSession session);
    CrewDTO getCrew(String id);
    List<CrewMemberDTO> getCrewList(String id);
    List<CrewPostDTO> getCrewPostListByMember(String id);
    Page<CrewPostDTO> getCrewPostListByUser(String id, Pageable pageable);
    Page<CrewCommentDTO> getCrewCommentListByUser(String id, Pageable pageable);
    void deleteCrewCommentListByUser(String id);
    void deleteCrewCommentListByPostNo(Long postNo);
    void deleteCrewMember(String id);

    int deleteMember(String id);

    int checkId(String id);

    int checkNickname(String nickname);

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
