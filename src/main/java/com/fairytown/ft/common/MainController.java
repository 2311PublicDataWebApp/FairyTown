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

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView showHomePage(ModelAndView mv) {
        try {
            List<GoodsVO> top4GoodsList = gService.selectTop4Goods();
            List<ReviewImageVO> top4ReviewList = rService.selectTop4Reviews();
            mv.addObject("gList", top4GoodsList);
            mv.addObject("String", top4ReviewList);
            mv.setViewName("main");
        } catch (Exception e) {
            mv.addObject("msg", e.getMessage());
            mv.setViewName("common/errorPage");
        }
        return mv;
    }
}
