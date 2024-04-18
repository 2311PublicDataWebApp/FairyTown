<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>놀이기구</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<!--  타이틀 영역 -->
			<div class="Title">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>놀이기구</h2></td> 
					</tr>
					<tr>
						<td class="titleSecond"><h4>놀이기구 목록</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<!-- 목록 영역 -->
				<table class="table_ride_list"> 
									
						<tr>
							<td></td>
							<td>{}</td>
							<td>{}</td>
						</tr>
								<tr>
									<td class="list_fifth_td" colspan="3">
										<p class="nullmsg_list">
											등록된 놀이기구가 없습니다.<br>
										</p>
										<input type="button" name="showMain" onClick="showMain();" value="구경하러 가기">
									</td>
								</tr>
				</table>
			</div>
	<script>
		
		//놀이기구 페이지 사용 JS : showMain()
			function showMain() {
		        location.href = "/";
		    }	
	</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>