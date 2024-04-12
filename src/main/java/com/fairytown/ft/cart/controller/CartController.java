package com.fairytown.ft.cart.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.service.CartService;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
		
	
		@Autowired
		private CartService cService;
	
		// 카트 담기
		@ResponseBody
		@PostMapping(value = "/goods/addCart.ft")
		public void addCart(CartVO cart, HttpSession session) throws Exception {
		 
		 String userId = (String) session.getAttribute("userId");
		 cart.setCartUserId(userId);

		 cService.addCart(cart);
		 
		}
		
		// 카트 목록
		@GetMapping("/goods/cartList.ft")
	    public ModelAndView ShowCartList(ModelAndView mv, HttpSession session,
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage) {
			try {
				String userId = (String)session.getAttribute("userId");
				int totalCount = cService.getTotalCount(userId);
				PageInfo pi = this.getPageInfo(currentPage, totalCount);
//				List<CartListVO> cList = cService.selectCartList(userId, pi);
				List<CartVO> cList = cService.selectCartList();
				mv.addObject("cList", cList);
				mv.setViewName("goods/cartlist");
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
	    };
	    
	 // 카트 삭제
	    @PostMapping(value = "/goods/deleteCart.ft")
	    public ModelAndView deleteCart(@RequestParam("check-delete-cart") String selectCart, ModelAndView mv) throws Exception {
	    	try {
				String[] carts = selectCart.split(",");
				int result = 0;
				for(String cartNum : carts) {
					result = cService.deleteCart(cartNum);
					if(result > 0) {
						continue;
					}
					else {
						mv.addObject("msg", "장바구니를 삭제 할 수 없습니다.");
						mv.setViewName("common/errorPage");
					}
				}
				mv.setViewName("redirect:/goods/cartList.ft");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
	    	return mv;
	    }
	    
	    // 장바구니 주문
	    @PostMapping(value = "/goods/order.ft")
	    public ModelAndView orderCart(@RequestParam("check-order-cart") String selectCart, ModelAndView mv) throws Exception {
	    	try {
				String[] carts = selectCart.split(",");
				int result = 0;
				List<CartVO> cList = new ArrayList<CartVO>();
				for(String cartNum : carts) {
					cList.add(cService.selectCartList(cartNum));
				}
				mv.addObject("cList", cList);
				mv.setViewName("goods/orderInfo");
			
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
	    	return mv;
	    }
	    
	 // 주문 페이지 이동

	    
	    // 페이징
	    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
			PageInfo pi = null;
			int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
			
			pi = new PageInfo(currentPage, totalCount, boardLimit);
			return pi;
		}
}
