package com.finalprj.seoulfoodtrip.service.impl;

import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import com.finalprj.seoulfoodtrip.domain.Member;
import com.finalprj.seoulfoodtrip.repository.LoginRepository;
import com.finalprj.seoulfoodtrip.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LoginServiceImpl implements LoginService{

    @Autowired
    private LoginRepository repository;

    @Override
    public MemberDTO login(MemberDTO dto) {
        Optional<Member> result = repository.findByIdAndPassword(dto.getId(), dto.getPassword());
        return result.isPresent()? entityToDto(result.get()) : null;
    }

}
