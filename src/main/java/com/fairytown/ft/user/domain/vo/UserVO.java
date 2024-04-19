package com.fairytown.ft.user.domain.vo;

import java.sql.Date;
import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class UserVO implements UserDetails{
	private String	userId;
	private String	userPw;
	private String	userEmail;
	private String	userPhone;
	private String	loginSt;
	private Date 	userBirthDate;
	private String	userSt;
	private int		zipCode;
	private String	userAddress;
	private String	detailAddress;
	private String	userAdmin;
	private Date	userDate;
	private String	realName;
	
	//검색 필터
	private String	keyword;
	private String	type;
	
	
	// 빈 값 확인 메서드
    public boolean isEmpty() {
        return userId == null || userId.isEmpty() &&
               userPw == null || userPw.isEmpty() &&
               userEmail == null || userEmail.isEmpty() &&
               userPhone == null || userPhone.isEmpty() &&
               loginSt == null || loginSt.isEmpty() &&
               userBirthDate == null &&
               userSt == null || userSt.isEmpty() &&
               zipCode == 0 &&
               userAddress == null || userAddress.isEmpty() &&
               detailAddress == null || detailAddress.isEmpty() &&
               userAdmin == null || userAdmin.isEmpty() &&
               userDate == null &&
               realName == null || realName.isEmpty() &&
               keyword == null || keyword.isEmpty() &&
               type == null || type.isEmpty();
    }

    @Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return Collections.singletonList(new SimpleGrantedAuthority(this.userAdmin));
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.userPw;
	}
	
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.userId;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}
