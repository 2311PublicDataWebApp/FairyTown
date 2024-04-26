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
			.wrap {
				    position: absolute;
				    left: 0;
				    bottom: 40px;
				    width: 288px;
				    height: 132px;
				    margin-left: -144px;
				    text-align: left;
				    overflow: hidden;
				    font-size: 12px;
				    font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
				    line-height: 1.5;
				}
				.info .close {
				    position: absolute;
				    top: 10px;
				    right: 10px;
				    color: #888;
				    width: 17px;
				    height: 17px;
				    background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png);
				}
				.info .title {
				    padding: 5px 0 0 10px;
				    height: 30px;
				    background: #eee;
				    border-bottom: 1px solid #ddd;
				    font-size: 18px;
				    font-weight: bold;
				}
				.info .body {
				    position: relative;
				    overflow: hidden;
				}
				.info .img {
				    position: absolute;
				    top: 6px;
				    left: 5px;
				    width: 73px;
				    height: 71px;
				    border: 1px solid #ddd;
				    color: #888;
				    overflow: hidden;
				}
				.info .desc {
				    position: relative;
				    margin: 13px 0 0 90px;
				    height: 75px;
				}
				.desc .ellipsis {
				    overflow: hidden;
				    text-overflow: ellipsis;
				    white-space: nowrap;
				}
				.desc .jibun {
					overflow: hidden;
					text-overflow: ellipsis;
				    font-size: 11px;
				    color: #888;
				    margin-top: -2px;
				}
			/*스크롤 애니메이션 */
			.flow-container {
			    overflow : hidden;
			}
			.flow-text {
				  display: flex;
			      flex: 0 0 auto;
			      white-space: nowrap;
			      overflow: hidden;
			      transition: 0.3s;
			      font-size: 1.5rem;
			      font-weight:bold;
			      color: #9D9993;
				  width: 2400px;
				  margin-top: 20px;
			  }
			  .flow-text:hover {
			    color: #000;
			  }
			  .flow-text:hover .flow-wrap {
			    animation-play-state: paused;
			    cursor: pointer;
			  }
			  .flow-wrap {
			    animation: textLoop 20s linear infinite;
			    width : 80vw;
/* 			    padding-right: 1.4881vw; */
			  }
			  
			  @keyframes textLoop {
			    0% {
			      -webkit-transform: translate3d(0, 0, 0);
			      transform: translate3d(0, 0, 0);
			    }
			    100% {
			      -webkit-transform: translate3d(-100%, 0, 0);
			      transform: translate3d(-100%, 0, 0);
			    }
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
				
				.accordion-item img {
				    width: 100%;
				    height: 100%;
				    object-fit: cover; /* 이미지가 부모 요소에 가득 차도록 설정 */
				    transition: transform 0.5s ease; /* 이미지 확대를 위한 트랜지션 설정 */
				}
				
				.accordion-item:hover {
				    flex: 3; /* hover 시 요소 크기 확대 */
				}
				
				.accordion-item:hover img {
				    transform: scale(1.1); /* hover 시 이미지 확대 */
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
					-webkit-transition: .3s ease-in-out;
					transition: .3s ease-in-out;
				}
				.hover01 figure:hover img {
					-webkit-transform: scale(1.1);
					transform: scale(1.1);
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
			        
					/*둥둥 사진 */
						.image-0 {
						     width : 400px;
							 height : 400px;
							 border-radius: 70%;
							 position: absolute;
							 animation-name: cloud1;
						     animation-duration: 3.5s;
						     animation-iteration-count: infinite;
						     transition-timing-function: linear;
						     margin-top: 180px; 
    						 margin-left: 100px; 
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
					
					.image-1 {
						animation-name: cloud2;
					    animation-duration: 2.5s;
					    animation-iteration-count: infinite;
					    transition-timing-function: linear;
					    width : 150px;
						height : 150px;
						border-radius: 70%;
 						margin-top: 50px; 

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
				
					.image-2 {
						width : 250px;
						height : 250px;
						border-radius: 70%;
						animation-name: cloud3;
					    animation-duration: 2s;
					    animation-iteration-count: infinite;
					    transition-timing-function: linear;
 					    margin-left: 300px; 
 					    margin-top: 50px; 
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
					
					.image-3 {
						width : 200px;
						height : 200px;
						border-radius: 70%;
						animation-name: cloud4;
					    animation-duration: 3s;
					    animation-iteration-count: infinite;
					    transition-timing-function: linear;
					    margin-top: 520px; 
 					    margin-left: -280px; 
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
					
					.cat-0{
						margin-left: 900px;
					}
					
					.cat-1 {
						margin-left: 900px; 
					}
					
					.cat-2 {
 						margin-left: 900px; 
					}
					
					.cat-3 {
 						margin-left: 900px; 
					}
					
					*, ::after, ::before {
					    box-sizing: border-box;
					}
					user agent stylesheet
					div {
					    display: block;
					    unicode-bidi: isolate;
					}
					.ribbon-wrapper.ribbon-lg .ribbon {
					    right: 0;
					    top: 26px;
					    width: 160px;
					}
					.ribbon-wrapper .ribbon {
					    box-shadow: 0 0 3px rgba(0, 0, 0, .3);
					    font-size: .8rem;
					    line-height: 100%;
					    padding: .375rem 0;
					    position: relative;
					    right: -2px;
					    text-align: center;
					    text-shadow: 0 -1px 0 rgba(0, 0, 0, .4);
					    text-transform: uppercase;
					    top: 10px;
					    -webkit-transform: rotate(45deg);
					    transform: rotate(45deg);
					    width: 90px;
					}
					.bg-success, .bg-success>a {
					    color: #fff !important;
					}
					.bg-success {
					    background-color: #28a745 !important;
					}
					.text-lg {
					    font-size: 1.25rem !important;
					}
					.bg-success {
					    background-color: #28a745 !important;
					}
						
			</style>
			</head>

			<body>
<!-- 				로딩 화면 -->
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
				      <img src="../resources/dist/img/bbaner6.jpg" style="width: 100%; height: 700px;" alt="...">
				    </div>
				    <div class="carousel-item">
				      <img src="../resources/dist/img/bbaner1.jpg"  style="width: 100%; height: 700px;" alt="...">
				    </div>
				    <div class="carousel-item">
				      <img src="../resources/dist/img/bbaner7.jpg"  style="width: 100%; height: 700px;" alt="...">
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
				<div class="flow-container" >
                <div class="flow-text">
                    <div class="flow-wrap">Text that flows from right to left. </div>
                    <div class="flow-wrap">Text that flows from right to left. </div>
                    <div class="flow-wrap">Text that flows from right to left. </div>
                    <div class="flow-wrap">Text that flows from right to left. </div>
                </div>
            </div>
				<br>
				<div class="line"></div>
				
		<!-- 아코디언 -->
		
		<p style="text-align: center; margin-top: 100px; font-size: 50px;">어디서도 만나본 적 없는 초현실적인 <b>세상</b></p>
		<p style="text-align: center; font-size: 20px; color: #999999;">새로운 여행이 시작되는 곳</p>
		<br>
		<div class="accordion-banner" style="margin-top: 30px; width: 1900px; margin-left: -300px; height: 500px;">
		    <div class="accordion-item">
		        <img src="../resources/dist/img/ride1.jpg" alt="Image 1" >
		    </div>
		    <div class="accordion-item">
		        <img src="../resources/dist/img/ride2.jpg" alt="Image 2">
		    </div>
		    <div class="accordion-item">
		        <img src="../resources/dist/img/ride3.jpg" alt="Image 3">
		    </div>
		    <div class="accordion-item">
		        <img src="../resources/dist/img/ride4.jpg" alt="Image 4">
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
		
		<a  type="button" style=" margin-top: -100px; margin-left: 1040px; width: 200px; height: 50px;   border: none;  color: black;" href="/review/list.ft" >> 리뷰 더보기 </a>
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
		
		<div class="line" style=""></div>
		
		<p style="text-align: center; margin-top: 100px; font-size: 50px;">언제 어디서나  <b>페어리타운과 함께</b></p>
		<p style="text-align: center; font-size: 20px; color: #999999;">일상생활 속 함께 하는 페어리타운 굿즈</p>
		
		<div style="display: flex;">
			    <c:forEach items="${gList}" var="goods" varStatus="i">
			        <div style="margin-left: 20px;">
			            <img src="../resources/guploadFiles/${goods.goodsFileRename}" class="image-${i.index}" alt="..."  onclick="showProductInfo('cat-${i.index}')">
			        </div>
			    </c:forEach>
			</div>
			
			<c:forEach items="${gList}" var="goods" varStatus="i">
			    <div class="cat-${i.index}" style="display: none; margin-top: -540px; border: 8px solid #ACE0F8; border-radius: 15px;">
			        <img alt="..." src="../resources/guploadFiles/${goods.goodsFileRename}" style="width: 100%; height: 400px; margin-bottom: 30px; border-radius: 7px 7px 0px 0px;">
<!-- 			        <div class="ribbon-wrapper ribbon-lg"> -->
<!--                         <div class="ribbon bg-success text-lg" > -->
<!--                           New -->
<!--                         </div> -->
<!--                       </div> -->
			        <p style="text-align: center; margin-top: -10px;"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode}">${goods.goodsName}</a></p>
			       	<div class="line" style="width: 200px; margin-left: 90px; margin-top: -4px;"></div><br>
			        <p style="margin-left: 160px; margin-top: -10px;">${goods.goodsPrice} ₩</p>
			    </div>
			</c:forEach>
		
		    <!-- 오른쪽 고정된 div에 선택된 상품 정보 표시 -->
		    <div id="selectedGoodsInfo">
		        <!-- 이 부분은 자바스크립트를 통해 동적으로 업데이트됩니다. 초기에는 비어있을 수 있습니다. -->
		    </div>
		</div>
								
														
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
				<br><br><br><br>
				<div class="line2" style="margin-left: 400px;"></div>
				<p style="text-align: center; font-size: 40px; margin-top: 100px; "><b>찾아오시는 길</b>
				<br>
				<p style=" text-align: center; font-size: 20px;  margin-bottom: 100px;">&#128205; 경기 용인시 처인구 포곡읍 페어리타운로 199</p>
				</p>
				<div id="map" style="width: 60%; height: 500px; margin:0 auto;"></div>
				
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
		        
		        window.onload = function() {
		            // 페이지가 로드될 때 "cat-1" 클래스를 가진 상품 정보 보이기
		            var firstProductInfo = document.querySelector('.cat-0');
		            firstProductInfo.style.display = 'block';
		        };

		        function showProductInfo(className) {
		            // 모든 상품 정보 숨기기
		            var allProductInfos = document.querySelectorAll('[class^="cat-"]');
		            allProductInfos.forEach(function(info) {
		                info.style.display = 'none';
		            });

		            // 클릭한 상품 정보 보이기
		            var productInfo = document.querySelector('.' + className);
		            productInfo.style.display = 'block';
		        }
		        
		        
		    </script>
		    <script>
				// 현재 날짜와 시간 객체 생성
				var currentDate = new Date();
				
				// 현재 날짜 가져오기
				var currentDay = currentDate.getDate();
		
				// 현재 월 가져오기 (0부터 시작하므로 +1 해야 함)
				var currentMonth = currentDate.getMonth() + 1;
		
				// 현재 연도 가져오기
				var currentYear = currentDate.getFullYear();
				
				var today = currentYear + "-" + currentMonth + "-" + currentDay;
				
				console.log(today);
				
				// 요일 배열 생성
				var days = ['일', '월', '화', '수', '목', '금', '토'];
		
				// 현재 요일 가져오기
				var currentDay = days[currentDate.getDay()];
		
				console.log("오늘은 " + currentDay + "요일입니다.");
				$.ajax({
						url: "/weather/info.ft",
						//data: "",
						type: "GET",
						dataType: "json",
						success: function(result) {
							var temperature;
							var rain;
							var rainPercent;
							var sky;
							console.log(result);
							// json 데이터 파싱 필요!!
							/* let items = result.response.body.items.item;
							let str = "";
							
							items.map((item) => {
								console.log(item.facltNm);
								str += item.facltNm + "<br>";
							}); */
							result.response.body.items.item.forEach(function(item) {
								  if (item.category === "TMP") {
								    temperature = parseFloat(item.fcstValue); // 기온 변수 설정
								  } else if (item.category === "PCP") {
								    rain = item.fcstValue;
								  } else if (item.category === "POP") {
								    rainPercent = item.fcstValue;
								  } else if (item.category === "SKY") {
								    sky = item.fcstValue;
								  }
								});
							console.log("Temperature:", temperature);
							console.log("rain:", rain);
							console.log("rainPercent:", rainPercent);
							console.log("sky:", sky);
							//document.querySelector('#print').innerHTML = str;
							var flow = $(".flow-text");
							flow.html("");
						/* 	
							<p>🎠오늘의 파크</p>
						    <p>운영시간</p>
						    <p>10:00~22:00 🎠</p>
						    <p>오늘의 날씨</p>
						    <p>⛅ 체감 15.7° 습도 47%</p>
						    <p>동풍 1.5m/s ⛅</p> */
						    var space = "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
						    var p0;
						    if (currentDay == '토') {
							    p0= "<span style='blue' >" + space + "&#128198;" +today+" "+currentDay+"</span>";
						    } else if (currentDay == '일') {
						    	p0= "<span style='red' >" + space +"&#128198;" + today+" "+currentDay+"</span>";
						    } else {
						    	p0= "<span style=''>" + space +"&#128198;" + today+" "+currentDay+"</span>";
						    }
						    var openCloseTime;
						    if (currentDay == '토' || currentDay == '일') {
						    	openCloseTime = "10:00~22:00 🎠";
						    } else {
						    	openCloseTime = "10:00~20:00 🎠";
						    }
						    var p1 = "<span style=''>"+ space +"🎠오늘의 파크 운영시간 "+openCloseTime+"</span>";
						    var p2 = "<span style=''>" + space +"오늘의 날씨</span>";
						    var p3 = "<span style=''>&#127777;기온: "+ temperature +"°C </span>";
						    var p4;
						    if (sky == '1') {
						    	p4 = "<span style=''>&#127774;날씨: "+ "맑음" +"</span>";
						    } else if (sky == '2') {
						    	p4 = "<span style=''>&#127780;날씨: "+ "구름 조금" +"</span>";
						    } else if (sky == '3') {
						    	p4 = "<span style=''>&#127780;날씨: "+ "구름 많음" +"</span>";
						    } else {
						    	p4 = "<span style=''>&#127781;날씨: "+ "흐림" +"</span>";
						    }
						    var p5;
						    if (rain == '강수없음') {
						    	p5 = "<span style=''>&#127783;강수량: "+ "0.0mm" +"</span>";
						    } else {
						    	p5 = "<span style=''>&#127783;강수량: "+ rain +"</span>";
						    }
						    var p6 = "<span style=''>&#127782;강수확률: "+ rainPercent +"% </span>";
						    var all = '<div class="flow-wrap">'+ p0 + p1 + p2 + p3 + p4 + p5 + p6 +'</div>';
						    flow.append(all);
						    flow.append(all);
						    flow.append(all);
						},
						error: function() {
							alert("통신 실패!");
						}
					});
			</script>
			<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df1f9dc399edf02b72dc0ce8a03a3ef9"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.29310467551401, 127.20222425047989), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.29310467551401, 127.20222425047989); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		let content = document.createElement('div');
        content.innerHTML = '<div class="wrap" style="background-color:white">' + 
        '    <div class="info">' + 
        '        <div class="title">' + 
        				"페어리타운" + 
        '        </div>' + 
        '        <div class="body" style="padding:0;">' + 
        '            <div class="img">' +
        '                <img src="../resources/dist/img/mainLogo.png" width="73" height="70">' +
        '           </div>' + 
        '            <div class="desc">' + 
        '                <div class="ellipsis">경기도 용인시 처인구 포곡읍 페어리타운로 199 (전대리 310)</div>' + 
        '                <div class="jibun ellipsis">모험과 신비로움이 가득한 테마파크</div>' + 
        '            </div>' + 
        '        </div>' + 
        '    </div>' +    
        '</div>';
        let overlay = new kakao.maps.CustomOverlay({
            content: content,
          	//map: map,
            position: marker.getPosition()       
        });
        const closeBtn = document.createElement('div'); 
//         	<div class="close" title="닫기"></div>
        closeBtn.className = 'close';
        closeBtn.setAttribute('title', '닫기');
        closeBtn.onclick = function () {
            overlay.setMap(null);
        };
        content.querySelector(".title").appendChild(closeBtn);
        overlay.setContent(content);
        
        // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
        kakao.maps.event.addListener(marker, 'click', function() {
            overlay.setMap(map);
        });
	</script>
				<!-- 공통 / 풋터 -->
			<jsp:include page="./inc/footer.jsp"></jsp:include>
			
		</div>
	</body>

</html>