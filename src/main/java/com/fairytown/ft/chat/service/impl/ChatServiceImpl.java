package com.fairytown.ft.chat.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.chat.domain.vo.ChatVO;
import com.fairytown.ft.chat.service.ChatService;
import com.fairytown.ft.chat.store.ChatStore;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatStore cStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public ChatVO selectChatId(String userId) {
		ChatVO chat = cStore.selectChatId(session, userId);
		return chat;
	}

	@Override
	public void insertChatRoom(ChatVO newChat) {
		cStore.insertChatRoom(session, newChat);
	}

	@Override
	public int insertaddMsg(ChatVO chat) {
		int result = cStore.insertaddMsg(session, chat);
		return result;
	}

	@Override
	public List<ChatVO> selectMsgByChatId(String chatUserId) {
		List<ChatVO> msgList = cStore.selectMsgByChatId(session, chatUserId);
		return msgList;
	}
	
	
}
