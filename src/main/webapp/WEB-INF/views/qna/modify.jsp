<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>문의 수정</h1>
		<form action="/qna/modify.ft" method="post" enctype="multipart/form-data">
			<input type="hidden" name="qnaNo" value="${qna.qnaNo }">
			<ul>
				<li>
					<label>제목</label>
					<input type="text" name="qnaName" value="${qna.qnaName }">
				</li>
				<li>
					<label>작성자</label>
					<span>${qna.qnaWriter }</span>
				</li>
				<li>
					<label>내용</label>
					<textarea rows="4" cols="51" name="qnaContent">${qna.qnaContent }</textarea>
				</li>
				<li>
					<label>상태</label>
					<span>${qna.qnaStatus }</span>
				</li>
			</ul>
			<br><br>
			<div>
				<input type="submit" value="등록하기">
				<button type="button" onclick="showQnaList();">목록으로 이동하기</button>
			</div>
		</form>
		<script type="text/javascript">
			function showQnaList() {
				location.href = "/qna/list.ft";
			}
		</script>
	</body>
</html>