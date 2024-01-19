package com.finalprj.seoulfoodtrip.service;

import com.finalprj.seoulfoodtrip.dto.AreaDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface AreaService {
    AreaDTO getArea(String name);

    Page<AreaDTO> getAreaPage(AreaDTO dto, Pageable pageable);
}
