package com.fairytown.ft.user.domain.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class UserVO {
	private String userId;
	private String userPw;
	private String userEmail;
	private String userPhone;
	private String loginSt;
	private Date userBirthDate;
	private String userSt;
	private int zipCode;
	private String userAddress;
	private String detailAddress;
	private String userAdmin;
	private Date userDate;
	private String userName;
	
	
}
