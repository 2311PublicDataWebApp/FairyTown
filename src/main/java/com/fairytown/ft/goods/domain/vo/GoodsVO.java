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
public class GoodsVO {
	private Integer goodsCode;
	@NonNull
	private String goodsName;
	private String goodsPrice;
	private Integer goodsStock;
	private Date goodsDate;
	private String goodsContent;
	private String goodsFilename;
	private String goodsFileRename;
	private String goodsFilePath;
	private long goodsFileLength;
	private String goodsImgNo;
	private String goodsCodeRef;
	private String goodsImgName;
	private String goodsImgRename;
	private String goodsImgFilePath;
	private long goodsImgFileLength;
	private String goodsImgThumbnail;
}
