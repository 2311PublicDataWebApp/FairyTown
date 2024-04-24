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

        <form action="/ride/detail.ft" method="post" name="rideForm">
     	<input type="hidden" name="rideId" value="${rList.rideId}">
		<input type="hidden" name="rideName" value="${rList.rideName}">
		<input type="hidden" name="rideDescription" value="${rList.rideDescription}">
		<input type="hidden" name="rideCount" value="${rList.rideCount}">
		<input type="hidden" name="rideStatus" value="${rList.rideStatus}">
		<input type="hidden" name="rideLimit" value="${rList.rideLimit}">


        <!-- 타이틀 영역 -->
            <div class="Title">
                <table class="title_tbl">
                    <tr>
                        <td class="titleFirst"><h2>놀이기구</h2></td>
                    </tr>
                    <tr>
                        <td class="titleSecond"><h4>놀이기구 상세</h4></td>
                    </tr>
                </table>
            </div>

        <!-- 컨텐츠 영역 -->
            <div class="content">
                <table class="table_ride">
				 <tr>
				    <td>놀이기구명＊ : </td>
				    <td>
				        <span>${rList.rideName }</span>
				    </td>
				</tr>
				<tr>
				    <td>놀이기구설명 : </td>
				    <td><span>${rList.rideDescription }</span>
				    </td>
				</tr>
				<tr>
				    <td>탑승인원 : </td>
				    <td>
				        <span>${rList.rideCount }</span>
				    </td>
				</tr>
				<tr>
				    <td>휴무여부 : </td>
				    <td>
				        <span>${rList.rideStatus}</span>
				    </td>
				</tr>
				<tr>
				    <td>탑승 제한 : </td>
				    <td>
				        <span>${rList.rideLimit}</span>
				    </td>
				</tr>

                    <tr>
                        <td>이미지 : </td>
                        <td>
                        <c:forEach var="rImg" items="${rImg}">
                             <img src="../resources/nuploadFiles/${rImg.rideImgRename}" style="width:100px; height:100px;" alt="이미지">
                           </c:forEach><br>
                        </td>
                    </tr>


                    <tr>
                        <td colspan="5">
                            <input type="reset" value="이전으로" onClick="goBack();">
                            <button type="submit">예약하기</button>
                        </td>
                    </tr>
                </table>
            </div>
        </form> 

        <script>
        //상세 페이지 사용 JS : goBack()

            function goBack() {
                history.back();
            }

            function showBooking(rideId){
                location.href = "/booking/basic.ft";
            }




        </script>
    <!-- 공통 / 풋터 -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>