package com.finalprj.seoulfoodtrip.security;

import com.finalprj.seoulfoodtrip.dto.MemberDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        try{
            MemberDTO dto = ((SecurityDetails)authentication.getPrincipal()).getMemberDTO();
            HttpSession session = request.getSession();
            session.setAttribute("member", dto);
//            response.sendRedirect("/doldolseo/main");
            response.sendRedirect("/main");
        }catch (Exception e){
            System.out.println("LoginSuccessHandler err : " + e.getMessage());
        }
    }
}
