<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>Index</title>
				 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
			<style>
				@keyframes scroll-animation{
				  0%{
				    left: 0;
				  }
				  100%{
				    left: -400px; /* 텍스트 width와 동일 */
				  }
				}
				.scroll-text{
				  width: 100%;
				  overflow: hidden;
				}
				.track{
				  position: relative;
				  width: 2800px;
				  animation: scroll-animation 10s linear infinite;
				}
				.track p{
				  float: left;
				  width: 400px;
				  font-size: 36px;
				}
			/* 경계선 */
				.line {
					border: 0.5px solid ;
					width: 1300px;
/* 					margin-left: 320px; */
					color: #DEDEDE;
					text-align: center;
				}
				.line2 {
					border: 0.5px solid ;
					width: 1100px;
/* 					margin-left: 360px; */
					color: #DEDEDE;
					text-align: center;
				}
			/* 아코디언 */
				.accordion-banner {
				    display: flex;
				    flex-direction: row;
				}
				
				.accordion-item {
				    flex: 1;
				    margin-right: 10px;
				    overflow: hidden;
				    transition: flex 0.5s ease;
				    position: relative;
				}
				
				.accordion-content {
				    background-color: #f0f0f0;
				    padding: 10px;
				    display: none;
				    position: absolute;
				    top: 0;
				    left: 100%;
				    height: 100%;
				}
				
				.accordion-item:hover {
				    flex: 3;
				}
				
				.accordion-item:hover .accordion-content {
				    display: block;
					}
				
			/* 동그라미 */
				#circle1 {
				  width : 400px;
				  height : 400px;
				  border-radius: 50%;
				  background-color: tomato;
				  position: absolute;
				
				}
				#circle2 {
				  width : 150px;
				  height : 150px;
				  border-radius: 50%;
				  background-color: tomato;
	
				
				}
				#circle3 {
				  width : 250px;
				  height : 250px;
				  border-radius: 50%;
				  background-color: tomato;
	
				
				}
				#circle4 {
				  width : 200px;
				  height : 200px;
				  border-radius: 50%;
				  background-color: tomato;
	
				
				}
				#square1 {
				    width: 250px;
				    height: 300px;
				    background-color: #ffd67a;
				}
				#square2 {
				    width: 250px;
				    height: 300px;
				    background-color: #ffd67a;
				}
				#square3 {
				    width: 250px;
				    height: 300px;
				    background-color: #ffd67a;
				}
				#square4 {
				    width: 250px;
				    height: 300px;
				    background-color: #ffd67a;
				}
			/* 리뷰 hover */
				.hover01 figure img {
					-webkit-transform: scale(1);
					transform: scale(1);
					-webkit-transition: .5s ease-in-out;
					transition: .5s ease-in-out;
				}
				.hover01 figure:hover img {
					-webkit-transform: scale(1.3);
					transform: scale(1.3);
				}
			/* 굿즈 */
				.cloud1 {
				    animation-name: cloud1;
				    animation-duration: 3.5s;
				    animation-iteration-count: infinite;
				    transition-timing-function: linear;
				}
				@keyframes cloud1 {
				    from {
				        transform: translateY(30px);
				    }
				    25% {
				        transform: translateY(-15px);
				    }
				    50% {
				        transform: translateY(15px);
				    }
				    75% {
				        transform: translateY(-15px);
				    }
				    to {
				        transform: translateY(30px);
				    }
				}
				.cloud2 {
				    animation-name: cloud2;
				    animation-duration: 2.5s;
				    animation-iteration-count: infinite;
				    transition-timing-function: linear;
				}
				@keyframes cloud2 {
				    from {
				        transform: translateY(30px);
				    }
				    25% {
				        transform: translateY(-15px);
				    }
				    50% {
				        transform: translateY(15px);
				    }
				    75% {
				        transform: translateY(-15px);
				    }
				    to {
				        transform: translateY(30px);
				    }
				}
				.cloud3 {
				    animation-name: cloud3;
				    animation-duration: 2s;
				    animation-iteration-count: infinite;
				    transition-timing-function: linear;
				}
				@keyframes cloud3 {
				    from {
				        transform: translateY(30px);
				    }
				    25% {
				        transform: translateY(-15px);
				    }
				    50% {
				        transform: translateY(15px);
				    }
				    75% {
				        transform: translateY(-15px);
				    }
				    to {
				        transform: translateY(30px);
				    }
				}
				.cloud4 {
				    animation-name: cloud4;
				    animation-duration: 3s;
				    animation-iteration-count: infinite;
				    transition-timing-function: linear;
				}
				@keyframes cloud4 {
				    from {
				        transform: translateY(30px);
				    }
				    25% {
				        transform: translateY(-15px);
				    }
				    50% {
				        transform: translateY(15px);
				    }
				    75% {
				        transform: translateY(-15px);
				    }
				    to {
				        transform: translateY(30px);
				    }
				}
					/* 로딩 화면 스타일 */
			        #loading-screen {
			            display: flex;
			            justify-content: center;
			            align-items: center;
			            position: fixed;
			            top: 0;
			            left: 0;
			            width: 100%;
			            height: 100%;
			            background-color: white;
			            z-index: 9999;
			        }
			</style>
			</head>

			<body>
				<!-- 로딩 화면 -->
<!-- 				    <div id="loading-screen"> -->
<!-- 				        <img alt="" src="../resources/dist/img/loading.gif" style="text-align: center; width: 250px; height: 250px; margin-left: 200px;"/> -->
<!-- 				        <br> -->
<!-- 				        <img src="../resources/dist/img/mainLogo.png" style="text-align: center; "/> -->
<!-- <!-- 				        <p style="margin-top: 700px; float: left; margin-left: -900px;">Loading...</p> --> -->
<!-- 				    </div> -->
<!-- 			<div id="main-content" style="display: none;"> -->
				<jsp:include page="./inc/header.jsp"></jsp:include>
				

		<div class="container">
				<!-- 배너 -->
				<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style=" z-index:1; margin-top: -155px;margin-top: -155px; width: 1900px; margin-left:-310px;">
				  <div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
				  </div>
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				      <img src="../resources/dist/img/slides-1.jpg" style="width: 100%; height: 700px;" alt="...">
				    </div>
				    <div class="carousel-item">
				      <img src="../resources/dist/img/slides-2.jpg"  style="width: 100%; height: 700px;" alt="...">
				    </div>
				    <div class="carousel-item">
				      <img src="../resources/dist/img/slides-3.jpg"  style="width: 100%; height: 700px;" alt="...">
				    </div>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
				
				
				<!-- 날씨배너 -->
				<div class="scroll-text" style="margin-top: 20px; ">
				  <div class="track">
				    <p>🎠오늘의 파크</p>
				    <p>운영시간</p>
				    <p>10:00~22:00 🎠</p>
				    <p>오늘의 날씨</p>
				    <p>⛅ 체감 15.7° 습도 47%</p>
				    <p>동풍 1.5m/s ⛅</p>  
				  </div>
				</div>
				
				<div class="line"></div>
				
		<!-- 아코디언 -->
		<div class="accordion-banner" style="margin-top: 30px; width: 1900px; margin-left: -300px;">
		    <div class="accordion-item">
		        <img src="../resources/dist/img/slides-3.jpg" alt="Image 1">
		        <div class="accordion-content">
		            <p>Content 1</p>
		        </div>
		    </div>
		    <div class="accordion-item">
		        <img src="../resources/dist/img/slides-3.jpg" alt="Image 2">
		        <div class="accordion-content">
		            <p>Content 2</p>
		        </div>
		    </div>
		    <div class="accordion-item">
		        <img src="../resources/dist/img/slides-3.jpg" alt="Image 3">
		        <div class="accordion-content">
		            <p>Content 3</p>
		        </div>
		    </div>
		    <div class="accordion-item">
		        <img src="../resources/dist/img/slides-3.jpg" alt="Image 4">
		        <div class="accordion-content">
		            <p>Content 4</p>
		        </div>
		    </div>
		</div>
<%-- 		<jsp:include page="./inc/footer.jsp"></jsp:include> --%>
		<script>
			function userLogin() {
				location.href="/user/login.ft";
			}
		</script>
		
		<div class="line" style="margin-top: 30px;"></div>
		
		<!-- 리뷰 -->
		
		<p style="text-align: center; margin-top: 100px; font-size: 50px;">페어리타운 <b>리뷰를 부탁해!</b></p>
		<p style="text-align: center; font-size: 20px; color: #999999;">생생한 리뷰로 체험하는 페어리타운</p>
		
		<div class="hover01" style="margin-left: -300px;">
		<figure>
		<img src="../resources/dist/img/slides-2.jpg" style="width: 300px; height: 300px; margin-left: 440px; margin-top: 40px;">
		</figure>
		<figure>
		<img src="../resources/dist/img/slides-2.jpg" style="width: 300px; height: 300px; margin-left: 790px; margin-top: -360px;">
		</figure>
		<figure>
		<img src="../resources/dist/img/slides-2.jpg" style="width: 300px; height: 300px; margin-left: 1140px; margin-top: -440px;">
		</figure>
		<figure>
		<img src="../resources/dist/img/slides-2.jpg" style="width: 300px; height: 300px; margin-left: 440px; margin-top: -30px;">
		</figure>
		<figure>
		<img src="../resources/dist/img/slides-2.jpg" style="width: 300px; height: 300px; margin-left: 790px; margin-top: -360px;">
		</figure>
		<figure>
		<img src="../resources/dist/img/slides-2.jpg" style="width: 300px; height: 300px; margin-left: 1140px; margin-top: -440px;">
		</figure>
		</div>
		<button style="margin-top: 0px; margin-left: 530px; width: 200px; height: 50px; border-radius: 30px;" onclick="review/list.ft">리뷰 더 보러가기</button>
		
		<div class="line" style="margin-top: 100px;"></div>
		
		<div style="margin-left: -300px;">
		<div id="circle1" class="cloud1" style="margin-left: 400px; margin-top: 150px;"></div>
		<div id="circle2" class="cloud2" style="margin-left: 320px; margin-top: 180px;"></div>
		<div id="circle3" class="cloud3" style="margin-left: 750px; margin-top: -200px;"></div>
		<div id="circle4" class="cloud4" style="margin-left: 800px; margin-top: 250px;"></div>
		</div>
		
		<div style="margin-left: -240px;">
		<div id="square1" style="margin-left: 1050px; margin-top: -700px;"></div>
		<p style="margin-left: 1060px; margin-top: 20px;">안녕</p>
		<p style="margin-left: 1060px; margin-top: 20px;">안녕</p>
		<div id="square2" style="margin-left: 1340px; margin-top: -403px;"></div>
		<p style="margin-left: 1350px; margin-top: 20px;">안녕</p>
		<p style="margin-left: 1350px; margin-top: 20px;">안녕</p>
		<div id="square4" style="margin-left: 1050px; margin-top: 20px;"></div>
		<p style="margin-left: 1060px; margin-top: 20px;">안녕</p>
		<p style="margin-left: 1060px; margin-top: 20px;">안녕</p>
		<div id="square3" style="margin-left: 1340px; margin-top: -405px;"></div>
		<p style="margin-left: 1350px; margin-top: 20px;">안녕</p>
		<p style="margin-left: 1350px; margin-top: 20px;">안녕</p>
		</div>
		<div class="line" style="margin-top: 130px;"></div>
														
			<br><br><br><br>
<!-- 				<div class="container"> -->
<%-- 					${userId } --%>
<%-- 				<c:if test="${userId eq null }"> --%>
<!-- 					<form action="/user/login.ft" method="post" name="loginForm"> -->
<!-- 						<input type="text" name="userId" placeholder="ID를 입력하세요"> -->
<!-- 						<input type="password" name="userPw"  placeholder="PW를 입력하세요"> -->
<!-- 						<input type="submit" name="login" value="login"> -->
<!-- 					</form> -->
<%-- 				</c:if> --%>
<%-- 				<c:if test="${userId ne null }"> --%>
<!-- 						<button type="button" onclick="userLogout();">로그아웃</button>				 -->
<%-- 				</c:if> --%>
<!-- 				</div> -->
				<div class="line2" style="margin-top: -50px; margin-left: 100px;"></div>
				
			<script>
		        // 페이지 로드 후 실행될 코드
		        window.addEventListener('load', function () {
		            // 일정 시간(여기서는 3초) 후에 메인 페이지 표시
		            setTimeout(function () {
		                // 로딩 화면 숨기기
		                document.getElementById('loading-screen').style.display = 'none';
		                // 메인 페이지 표시
		                document.getElementById('main-content').style.display = 'block';
		            }, 3000); // 3초 후에 메인 페이지 표시
		        });
		    </script>
				<!-- 공통 / 풋터 -->
			<jsp:include page="./inc/footer.jsp"></jsp:include>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		</div>
	</body>

</html>