<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>regist</title>
		<style>
		    /* 팝업 스타일 */
		    .popup {
		        display: none; /* 기본적으로는 숨겨진 상태 */
		        position: fixed; /* 화면 고정 */
		        top: 50%; /* 화면 중앙에 위치 */
		        left: 50%;
		        transform: translate(-50%, -50%);
		        z-index: 9999; /* 다른 요소들보다 위에 나타나도록 설정 */
		        background-color: white;
		        border: 1px solid #ccc;
		        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
		        width: 70%; /* 팝업의 너비 */
		        max-width: 600px;
		    }
		
		    .popup-content {
		        padding: 20px;
		    }
		
		    .popup-header {
		        border-bottom: 1px solid #ccc;
		        padding-bottom: 10px;
		        margin-bottom: 10px;
		        position: relative;
		    }
		
		    .popup-title {
		        margin: 0;
		    }
		
		    .close {
		        position: absolute;
		        top: 10px;
		        right: 10px;
		        cursor: pointer;
		    }
		
		    .popup-body {
		        /* 팝업 바디 스타일 */
		    }
		
		    .popup-footer {
		        text-align: right;
		    }
		</style>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
	
	
	
	<div id="container">
		<h1><b>블랙리스트</b></h1>
		<br><br><br>
		<table class="table table-hover">
		    <thead>
		        <tr>
		            <th>아이디</th>
		            <th>이름</th>
		            <th>휴대폰번호</th>
		            <th>등록일자<th>
		            <th>해제일자</th>
		            <th>상태</th>
		            <th>회원탈퇴</th>
		            <!-- 필요한 만큼 열을 추가 -->
		        </tr>
		    </thead>
		    <tbody>
		    	<c:choose>
					<c:when test="${fn:length(bList) !=0 }">
						<c:forEach items="${bList }" var="user" varStatus="i">
		        <tr>
		            <td>${user.userId }</td>
		            <td>${user.uName }</td>
		            <td>데이터 1-3</td>
		            <td>데이터 1-3</td>
		            <td>데이터 1-3</td>
		            <td>데이터 1-3</td>
		            <td>데이터 1-3</td>
		        </tr>
		        		</c:forEach>
		     	  </c:when>
					<c:otherwise>
						<td class="" colspan="7">
							<p class="nullmsg" style="width:30%; margin:0 auto; padding-top:50px;padding-bottom:50px;">
								등록된 게시물이 없습니다.<br>
							</p>
					</c:otherwise>
				</c:choose>
		    </tbody>
		</table>
		
	</div>
	
<%-- 	<!-- 팝업창 내용 -->
	<c:forEach items="${uList }" var="user" varStatus="i">    
	    <div class="popup" id="popupDialogScrollable${i.count }">
	        <div class="popup-content">
	            <div class="popup-header">
	                <h5 class="popup-title">[회원 상세정보]</h5>
	                <span class="close" onclick="closePopup(${i.count })">&times;</span>
	            </div>
	            <div class="popup-body">
	                <table class="table table-striped">
	                    <tbody>
	                        <tr>
	                            <td style="width:230px">아이디</td>
	                            <td>${user.userId }</td>
	                        </tr>
	                        <tr>
	                            <td>이름</td>
	                            <td>${user.userName }</td>
	                        </tr>
	                        <tr>
	                            <td>휴대폰번호</td>
	                            <td>${user.userPhone}</td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
	            <div class="popup-footer">
	                <input type="reset" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" value="확인" onclick="closePopup(${i.count })"/>
	            </div>
	        </div>
	    </div>
	</c:forEach> --%>
	<!-- 팝업창 내용 끝 -->
	
	<script>
    // 팝업 닫기 함수
/*     function closePopup(count) {
        var popup = document.getElementById("popupDialogScrollable" + count);
        popup.style.display = "none"; // 팝업 숨기기
    } */
	</script>
	
	
		<!-- BootStrap -->
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>	
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</body>
</html>