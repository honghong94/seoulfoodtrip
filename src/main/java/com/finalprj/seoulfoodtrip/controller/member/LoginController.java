package com.finalprj.seoulfoodtrip.controller.member;

import com.finalprj.seoulfoodtrip.service.LoginService;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewBoardServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.crew.CrewServiceImpl;
import com.finalprj.seoulfoodtrip.service.impl.review.ReviewServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private LoginService service;

    @Autowired
    private ReviewServiceImpl reviewService;

    @Autowired
    private CrewServiceImpl crewService;

    @Autowired
    private CrewBoardServiceImpl crewBoardService;

    @GetMapping(value="/main")
    public String main(@RequestParam(value="name", defaultValue = "world") String name, Model model){
        model.addAttribute("name", name);
        model.addAttribute("reviewList", reviewService.getPopularReview());
        model.addAttribute("crewList", crewService.getNewCrews());
        model.addAttribute("crewPosts",crewBoardService.getPopularPosts());
        return "main";
    }

    @RequestMapping("/memberL")
    public String memberLogin() throws Exception{
        return "/member/memberLogin";
    }
}
