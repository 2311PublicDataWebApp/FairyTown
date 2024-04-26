<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>놀이기구</title>
<link rel="stylesheet" type="text/css" href="../resources/css/ride.css">
</head>
<body>
    <!-- 공통 / 헤더 -->
    <jsp:include page="../inc/header.jsp"></jsp:include>
    <div class="all_list">
        <!--  타이틀 영역 -->
        <div class="title">
            <table class="title_tbl">
                <tr>
                    <td class="titleFirst"><h2>놀이기구</h2></td>
                </tr>
            </table>
        </div>

        <!-- 컨텐츠 영역 -->
        <div class="content_top">
            <p class="title_rotate">대표!</p>
            <div class="imgbox">
                <c:forEach var="ride" items="${rlist}" varStatus="loop">
                    <c:if test="${loop.index lt 3}">
                        <div class="img_second">
                            <a href="/ride/detail.ft?rideId=${ride.rideId }"> 
                                <img src="../resources/nuploadFiles/${ride.images[0].rideImgRename}" style="width: 264px; height: 363px;" alt="이미지">
                                    <p class="hover">${ride.rideName }</p>
                            </a>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <hr style="margin:8rem 3rem 4rem 22rem; width:58%;">
        <h4>전체 놀이기구</h4>
        <!-- 목록 영역 -->
        <div class="content_mid">
            <div class="content_item_box">
                <table>
                    <tr>
                        <td>
                            <c:forEach var="ride" items="${thumbL}" varStatus="loop">
                                <c:if test="${loop.index lt 3}">
                                    <div class="img_first">
                                        <a href="/ride/detail.ft?rideId=${ride.rideId }"> 
                                            <img src="../resources/nuploadFiles/${ride.images[0].rideImgRename}" style="width: 264px; height: 180px;" alt="이미지">
                                            <div class="hover">
                                                <p>${ride.rideName }</p>
                                            </div>
                                        </a>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <c:forEach var="ride" items="${thumbL}" varStatus="loop">
                                <c:if test="${loop.index ge 3 and loop.index lt 6}">
                                    <div class="img_second">
                                        <a href="/ride/detail.ft?rideId=${ride.rideId }"> 
                                            <img src="../resources/nuploadFiles/${ride.images[0].rideImgRename}" style="width: 264px; height: 180px;" alt="이미지">
                                            <div class="hover">
                                                <p>${ride.rideName }</p>
                                            </div>
                                        </a>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="categories_more">
            <a href="#">Load More</a>
        </div>
    </div>
    <!-- 공통 / 풋터 -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>