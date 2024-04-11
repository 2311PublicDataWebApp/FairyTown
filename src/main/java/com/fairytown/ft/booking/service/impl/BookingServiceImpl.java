package com.fairytown.ft.booking.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.booking.service.BookingService;
import com.fairytown.ft.booking.store.BookingStore;

@Service
public class BookingServiceImpl implements BookingService{
	
	@Autowired
	private SqlSession session;
	@Autowired
	private BookingStore bStore;
	
}
