package com.fairytown.ft.review.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ImageController {
    
    // 이미지 경로
    private static final String IMAGE_PATH = "/images/";

    // 이미지 목록
    private static final List<String> images = Arrays.asList(
        "image1.jpg",
        "image2.jpg",
        "image3.jpg"
    );

    // 이미지 목록을 반환하는 엔드포인트
    @GetMapping("/api/images")
    public List<String> getImages() {
        return images.stream()
                     .map(image -> IMAGE_PATH + image)
                     .collect(Collectors.toList());
    }
}
