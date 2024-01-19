package com.finalprj.seoulfoodtrip.controller.sub;

import com.finalprj.seoulfoodtrip.service.sub.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ImageController {
    @Autowired
    ImageService service;

    @PostMapping("/image")
    public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile image) {
        try {
            String filePath = service.store(image);
            return ResponseEntity.ok().body(filePath);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/image/crew")
    public ResponseEntity<?> CrewimageUpload(@RequestParam("file") MultipartFile image) {
        try {
            String filePath = service.store_crew(image);
            return ResponseEntity.ok().body(filePath);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
}
