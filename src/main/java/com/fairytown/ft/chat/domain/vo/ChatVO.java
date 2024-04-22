package com.fairytown.ft.chat.domain.vo;

import java.sql.Timestamp;

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
public class ChatVO {
	private int msgNo;
	@NonNull
	private String msgSendId;
	private String msgContents;
	private Timestamp msgSendDate;
	private String chatUserId;
	private String answer;
}
