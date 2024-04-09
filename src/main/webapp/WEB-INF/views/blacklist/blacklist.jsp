<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>블랙리스트</title>
	
	<!-- Font Awesome icons (free version)-->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
		crossorigin="anonymous"></script>
	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
		rel="stylesheet" type="text/css" />
	<link
		href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
		rel="stylesheet" type="text/css" />
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		crossorigin="anonymous">
	<!-- Custom styles for this template -->
	<link
		href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap"
		rel="stylesheet">
	
	<style>
	#mainNav {
		background-color: black; /* 초기값으로 되돌립니다. */
	}
	
	#total-count-box {
		margin-left: 5%;
		width: 230px;
		background-color: #e9e9e9;
	}
	</style>
	</head>
	<body id="page-top" class="sb-nav-fixed">
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<br> <br> <br> <br> <br>
					<div id="total-count-box" style="font-size: 0.9rem;" >
				    	<h3><i class="fa-solid fa-users" ></i> 총 블랙리스트 수 : ${totalCount} 명</h3>
					</div>
					<h1 class="mt-4">블랙리스트 관리</h1>
					<div class="card mb-4"></div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-user me-1"></i> 블랙리스트 조회
						</div>
						<div class="card-body">
							<table id="xxxx">
								<thead>
									<tr>
										<th>이름</th>
										<th>회원 아이디</th>
										<th>이메일</th>
										<th>등록일자</th>
										<th>상태</th>
										<th>사유</th>
										<th>종료일자</th>
										<th>추방하기</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>이름</th>
										<th>회원 아이디</th>
										<th>이메일</th>
										<th>등록일자</th>
										<th>상태</th>
										<th>사유</th>
										<th>종료일자</th>
										<th>추방하기</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${mList}" var="black">
										<tr>
											<td>${member.memberId}</td>
											<td>${member.memberName}</td>
											<td>${member.memberPhone}</td>
											<td>${member.memberEmail}</td>
											<td>${member.memberDate }</td>
											<td>
								    <%-- <c:choose>
									    <c:when test="${member.blackList == 'Y'}">
									        <button id="blacklistBtn_${member.memberId}" 
									        	style="width: 50%; background-color: black; color: white;" 
									        	onclick="toggleBlacklist('${member.memberId}', 'N')">블랙</button>
									    </c:when>
									    <c:otherwise>
									        <button id="blacklistBtn_${member.memberId}" 
									        	style="width: 50%; background-color: white; color: black;" 
									        	onclick="toggleBlacklist('${member.memberId}', 'Y')">정상</button>
									    </c:otherwise>
									</c:choose> --%>
									<c:choose>
									    <c:when test="${member.blackList == 'Y'}">
									        <button id="blacklistBtn_${member.memberId}" 
									            style="width: 50%; background-color: black; color: white;" 
									            onclick="toggleBlacklist('${member.memberId}', 'N')">블랙</button>
									    </c:when>
									    <c:otherwise>
									        <button id="blacklistBtn_${member.memberId}" 
									            style="width: 50%; background-color: white; color: black;" 
									            onclick="toggleBlacklist('${member.memberId}', 'Y')">정상</button>
									    </c:otherwise>
									</c:choose>
										</td>
											<td><a href="/member/update?memberId=${member.memberId}"><button
												style="width: 50%; background-color: white; color: #black;">수정</button></a></td>
											<td><a href="/member/delete?memberId=${member.memberId}"><button
												style="width: 50%; background-color: white; color: #black;">삭제</button></a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
		</div>

	<!-- jQuery Ajax -->		
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>	
	<script>
	
	
	function toggleBlacklist(memberId, newStatus) {
	    // Ajax 요청을 보내어 블랙리스트 상태를 서버에 전달 및 업데이트 요청
	    $.ajax({
	        type: "POST", // POST 방식으로 요청
	        url: "/toggleBlacklist", // 서버의 해당 URL에 요청을 보냄
	        data: JSON.stringify({ memberId: memberId, newStatus: newStatus === 'Y' }), // memberId와 newStatus를 JSON 형태로 변환하여 요청 데이터로 전달
	        contentType: "application/json", // 요청 데이터 타입 지정
	        dataType: "json", // 응답 데이터 타입으로 JSON을 기대
	        success: function(response) {
	            // 서버에서 성공적으로 응답을 받았을 때 실행되는 함수
	            // 서버로부터 받은 응답을 이용하여 UI 업데이트 등의 동작을 수행
	            if (response.success) {
	                // 서버가 성공적인 응답을 보냈을 때 처리하는 부분
	                if (response.newStatus) {
	                    // 블랙리스트 상태가 'Y'인 경우 버튼 스타일을 변경하고 텍스트를 '블랙'으로 설정
	                    $("#blacklistBtn_" + memberId).css("background-color", "black").css("color", "white").text("블랙");
	                    $("#blacklistBtn_" + memberId).attr("onclick", "toggleBlacklist('"+memberId+"', 'N')");
	                } else {
	                    // 블랙리스트 상태가 'Y'가 아닌 경우 버튼 스타일을 변경하고 텍스트를 '정상'으로 설정
	                    $("#blacklistBtn_" + memberId).css("background-color", "white").css("color", "black").text("정상");
	                    $("#blacklistBtn_" + memberId).attr("onclick", "toggleBlacklist('"+memberId+"', 'Y')");
	                }
	            } else {
	                // 서버가 실패 응답을 보냈을 때 처리하는 부분
	                console.error("Server returned error message: " + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            // 요청이 실패했을 때 실행되는 함수
	            console.error("Error: " + error); // 콘솔에 에러 메시지 출력
	        }
	    });
	}

	</script>
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>