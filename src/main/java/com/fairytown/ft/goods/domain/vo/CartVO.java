package com.fairytown.ft.goods.domain.vo;

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
	private Integer cartGoodsCode;
	private Date cartCklimit;	
	private String cartCkid;
	private Integer cartStock;
	private Integer goodsStock;
	private Date cartDate;
	private String goodsName;
	private Integer goodsPrice;
	private String goodsFileRename;
}
