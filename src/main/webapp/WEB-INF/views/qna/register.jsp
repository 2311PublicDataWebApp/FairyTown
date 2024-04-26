<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>1대1 문의 글쓰기</title>
		<link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUITE/fonts/static/woff2/SUITE.css" rel="stylesheet">
		<style type="text/css">
			body {
	            font-family: 'SUITE', sans-serif;
	            }
			table {
    				margin: auto;
				}
				input[type="text"] {
				    border: 1.5px rgb(68, 136, 244) solid;
				    width: 500px;
				    height: 30px;
				    border-radius: 5px;
				    padding-left: 10px;
				}
				textarea {
				    border: 1.5px rgb(68, 136, 244) solid;
				    width: 500px;
				    height: 400px;
				    border-radius: 5px;
				    padding-left: 10px;
				    padding-top: 10px;
				    resize: none;
				}
				.header {
				    height: 30px;
				}
				input[type="submit"] {
				    width: 100px;
				    height: 40px;
				    font-size: 15px;
				    border: 0;
				    outline: 1.5px rgb(68, 136, 244) solid;
				    border-radius: 5px;
				    padding-left: 10px;
				    background-color: rgb(164, 199, 255);
				}
				input[type="submit"]:active {
				    width: 100px;
				    height: 40px;
				    font-size: 15px;
				    border: 0;
				    border-radius: 5px;
				    outline: 1.5px rgb(27, 76, 155) solid;
				    padding-left: 10px;
				    background-color: rgb(68, 136, 244);
				}
		</style>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<c:choose>
	   		 <c:when test="${sessionScope.user != null}">
	        <!-- 사용자가 로그인한 경우에는 문의 작성 폼을 보여줍니다. -->
				<form action="/qna/insert.ft" method="post" enctype="multipart/form-data">
				<table> 
				    <tr><td><h2>문의하기</h2></td></tr>
				    <tr><td class="header">제목</td></tr>
				    <tr><td><input type="text" placeholder="제목을 입력하세요" name="qnaName" value="${qna.qnaName }"></td></tr>
				    <tr><td class="header">${sessionScope.user.userId}</td></tr>
				    <tr><td class="header">내용</td></tr>
				    <tr><td><textarea placeholder="내용을 입력하세요" name="qnaContent" value="${qna.qnaContent }"></textarea></td></tr>
				    <tr><td><input type="submit" value="등록하기" onclick="alert('작성 완료!')"></td></tr>
				</table>
				</form>
			</c:when>
			 <c:otherwise>
			        <!-- 사용자가 로그인하지 않은 경우에는 로그인이 필요합니다 메시지를 alert 형태로 보여줍니다. -->
			        <script>
			            alert("로그인이 필요합니다.");
			            window.location.href = "/user/login.ft"; // 로그인 페이지로 이동합니다.
			        </script>
			    </c:otherwise>
		</c:choose>

		
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</body>
</html>