<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>1대1 문의 글쓰기</title>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
			<h1>문의 작성</h1>
		<form action="/qna/insert.ft" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label>제목</label>
					<input type="text" name="qnaName">
				</li>
				<li>
					<label>작성자</label>
					<input type="text" name="qnaWriter">
				</li>
				<li>
					<label>내용</label>
					<textarea rows="4" cols="51" name="qnaContent"></textarea>
				</li>
			</ul>
			<div>
				<input type="submit" value="등록하기">
			</div>
		</form>
		
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</body>
</html>