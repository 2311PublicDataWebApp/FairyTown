package com.fairytown.ft.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.service.GoodsService;
import com.fairytown.ft.review.domain.vo.ReviewImageVO;
import com.fairytown.ft.review.service.ReviewService;

@Controller
public class MainController {

    @Autowired
    private GoodsService gService;
    
    @Autowired
    private ReviewService rService;


//    @GetMapping("/")
//    public String showMain() {
//        return "main";
//    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView showHomePage(ModelAndView mv) {
        try {
            // gService에서 상위 4개 상품을 가져오는 메서드를 호출하여 리스트를 받아온다고 가정합니다.
            List<GoodsVO> top4GoodsList = gService.selectTop4Goods();
           // List<ReviewImageVO> top4ReviewList = rService.selectTop4Reviews();

            // 뷰에 상품 리스트를 전달합니다.
            mv.addObject("gList", top4GoodsList);
           // mv.addObject("String", top4ReviewList);
            mv.setViewName("main"); // 뷰 이름을 "main"으로 설정
        } catch (Exception e) {
            // 예외 처리
            mv.addObject("msg", e.getMessage());
            mv.setViewName("common/errorPage"); // 예외 발생 시 에러 페이지로 이동
        }
        return mv;
    }
}
