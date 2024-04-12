package com.fairytown.ft.common.util;

import java.util.UUID;

public class FUpUtil {

    // 파일 이름을 고유하게 만들기 위해 UUID를 사용하는 메서드
    public static String name(String filename) {
        // 파일 이름을 변경하는 로직 구현
        String uniqueFileName = UUID.randomUUID().toString();
        return uniqueFileName;
    }
}
