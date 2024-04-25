<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 상세 조회</title>
</head>
<body>
	<h2>블랙리스트 회원 정보</h2>
	<ul>
		<li>
			<label>아이디</label>
			${blackList.userId}
		</li>
		<li>
			<label>정지일</label>
			${blackList.regiDate}
		</li>
		<li>
			<label>정지 종료일</label>
			${blackList.stopDate}
		</li>
		<li>
			<label>정지 사유</label>
			${blackList.reason}
		</li>
	</ul>
	<a href="javascript:void(0);" onclick="window.close();">닫기</a>
</body>
</html>