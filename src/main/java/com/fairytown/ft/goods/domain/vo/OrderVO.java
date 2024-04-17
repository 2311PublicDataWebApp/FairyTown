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
public class OrderVO {
	private String goodsOrderCode;
	@NonNull
	private Date goodsOrderDate;
	private String goodsOrderName;
	private String goodsOrderPhone;
	private String goodsOrderPostcode;
	private String goodsOrderAddress;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private Integer goodsSum;
	private Integer goodsCode;
	private String goodsOrderUserId;
	private Integer goodsOrderCnt;
//	private GoodsVO goods;
	private String goodsName;
	private Integer goodsPrice;
	private String goodsFileRename;
	private String merchantUid;
}
