package com.fairytown.ft.user.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.user.config.AccountLockedException;
import com.fairytown.ft.user.domain.vo.KakaoProfile;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.store.UserStore;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@Service
public class UserService implements UserDetailsService{

	@Autowired
	private UserStore uStore;

	//회원가입 메서드
	public int insertUser(UserVO user) {
		int result = uStore.insertUser(user);
		return result;
	}

	//중복확인
	public List<UserVO> insertDuplication(UserVO user) {
		List<UserVO> uOne = uStore.insertDuplication(user);
		return uOne;
	}

	//이메일로 회원 검색
	public UserVO userFindByEmail(String userEmail) {
		UserVO user = uStore.userFindByEmail(userEmail);
		return user;
	}

	//이메일 + 아이디로 회원 검색
	public UserVO userFindByEmailAndId(UserVO uOne) {
		UserVO user = uStore.userFindByEmailAndId(uOne);
		return user;
	}

	//비밀번호 변경
	public int pwModify(UserVO user) {
		int result = uStore.pwModify(user);
		return result;
	}

	//회원 정보수정
	public int userUpdate(UserVO user) {
		int result = uStore.userUpdate(user);
		return result;
	}

	//회원 정보 조회
	public UserVO selectUser(String userId) {
		UserVO user = uStore.checkUserLogin(userId);
		return user;
	}

	//회원 정보 삭제
	public int deleteUser(UserVO user) {
		//참조 테이블 데이터 삭제
		uStore.deleteUserReview(user);
		uStore.deleteUserNotice(user);
		uStore.deleteUserBlack(user);
		uStore.deleteUserBlack(user);
		uStore.deleteUserBooking(user);
		uStore.deleteUserTicket(user);
		
		int result = uStore.deleteUser(user);
		return result;
	}

	//유저 목록 조회
	public List<UserVO> selectUserList(PageInfo pi) {
		List<UserVO> uList = uStore.selectUserList(pi);
		return uList;
	}

	//유저 목록 수 얻기
	public int getUserTotalCount() {
		int totalCount = uStore.getUserTotalCount();
		return totalCount;
	}

	public int getSearchUserTotalCount(UserVO user) {
		int totalCount = uStore.getSearchUserTotalCount(user);
		return totalCount;
	}

	public List<UserVO> searchUserList(PageInfo pi) {
		List<UserVO> uList = uStore.searchUserList(pi);
		return uList;
	}
	
	// 카카오 로그인 access_token 리턴
	public String getAccessToken(String code) throws Exception {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        try {
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            // try-with-resources 구문을 사용하여 자원을 자동으로 해제합니다.
            try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()))) {
                StringBuilder sb = new StringBuilder();
                sb.append("grant_type=authorization_code");
                sb.append("&client_id=14b775c94ce2cca9ae295f299b970238"); // 본인이 발급받은 키
                sb.append("&redirect_uri=http://127.0.0.1:8899/user/login.ft"); // 본인이 설정한 경로
                sb.append("&code="+code);
                bw.write(sb.toString());
                bw.flush();
            }

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            // try-with-resources 구문을 사용하여 자원을 자동으로 해제합니다.
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                String line;
                StringBuilder response = new StringBuilder();

                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
                System.out.println("response body : " + response.toString());

                // Gson 라이브러리를 사용하여 JSON 응답을 파싱합니다.
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    Gson gson = new Gson();
                    JsonElement element = gson.fromJson(response.toString(), JsonElement.class);

                    access_Token = element.getAsJsonObject().get("access_token").getAsString();
                    refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

                    System.out.println("access_token : " + access_Token);
                    System.out.println("refresh_token : " + refresh_Token);
                } else {
                    // 오류 처리
                    System.out.println("error response: " + response.toString());
                }
            }
        } finally {
            conn.disconnect();
        }

        return access_Token;
    }
		
	// 카카오 사용자 정보 추출
	public KakaoProfile getKakaoInfo(String accessToken) throws Exception {
		KakaoProfile userInfo = new KakaoProfile();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
	
			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
	
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	
			String line = "";
			String result = "";
	
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
	
			Gson gson = new Gson();
			JsonElement element = gson.fromJson(result, JsonElement.class);
	
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			long id = element.getAsJsonObject().get("id").getAsLong(); // 사용자의 카카오 아이디 추출
	
			// 콘솔창 확인 후 필요한 정보 추출
			System.out.println("kakao_account : " + kakao_account);
	
			String userEmail = kakao_account.getAsJsonObject().get("email").getAsString();
			String userNickname = properties.getAsJsonObject().get("nickname").getAsString();
			
			userInfo.setProvider("kakao");
			userInfo.setProviderId(userInfo.getProvider() + id);
			userInfo.setKakaoEmail(userEmail);
			userInfo.setKakaoNickname(userNickname);
		} catch (IOException e) {
			e.printStackTrace();
		}
	
		return userInfo;
	}
	
	public boolean isUserNew(KakaoProfile profile) {
	    UserVO user = uStore.userFindByEmail(profile.getKakaoEmail());
	    return user == null; // user가 null이면 새로운 사용자임을 의미
	}
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		UserVO user = uStore.checkUserLogin(userId);

	    if (user == null) {
	        throw new UsernameNotFoundException("해당 유저를 찾을 수 없습니다.");
	    } else if(user.getUserSt().equals("B")) {
	    	throw new AccountLockedException("활동이 정지된 회원입니다.");
	    }

	    return user;
	}

	// 관리자 대쉬보드
	public List<Map<String,Object>> adminUserBoard(Date today) {
		List<Map<String,Object>> listUser = uStore.adminUserBoard(today);
		return listUser;
	}
}
