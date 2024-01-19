package com.finalprj.seoulfoodtrip.security;

import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

@Data
public class SecurityDetails implements UserDetails {

    private MemberDTO memberDTO;

    public SecurityDetails(MemberDTO memberDTO){
        super();
        this.memberDTO = memberDTO;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authList = new ArrayList<>();
        authList.add(new SimpleGrantedAuthority(memberDTO.getCrleader().toString()));
        return authList;
    }

    @Override
    public String getPassword() {
        return memberDTO.getPassword();
    }

    @Override
    public String getUsername() {
        return memberDTO.getId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public MemberDTO getMemberDTO() {
        return memberDTO;
    }
}
