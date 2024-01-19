package com.finalprj.seoulfoodtrip.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    private final UserDetailsService userDetailsService;


    // http 관련 보안 설정
    // URL 별 권한 설정, 로그인,세션 등등 HTTP 보안 관련 설정
    // 열것만 열고 나머지는 다 잠그기 (positive 방식)
   @Override
    protected void configure(HttpSecurity security) throws Exception {
       // antMatchers() 안에 비회원도 접속할 수 있는 url 적으심 됩니다
        security.authorizeRequests().antMatchers("/main","/memberL","/memberJ","/memberP","/memberR","/member/**","/register" ,"/areaD","/areaL").permitAll()
                .antMatchers(HttpMethod.GET,"/review").permitAll()
                .antMatchers(HttpMethod.GET,"/review/{reviewNo}").permitAll()
                .antMatchers(HttpMethod.GET,"/review/{reviewNo}/comment").permitAll()
                .antMatchers(HttpMethod.GET,"/crewL").permitAll()
                .antMatchers(HttpMethod.GET,"/crewD").permitAll()
                .antMatchers(HttpMethod.GET,"/crew/board").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/memberL")
                .loginProcessingUrl("/login")
                .usernameParameter("id")
                .passwordParameter("password")
                .successHandler(new LoginSuccessHandler())
                .failureHandler(new LoginFailHandler())
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessHandler(new MemberLogoutSuccessHandler());

        security.csrf().disable();
    }

    //실제 인증을 진행할 Provider
    // DB 로부터 아이디,비번이 맞는지 해당 유저가 어떤 권한을 가지는지를 체크
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
       // 2 추가 코드
        auth.userDetailsService(userDetailsService).passwordEncoder(enc());
    }

    //이미지,자바스크립트,css 디렉토리 보안 설정
    @Override
    public void configure(WebSecurity web) {
       web.ignoring().antMatchers("/_css/**","/_image/**","/_js/**","/font/**","/favicon.ico");
    }

    // 비밀번호 암호화 Bean
    @Bean
    public BCryptPasswordEncoder enc(){
       return new BCryptPasswordEncoder();
    }

    // 회원정보 수정을 위한 Bean
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
