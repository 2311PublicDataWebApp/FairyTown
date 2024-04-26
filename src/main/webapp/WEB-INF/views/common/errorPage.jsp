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
.msgbox{
margin-bottom:10%;
}
</style>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<div class="msgbox">
			<h4 style="text-align:center;">오류가 발생하였습니다!</h4>
			<h6 style="text-align:center;"><br>Error Message: ${msg }</h6><br>
			<h4 style="text-align:center;"><input type="reset" class="btn btn-secondary"value="뒤로가기" onClick="goBack();"></h4>
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