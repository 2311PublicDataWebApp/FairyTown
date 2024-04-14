package com.fairytown.ft.goods.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.service.CartService;
import com.fairytown.ft.user.domain.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
		
	
		@Autowired
		private CartService cService;
	
		// 카트 담기
		@ResponseBody
		@PostMapping(value = "/goods/addCart.ft")
		public int addCart(@ModelAttribute CartVO cart, HttpSession session, @RequestParam("cartGoodsCode") Integer cartGoodsCode, @RequestParam("cartStock") Integer cartStock) throws Exception {
			int result = 0;
			UserVO uOne = (UserVO) session.getAttribute("user");
			if(uOne != null) {
				cart.setCartUserId(uOne.getUserId());
				cart = cService.findByUserIdAndGoodsCode(cart);
				if(cart == null) {
					CartVO newCart = new CartVO();
				    newCart.setCartUserId(uOne.getUserId());
				    newCart.setCartGoodsCode(cartGoodsCode);
				    newCart.setCartStock(cartStock);
					result = cService.addCart(newCart);
				} else {
					int prev = cart.getCartStock();
				    cart.setCartStock(prev+cartStock);
					result = cService.addCnt(cart);
				}
			} 
			
			return result;
		}
		
		
		// 카트 목록
		@GetMapping("/goods/cartList.ft")
	    public ModelAndView ShowCartList(@ModelAttribute CartVO cart, ModelAndView mv, HttpSession session,
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage) {
			try {
				UserVO uOne = (UserVO) session.getAttribute("user");
				String userId = uOne.getUserId();
				cart.setCartUserId(userId);
				int totalCount = cService.getTotalCount(userId);
				List<CartVO> cList = cService.selectCartList(userId);
				mv.addObject("cList", cList);
				mv.addObject("totalCount", totalCount);
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
	    @PostMapping(value = "/goods/orderInfo.ft")
	    public ModelAndView orderCart(@RequestParam("check-order-cart") String selectCart, ModelAndView mv) throws Exception {
	    	try {
				String[] carts = selectCart.split(",");
				int result = 0;
				List<CartVO> cList = new ArrayList<CartVO>();
				for(String cartNum : carts) {
					cList.add(cService.selectOrderList(cartNum));
				}
				mv.addObject("cList", cList);
				mv.setViewName("goods/orderInfo");
			
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
	    	return mv;
	    }
	    

	    @ResponseBody
	    @PostMapping(value="/goods/cartCntMinus.ft")
	    public String MinusCnt(@ModelAttribute CartVO cart
	    		, @RequestParam("cartNum") Integer cartNum
	    		, @RequestParam("cartStock") Integer cartStock
	    		, HttpSession session) {
	    	try {
	    		int prev = cart.getCartStock();
	    		cart.setCartStock(prev - 1);
				int result = 0;
				result = cService.MinusCnt(cart);
				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			} catch (Exception e) {
				// TODO: handle exception
				return e.getMessage();
			}
	    }

	    
	    // 페이징
	    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
			PageInfo pi = null;
			int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
			
			pi = new PageInfo(currentPage, totalCount, boardLimit);
			return pi;
		}
}
