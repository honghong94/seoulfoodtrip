package com.finalprj.seoulfoodtrip.security;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFailHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception){
        try{
            request.setAttribute("result","false");
//            request.getRequestDispatcher("/doldolseo/member").forward(request,response);
            request.getRequestDispatcher("/member").forward(request,response);
        }catch (Exception e){
            System.out.println("LoginFailHandler err : " + e.getMessage());
        }
    }
}
