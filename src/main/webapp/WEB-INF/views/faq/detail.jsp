<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>자주 묻는 질문</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
		<style>
			/* reset */
				*,h1 {
					margin:0;
					padding:0;
					box-sizing:border-box;
				}
				
				html,body{
					width:100%;
					height:100%;
				}
				
				body {
					background:#fff;
					-webkit-overflow-scrolling:touch;
				}
				a:link, a:visited, a:hover{
/* 					color: #333;  */
					text-decoration: none;
				}
			
				.M_wrap{
					width: 500px; 
					height: 430px; 
					margin: 100px auto;
					background: #f6f6f6; 
					border-radius: 10px; 
					overflow: hidden;
					position: relative;
				}
			
				h1.M_main_title{
					height: 75px; 
					background-color: #0057b8;
					color: #fff; 
					text-align: center;
					font-size: 22px; 
					padding: 23px 0;
					font-weight: 600;
				 }
				 
				.M_content_wrap{
					padding: 30px 20px 40px;
				}
				
				.M_content_wrap > .btn_box{
					 border: 1px solid #dadada; 
					 padding: 15px 40px 15px; 
					 background: #f5f6f7; 
					 text-align: left; 
					 margin-bottom: 20px; 
					 margin-left: 60px;
					 box-shadow: 2px 2px 6px #dadada; 
					 font-weight: 600; 
					 font-size: 17px; 
					 position: relative; 
					 display: inline-block; 
					 width: 20%;
					 height: 350px;
				 }
				 
				.M_content_wrap > .btn_box:last-child{
					margin-bottom: 0;
				}
				
				.M_content_wrap > .btn_box span.arrow_box{
					position: relative;
				}
				
				.M_content_wrap > .btn_box span.arrow_box{
					content: '';  
					position: absolute; 
					width: 10px; 
					height: 10px; 
					border-top: 3px solid #cacaca; 
					border-right: 3px solid #cacaca; 
					display: inline-block; 
					transform: rotate(45deg); 
					top: 20px; 
					right: 25px;
				}
				
				.ADpopup_wrap_background{
					position: fixed;
					top:0; left: 0; bottom: 0; right: 0;
					background: rgba(0, 0, 0, 0.8);
				}
				
				.ADpopup_wrap{
					width: 400px; 
					height: 300px; 
					position: absolute; 
					border: 1px solid #cacaca; 
					background: #fff; 
					top: 353px; 
					left: 50%; 
					margin-left: -200px; 
					padding: 10px; 
					text-align: center;
				}
				
				.AD_info{
					height: 243px;
				}
				
				.close_btn{ 
					padding: 5px 10px; 
					color: #fff; 
					background: #003666; 
					font-size: 16px; 
					border-radius: 5px;
				}
			</style>
	</head>
	
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		
			<p style="font-size: 40px;
					  text-align: center;"
			>자주 묻는 질문 TOP8</p>
			<img src="./resources/dist/img/faq3.png" style="width: 100px; margin-left: 1130px; margin-top: -150px;"/>
			
			<p class="line" 
			   style="border: 0.5px solid ;
					  width: 500px;
					  color: #DEDEDE;
					  margin-left: 700px;
					  margin-bottom: 50px;"
			   />
		
<!-- 	<div class="M_wrap"> -->
<!--     	<h1 class="M_main_title">팝업 버튼창</h1> -->
    		<div class="M_content_wrap" style="position: releative;" >
				<!-- 버튼 -->
				<a href="javascript:openPop('modal1');" class="btn_box">	
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >
			    			  Q. 회원가입, 탈퇴는 어떻게 하나요?</p> 

				</a>
				<a href="javascript:openPop('modal2');" class="btn_box">
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 유효기간이 지난 예매권은  사용할수있나요?</p> 

				</a>	
				<a href="javascript:openPop('modal3');" class="btn_box">
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 페어리타운 캐스트에 <br>지원하려면 어떻게<br> 해야하나요?</p> 

				</a>	
				<a href="javascript:openPop('modal4');" class="btn_box">
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 종합이용권이나 입장권으로 이용 못하는 시설이<br>있나요?</p> 

				</a>
				<a href="javascript:openPop('modal5');" class="btn_box">	
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 예매한 티켓은 <br>어디서 받을 수 있나요?</p> 

				</a>
				<a href="javascript:openPop('modal6');" class="btn_box">
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 직접 방문하지 않아도 <br>온라인으로 티켓을 구매할 수 있나요?</p> 

				</a>	
				<a href="javascript:openPop('modal7');" class="btn_box">
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 페어리타운을 나갔다가 다시 들어올 수 있나요?</p> 

				</a>	
				<a href="javascript:openPop('modal8');" class="btn_box" style="margin-bottom: 20px;">
					<p style="color: black; text-align: center;
							  position: absolute;
							  top: 50%;
			   				  left: 50%;
			    			  transform: translate(-50%, -50%);"
			    			  >Q. 비가 올때도 <br>운영하나요?</p> 

				</a>
		</div>
			<div style="position: absolute;">
			<img src="./resources/dist/img/balloon1.png" style="width: 150px; margin-top: -1220px; margin-left: 20px; "/>
			<img src="./resources/dist/img/balloon2.png" style="width: 150px; margin-top: -380px; margin-left: 1410px; "/>
			</div>
			</div>
				

			<!-- 팝업창 -->
			<div class="ADpopup_wrap_background">
			<div class="ADpopup_wrap modal1" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 120px;">
					회원가입과 탈퇴는 페어리타운 홈페이지에서 로그인창에서 <br>가입과 탈퇴를 할수 있습니다.
					<img alt="" src="../resources/dist/img/mouse.png" style=" position: absolute; width:130px; margin-top: 80px; margin-left: 20px;">
				</div>	
				<input type="button" value="닫기" class="close_btn">		
			</div>
			<div class="ADpopup_wrap modal2" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 80px;">
					유효기간이 지난 교환권은 사용이 가능하나, 1년이 아닌 교환권 만료일에 따라 유효기간이 차감된 잔여기간은 사용이 가능합니다.
					ex) 교환권 유효기간 : 10. 12. 31 유효기간이 지난 교환권으로 연간이용권 가입시 이용기간은 가입일 ~ 11. 12. 30 까지 사용이 가능합니다.
					<img alt="" src="../resources/dist/img/frog.png" style=" position: absolute; width:110px; margin-top: 40px; margin-left: 60px;">
				</div>
				<input type="button" value="닫기" class="close_btn">
			</div>
			<div class="ADpopup_wrap modal3" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 80px;">
					페어리타운 어드벤처는 즐겁게 일하고 손님에게 최선의 서비스를 제공할 준비가 되어 있는 지원자를 찾고 있습니다.
					페어리타운은 다양한 지원자 분들의 편의와 효율적인 채용관리를 위해 인재채용 홈페이지를 운영해 채용공고를 게시하고 있습니다.
					<img alt="" src="../resources/dist/img/chick.png" style=" position: absolute; width:150px; margin-top: 65px; margin-left: -80px;">
				</div>
				<input type="button" value="닫기" class="close_btn">
			</div>
			<div class="ADpopup_wrap modal4" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 80px;">
					종합이용권이나 파크이용권, 연간이용권으로는 대부분의 시설물을 이용하실 수 있으나,
					게임시설(코인 아케이드 시설，서바이벌 게임장, 툼 오브 호러 등) 또는
					유료 지불 시설은 별도의 요금을 지불하셔야 합니다．
					<img alt="" src="../resources/dist/img/rabbit2.png" style=" position: absolute; width:110px; margin-top: 35px; margin-left: 30px;">
				</div>
				<input type="button" value="닫기" class="close_btn">
			</div>
			<div class="ADpopup_wrap modal5" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 100px;">
					모바일/온라인 예매를 하셨다면 사이트 안에 티켓이 생성되며, 별도의 지류티켓 발권 없이 바로 사이트 화면을 통해 게이트로 입장하실 수 있습니다.
					<img alt="" src="../resources/dist/img/whale.png" style=" position: absolute; width:110px; margin-top: 50px; margin-left: 50px;">
				</div>	
				<input type="button" value="닫기" class="close_btn">		
			</div>
			<div class="ADpopup_wrap modal6" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 70px;">
					페어리타운은 더 빠르고 편리한 이용을 위해 온라인 예매 서비스를 시행하고 있습니다.
					이용권의 종류, 사용일, 결제종류 등을 선택하셔서 미리 예매하시면 받으시는 분의 휴대폰으로 모바일 티켓이 전송됩니다.
					단, 2G 폰을 사용중인 손님분들은 사이트를 이용한 모바일 티켓을 사용하실 수 없습니다. 
					현장에서 티켓을 별도로 구매해 주시기 바랍니다.
					<img alt="" src="../resources/dist/img/whale2.png" style=" position: absolute; width:110px; margin-top: 10px; margin-left: 10px;">
				</div>	
				<input type="button" value="닫기" class="close_btn">		
			</div>
			<div class="ADpopup_wrap modal7" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 45px;">
					롯데월드 어드벤처에서는 파크 입장 후 퇴장하시면 원칙적으로 재입장이 불가능합니다.
					단, 재입장을 도와드리는 몇가지 사항에 대해 안내해 드립니다.<br>
	
	  				① 의무실 방문 후 간호사 진단에 따라 외부 의료기관 방문하는경우<br>
	  				② 파크 입장 후 매직패스 프리미엄 티켓 구매를 희망하시는<br>경우<br>
	  				③ 페어리타운과 제휴된 시설을 이용한 경우
	  				<img alt="" src="../resources/dist/img/sq.png" style=" position: absolute; width:110px; margin-top: -15px; margin-left: -15px;">
				</div>	
				<input type="button" value="닫기" class="close_btn" style="margin-top: 30px;">		
			</div>
			
			<div class="ADpopup_wrap modal8" style="display: none; position: releative;">
				<div class="AD_info" style="margin-top: 90px;">
					페어리타운은 365일 연중 무휴로 운영되고 있으며
					페어리타운은 천정이 유리돔인 실내공간으로 날씨에 관계 없이 즐길수 있습니다.
					다만, 외부시설의 경우 날씨의 영향을 받아 일부 어트랙션 운행이 중단할 수 있는 점 참고부탁드립니다.
					<img alt="" src="../resources/dist/img/tiger.png" style=" position: absolute; width:110px; margin-top: 50px; margin-left: -20px;">
				</div>	
				<input type="button" value="닫기" class="close_btn">		
			</div>
			</div>
			
		<script type="text/javascript">
		$(document).ready(function () {
		    // 초기에는 팝업 배경을 숨김
		    $(".ADpopup_wrap_background").css('display', 'none');
	
		    // 팝업 열기
		    function openPop(modalname) {
		        $("." + modalname).css('display', 'block');
		        $(".ADpopup_wrap_background").css('display', 'block');
		    }
	
		    // 팝업 닫기
		    $(".ADpopup_wrap .close_btn").click(function () {
		        $(this).closest('.ADpopup_wrap').css('display', 'none');
		        $(".ADpopup_wrap_background").css('display', 'none');
		    });
	
		    $(".ADpopup_wrap_background").click(function () {
		        $(".ADpopup_wrap").css('display', 'none');
		        $(this).css('display', 'none');
		    });
		});	
			// 팝업 열기
			function openPop(modalname) {
			    $("." + modalname).css('display', 'block');
			    $(".ADpopup_wrap_background").css('display', 'block');
			}
		
			$(document).ready(function () {
			    // 팝업 닫기
			    $(".ADpopup_wrap .close_btn").click(function () {
			        $(this).closest('.ADpopup_wrap').css('display', 'none');
			        $(".ADpopup_wrap_background").css('display', 'none');
			    });
		
			    $(".ADpopup_wrap_background").click(function () {
			        $(".ADpopup_wrap").css('display', 'none');
			        $(this).css('display', 'none');
			    });
			});
	</script>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</body>
	
</html>