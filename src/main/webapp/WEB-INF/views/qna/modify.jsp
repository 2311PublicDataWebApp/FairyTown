<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
		<form action="/qna/modify.ft" method="post" enctype="multipart/form-data">
			<input type="hidden" name="qnaNo" value="${qna.qnaNo }">
		<table> 
		    <tr><td><h2>문의수정</h2></td></tr>
		    <tr><td class="header">제목</td></tr>
		    <tr><td><input type="text" name="qnaName" value="${qna.qnaName }"></td></tr>
		    <tr><td class="header">${qna.qnaWriter}</td></tr>
		    <tr><td class="header">내용</td></tr>
		    <tr><td><textarea rows="4" cols="51" name="qnaContent">${qna.qnaContent }</textarea></td></tr>
		    <tr><td><label>상태</label>
					<span>${qna.qnaStatus }</span></td></tr>
			<tr>
			    <td>
			        <select name="qnaStatus" style="display: none;">
			            <option value="처리 중">답변대기</option>
			            <option value="답변 완료">답변 완료</option>
			            <!-- 다른 상태 옵션들을 추가 -->
			        </select>
			    </td>
			</tr>
		    <tr><td><input type="submit" value="등록하기" onclick="alert('수정 완료!')"></td></tr>
		</table>
		</form>
		<script type="text/javascript">
			function showQnaList() {
				location.href = "/qna/list.ft";
			}
			
			function deleteQna(qnaNo) {
				if (confirm("삭제하시겠습니까?")) {
					location.href = "/qna/delete.ft?qnaNo=" + qnaNo;
				}
			}
		</script>
	</body>
</html>