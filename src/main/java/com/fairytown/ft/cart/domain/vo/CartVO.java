package com.fairytown.ft.cart.domain.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
@ToString
public class CartVO {
	@NonNull
	private Integer cartNum;
	private String cartUserId;
	private String cartGoodsCode;
	private Date cartCklimit;	
	private String cartCkid;
	private Integer cartStock;
	private Date cartDate;
	private String goodsName;
	private String goodsPrice;
	private String goodsFileRename;
}
