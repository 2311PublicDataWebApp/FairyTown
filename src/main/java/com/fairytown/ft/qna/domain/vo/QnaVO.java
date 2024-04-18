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
public class QnaVO {
	
	private int qnaNo;
	@NonNull
	private String qnaName;
	private String qnaContent;
	private String qnaWriter;
	private String qnaStatus;
	private Date qnaDate;
	
}
