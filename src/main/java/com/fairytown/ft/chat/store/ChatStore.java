package com.fairytown.ft.chat.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.chat.domain.vo.ChatVO;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

public interface ChatStore {

	ChatVO selectChatId(SqlSession session, String userId);

	void insertChatRoom(SqlSession session, ChatVO newChat);

	int insertaddMsg(SqlSession session, ChatVO chat);

	List<ChatVO> selectMsgByChatId(SqlSession session, String chatUserId);



	
	
	
}
