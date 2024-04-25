package com.fairytown.ft.chat.service;

import java.util.List;

import com.fairytown.ft.chat.domain.vo.ChatVO;

public interface ChatService {

	ChatVO selectChatId(String userId);

	void insertChatRoom(ChatVO newChat);

	int insertaddMsg(ChatVO chat);

	List<ChatVO> selectMsgByChatId(String chatUserId);

	void updateMsg(ChatVO chat);

	int deleteMsg(ChatVO chat);

	List<ChatVO> selectChatList();

	List<ChatVO> selectNoChatList();

	

}
