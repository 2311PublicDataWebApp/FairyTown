<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
	</head>
	<body>
		<form action="/user/register.ft" method="post">
			<h1>회원가입</h1>	
			<ul>
				<li>
					<label>이름</label>
					<input type="text" name="userName">
				</li>
				<li>
					<label>아이디</label>
					<input type="text" name="userName">
				</li>
				<li>
					<label>비밀번호</label>
					<input type="text" name="userName">
				</li>
				<li>
					<label>비밀번호 확인</label>
					<input type="text" name="userName">
				</li>
				<li>
					<label>전화번호</label>
					<input type="text" name="userName">
				</li>
				<li>
					<label>우편번호</label>
					<input type="text" id="sample6_postcode" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<span id="guide" style="color:#999;display:none"></span>
				</li>
				<li>
					<label>주소</label>
					<input type="text" id="sample6_address" placeholder="도로명주소">
				</li>
				<li>
					<label>상세주소</label>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" placeholder="참고항목">	
				</li>
				<li>
					<label>생년월일</label>
					<input type="date">
				</li>
				<li>
					<label for="email">이메일</label>
					<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
					<select class="form-control" name="userEmail2" id="userEmail2" >
					<option>@naver.com</option>
					<option>@daum.net</option>
					<option>@gmail.com</option>
					<option>@hanmail.com</option>
					<option>@yahoo.co.kr</option>
					</select>
					<button type="button" class="btn btn-primary" id="mail-Check-Btn">인증번호 전송</button>
				</li>
				<li>
					<label>인증번호</label>
					<input class="form-control mail-check-input" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
					<button type="button" class="btn btn-success" id="verify-Code-Btn" disabled="disabled">인증번호 확인</button>
				</li>
			</ul>	
			<input type="submit" value="회원가입" id="signup-btn" disabled="true">
		</form>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
			//이메일 인증 기능
			document.getElementById("mail-Check-Btn").onclick = function() {
			    var emailPart1 = document.getElementById("userEmail1").value;
			    var emailPart2 = document.getElementById("userEmail2").value;
			    var completeEmail = emailPart1 + emailPart2; // 이메일 주소 조합 시 @ 기호가 필요합니다.
			    
			    // AJAX 요청을 사용하여 백엔드에 이메일 주소 전송
			    fetch('/verify/email.ft', {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/json',
			        },
			        body: JSON.stringify({ email: completeEmail }),
			    })
			    .then(response => response.json())
			    .then(data => {
			        console.log('Success:'+ data);
			        // 성공적으로 이메일을 전송했다면, 사용자에게 이메일을 확인하라는 안내와 함께 인증번호 입력 필드를 활성화
			        alert(data.message); // 백엔드에서 보낸 메시지를 사용자에게 표시
			        document.querySelector(".mail-check-input").disabled = false;
			        document.getElementById("verify-Code-Btn").disabled = false;
			    })
			    .catch((error) => {
			        console.error('Error:', error);
			        alert('이메일 전송에 실패했습니다. 다시 시도해주세요.');
			    });
			};
	
			// 인증번호 확인 기능
			document.getElementById("verify-Code-Btn").onclick = function() {
			    var verificationCode = document.querySelector(".mail-check-input").value;
			    var emailPart1 = document.getElementById("userEmail1").value;
			    var emailPart2 = document.getElementById("userEmail2").value;
			    var completeEmail = emailPart1 + emailPart2; // 이메일 주소 조합 시 @ 기호를 추가합니다.
	
			    // AJAX 요청을 사용하여 백엔드에 인증번호 검증 요청
			    fetch('/verify/code.ft', {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/json',
			        },
			        body: JSON.stringify({ email: completeEmail, verificationCode: verificationCode }),
			    })
			    .then(response => response.json())
			    .then(data => {
			        if(data.ok) { // HTTP 상태 코드가 200-299인 경우
			        	$("#signup-btn").attr("disabled", false);
			            alert('인증에 성공하였습니다.');
			         // 인증 성공 시 회원가입 버튼을 활성화
			            
			        } else {
			            alert(data.message); // 백엔드에서 보낸 오류 메시지를 사용자에게 표시
			        }
			    })
			    .catch((error) => {
			        console.error('Error:', error);
			        alert('인증번호 검증에 실패했습니다. 다시 시도해주세요.');
			    });
			};
		    
			//주소API
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script>
	</body>
</html>