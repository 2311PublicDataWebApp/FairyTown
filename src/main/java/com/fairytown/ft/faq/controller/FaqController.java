package com.fairytown.ft.faq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FaqController {
	
	@RequestMapping(value="/faq.ft", method=RequestMethod.GET)
    public ModelAndView showInsertForm(ModelAndView mv) {
        mv.setViewName("faq/detail");
        return mv;
    }
}
