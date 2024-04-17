package com.fairytown.ft.qna.domain.vo;

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
public class QnaReplyVO {
	
	private int qnaReplyNo;
	@NonNull
	private int refQnaNo;
	private String qnaReplyWriter;
	private String qnaReplyContent;
	private Date qnaReplyDate;

}
