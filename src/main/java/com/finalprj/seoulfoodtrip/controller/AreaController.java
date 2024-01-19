package com.finalprj.seoulfoodtrip.controller;

import com.finalprj.seoulfoodtrip.dto.AreaDTO;
import com.finalprj.seoulfoodtrip.service.impl.AreaServiceImpl;
import com.finalprj.seoulfoodtrip.util.PagingParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AreaController {
    @Autowired
    private AreaServiceImpl service;

    @GetMapping(value = "/areaL")
    public String getAreaListView(Model model,
                           AreaDTO dto,
                           @PageableDefault(page = 0, size = 12) Pageable pageable) {
        Page<AreaDTO> areaPage = service.getAreaPage(dto, pageable);

        model.addAttribute("sigungu", dto.getSigungu());
        model.addAttribute("contentType", dto.getContentType());
        model.addAttribute("pagingParam", new PagingParam(10, areaPage));
        model.addAttribute("areaList", areaPage.getContent());
        return "area/areaList";
    }

    @GetMapping(value = "/areaD")
    public String areaDetail(Model model,
                             @RequestParam(value = "name") String name) {
        AreaDTO area = service.getArea(name);
        model.addAttribute("area", area);
        return "area/areaDetail";
    }
}