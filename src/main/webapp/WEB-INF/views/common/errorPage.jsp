<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<style>
div{margin-left:43%;
	margin-top:10%;}
</style>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<div class="msgbox">
			<h1>어? 이상한데?</h1>
			<h2 style="color:red;">나가</h2>
			<h3>오류가 발생하였습니다.${msg }</h3>
			<h1><a href="goBack();">뒤로가기</a></h1>
		</div>
		
		<script>
		function goBack(){
			history.back();
		}
		</script>

	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>