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
public class ChatMessageDto {
	@NonNull
	private MessageType messageType; // 메시지 타입
    private Long chatNo; // 방 번호
    private Long fromId;
	private String toId;
	private String chatContent;
    private Timestamp chatTime;
	
	public enum MessageType{
        ENTER, TALK
    }
	
}
