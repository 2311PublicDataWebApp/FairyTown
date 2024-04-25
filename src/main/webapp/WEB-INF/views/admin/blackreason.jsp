<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>블랙리스트 등록</h2>
	<form action="/admin/blackRegister.ft" method="post">
	<input type="hidden" id="blackUsersInput" name="blackUsers" value="">
		<ul>
			<li>
				<label>정지 처리</label>
				<select name="stopDate">
					<option value="1">1개월</option>
					<option value="3">3개월</option>
					<option value="6">6개월</option>
					<option value="0">영구정지</option>
				</select>
			</li>
			<li>
				<label>정지 사유</label>
				<textarea rows="5" cols="20" name="reason"></textarea>
			</li>
		</ul>
		<input type="submit" value="등록">
		<a href="javascript:void(0);" onclick="window.close();">취소</a>
	</form>
	<script>
        // JavaScript를 사용하여 blackUsersInput의 값을 동적으로 설정
        var urlParams = new URLSearchParams(window.location.search);
        var blackUsersValue = urlParams.get('blackUsers');
        if (blackUsersValue !== null) {
            document.getElementById("blackUsersInput").value = blackUsersValue;
        } else {
            // blackUsers 매개변수가 없는 경우에 대한 처리
            console.log("blackUsers 매개변수가 없습니다.");
        }
        
        var closeWindow = "<c:out value='${closeWindow}'/>";
        if(closeWindow === 'null' || closeWindow === ''){
            closeWindow = 'false';
        }
        if (closeWindow === 'true') {
            window.close();
        }
    </script>
</body>
</html>