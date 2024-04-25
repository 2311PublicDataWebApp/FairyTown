<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>채팅창</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		<style>
		.btn {
			border: 1px solid #ccc;
		}
		.btn:hover {
		    background-color: #ACE0F8;
		    border: none;
		    color: white;
		}
		
		
		@keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            50% { transform: translateX(5px); }
            75% { transform: translateX(-3px); }
        }

        .shake-animation {
            animation: shake 0.5s;
        }
		</style>
	</head>
	<body>
         <% 
	        // userId 값을 초기화
	        String userId = "";
	
	        // request 객체를 사용하여 쿼리 파라미터에서 userId를 추출
	        String queryString = request.getQueryString();
	        if (queryString != null) {
	            String[] params = queryString.split("&");
	            for (String param : params) {
	                String[] keyValue = param.split("=");
	                if (keyValue.length == 2 && keyValue[0].equals("userId")) {
	                    userId = keyValue[1];
	                    break;
	                }
	            }
	        }
	    %>

		
		<div id="conts" class="pos-rel">
	        <article id="sub">
	        	<div class="t-c" style="width: 100%; height: 10%; padding: 10px;">
					<div id="chatHeader" style="text-align:center;">
						<img width='100px' height='50px' src='../resources/guploadFiles/cmaincLogo.png' alt=''>
						<h5><b>페어리타운 상담원 채팅</b></h5>
						<p style="color:lightgray; font-size:smaller;">몇 분 내 답변 받으실 수 있어요</p>
					</div>
				</div>
				<div id="divChatParent" style="background-color:#ffffff; overflow:scroll; height: 440px; padding:10px; padding-left: 20px; border: none;">
					<div id="divChatData" style=""></div>
				</div>
				<div id="msgArea">
					<div>
						<button class="btn" type="button" id="disconn" style="border-radius:16px; padding: 5px 10px; margin:10px 0 0 10px;">채팅 종료</button>
						<button class="btn" type="button" id="time" style="border-radius:16px; padding: 5px 10px; margin:10px 0 0 10px;">채팅 운영 시간🕘</button>
					</div>
					<div class="t-c" style="width: 100%; height: 10%; padding: 10px;">
						<input type="hidden" name="userId" value="<%= userId %>">
			            <input type="hidden" name="myId" value="${user.userId}">
						<textarea id="msg" name="msg" placeholder="메시지를 입력하세요" style="border:1px solid #ccc; border-radius:5px; resize: none; width:80%; height:75px; white-space: pre-wrap;" onkeypress="if(event.keyCode===13 && !event.shiftKey) { event.preventDefault(); $('#button-send').click(); }"></textarea>
						<button class="btn" type="button" id="button-send" style="border-radius:5px; padding: 5px 10px; margin-left:10px; position:relative; bottom:35px">전송</button>
					</div>
				</div>
				<div id="notChat" style="text-align:center; margin-top:50px;">
					<p style="color:lightgray;">지금은 채팅 운영 시간이 아닙니다.<br>1대1 문의 게시판을 이용해주세요.</p>
				</div>
			</article>
		</div>
		
		
		
		
		
		
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
	    window.onload = function() {
	        var currentTime = new Date();
	        var currentHour = currentTime.getHours();
	
	        // 현재 시간이 오전 10시부터 오후 6시 사이인지 확인합니다.
	        if (currentHour >= 10 && currentHour < 18) {
	            // 현재 시간이 조건에 해당하면 textarea를 표시합니다.
	            document.getElementById('msgArea').style.display = 'block';
	            document.getElementById('notChat').style.display = 'none';
	        } else {
	            // 그렇지 않으면 textarea를 숨깁니다.
	            document.getElementById('msgArea').style.display = 'block';
	            document.getElementById('notChat').style.display = 'block';
	        }
	    };
	</script>
	<script>
		
	    $(document).ready(function(){
	        const username = $("input[name='myId']").val();
	        const websocket = new WebSocket("ws://localhost:8899/ws/chat");
	    	
	        websocket.onmessage = onMessage;
	        websocket.onopen = onOpen;
	        websocket.onclose = onClose;
	        
	        $("#disconn").on("click", (e) => {
	        	var chatUserId = $("input[name='userId']").val();
	        	if(confirm("채팅 상담 종료 시 채팅 내역들이 모두 사라집니다.\n채팅 상담을 종료하시겠습니까?")) {	
		        	websocket.close();
		        	window.close();
		        	$.ajax({
						url: "/chat/deleteMsg.ft",
						type: "POST",
						data : {
									"chatUserId":chatUserId						
								},
						success: function() {
							
						},
						error: function() {
							alert("실패")
						}
					});
				  }
	        	
	        });
	        
			$("#time").on("click", (e) => {
	        	var chatUserId = $("input[name='userId']").val();
	        	var str = username + ":"+ "채팅 운영 시간🕘";
	            websocket.send(str);
	        	str = "admin" + ":"+ "페어리타운 상담원 채팅 운영시간은 오전 10시~오후 6시입니다.";
	            websocket.send(str);
	        	
	        });
	        
	        $("#button-send").on("click", (e) => {
	        	var message = $("#msg").val().trim();
	        	if(message === "") {
                    $("#msg").addClass("shake-animation");
                    setTimeout(function(){
                        $("#msg").removeClass("shake-animation");
                    }, 500);
                } else {
                    // 여기에 메시지 전송 로직 추가
		        	addMsg();
		            send();
                }
	        });
	        
	        function chatMsgList(){
	        	var chatUserId = $("input[name='userId']").val();
				$.ajax({
					url:"/chat/msgList.ft",
					type:"post",
					data:{"chatUserId" : chatUserId},
					success: function(msgList){
						if (msgList.length == 0) {
							var str = "admin" + ":"+ "안녕하세요, 모험과 신비의 마을 페어리타운입니다💖\n궁금하신 내용이 있으시면 아래 메시지를 입력해주세요.";
				            websocket.send(str);
						}
		    			var count = msgList.length;
		    			
		    			var $divChatData = $("#divChatData");
		    			$divChatData.html("");//기존 내용 있으면 비우기
		    			
		    			var prevId =""; //이전 아이디값
		    			var prevTime = ""; //이전 시간값, 11:20
		    			var week = ['일', '월', '화', '수', '목', '금', '토'];
		    			
		    			debugger;
		    			var str;
		    			var myId = $("input[name='myId']").val();
		    			for(var i=0; i<count; i++){
		    				
			    			var msgSendDate = new Date(msgList[i].msgSendDate); //가져온 데이터 날짜
			    			
	    					var msgDayOfWeek = week[new Date(msgSendDate).getDay()]; //가져온 데이터 요일
	    					
	    					var year = msgSendDate.getFullYear(); // 년도(4자리)
	    					var month = msgSendDate.getMonth() + 1; // 월(0부터 시작하므로 1을 더해줌)
	    					var day = msgSendDate.getDate(); // 일
	    					var hours = msgSendDate.getHours(); // 시
	    					var minutes = msgSendDate.getMinutes(); // 분
	    					var seconds = msgSendDate.getSeconds(); // 초
	    					var hoursMinutes = hours + ":" + minutes;
	    					
	    					
	    					
	    					if(i == 0) {
			    				var date = "<div class='t-c' style='text-align:center; margin:0 auto; margin-bottom:30px;'>"
			    								+ "<div class='shadow mt-10 mb-10' style='display:inline-block; border-radius: 20px; background-color:#ffffff; opacity:0.8; padding: 10px 30px 10px;'>"
			    									+ year +  "년 " + month + "월 " + day + "일 "
			    									+ msgDayOfWeek + "요일"
			    								+ "</div>"
			    							+"</div>";
			    				$divChatData.append(date);
		    				} 
	    					if(i > 0 && msgList[i].msgSendDate.substr(0, 10) != msgList[i-1].msgSendDate.substr(0, 10)){
			    				var date = "<div class='t-c' style='text-align:center; margin:0 auto; margin-bottom:30px;'>"
												+ "<div class='shadow mt-10 mb-10' style='display:inline-block; border-radius: 20px; background-color:#ffffff; opacity:0.8; padding: 10px 30px 10px;'>"
													+ year +  "년 " + month + "월 " + day + "일 "
													+ msgDayOfWeek + "요일"
												+ "</div>"
											+"</div>";
			    				$divChatData.append(date);
		    				}
	    					
	    					var msgId = "";
		    				var msgContents = "";
		    				var msgDate = "";
		    				
		    				if(msgList[i].msgSendId == myId){ //내가 보낸 메세지
			    				msgId = "<div class='mt-10' style='text-align:right;'>"+ msgList[i].msgSendId + "</div>";
			    				msgContents += "<div style='text-align:right;'>"
							    					+ "<div class='padding-10 mt-10 bor-round shadow' style='text-align:left; max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#ACE0F8; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;'>" 
							    						+ msgList[i].msgContents 
							    					+ "</div>"
												+ "</div>";
								if(msgList[i].msgSendId != prevId || hoursMinutes != prevTime){
									//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
									//채팅 시간 추가
									if (minutes < 10) {
										minutes = "0"+minutes;
									}
									if(hours < 12) {
										msgDate += "<div class='mt-10' style='text-align:right; margin:-7px 0 3px;'> 오전 "+ hours + ":" + minutes + "</div>";
									} else if (hours == 12){
										msgDate += "<div class='mt-10' style='text-align:right; margin:-7px 0 3px;'> 오후 "+ hours + ":" + minutes + "</div>";
									} else {
										msgDate += "<div class='mt-10' style='text-align:right; margin:-7px 0 3px;'> 오후 "+ (hours*1-12) + ":" + minutes + "</div>";
									}
									
								}
								if(msgList[i].msgSendId == prevId && hoursMinutes == prevTime){

									$('#divChatData div:last').remove(); //이전 시간 div 삭제
									if (minutes < 10) {
										minutes = "0"+minutes;
									}
									if(hours < 12) {
										msgDate += "<div class='mt-10' style='text-align:right; margin:-7px 0 3px;'> 오전 "+ hours + ":" + minutes + "</div>";
									} else if (hours == 12){
										msgDate += "<div class='mt-10' style='text-align:right; margin:-7px 0 3px;'> 오후 "+ hours + ":" + minutes + "</div>";
									} else {
										msgDate += "<div class='mt-10' style='text-align:right; margin:-7px 0 3px;'> 오후 "+ (hours*1-12) + ":" + minutes + "</div>";
									}
								}
//	 							$divChatData.append(msgId);
								$divChatData.append(msgContents);
								$divChatData.append(msgDate);
		    				}
		    				else { //받은 메세지
		    					
		    					if(prevId != msgList[i].msgSendId ){ //저장한 아이디값과 (이전 메세지 아이디값) 현재 아이디값이 다르면 출력
		    						if (msgList[i].msgSendId == "admin") {
		    							msgId = "<div class='mt-10' style='margin-left:80px; color: gray; font-size: smaller;'>"+ "페어리타운" +"</div>";
		    						} else {
					    				msgId = "<div class='mt-10' style='margin-left:80px; color: gray; font-size: smaller;'>"+ msgList[i].msgSendId +"</div>";
		    						}
		    					}
		    					msgContents += "<div>"
						    					+ "<img width='60' height='50' src='../resources/guploadFiles/cprofile.png' alt=''><div class='padding-10 mt-10 bor-round shadow' style='max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#f7f5f5; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;'>" 
						    						+ msgList[i].msgContents 
						    					+ "</div>"
											+ "</div>";
											
			    				if(msgList[i].msgSendId != prevId || hoursMinutes != prevTime){
									//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
									//채팅 시간 추가
									if (minutes < 10) {
										minutes = "0"+minutes;
									}

			    					if(hours < 12) {
										msgDate += "<div class='mt-10' style='margin:-7px 0 3px 60px;'> 오전 "+ hours + ":" + minutes + "</div>";
									} else if (hours == 12){
										msgDate += "<div class='mt-10' style='margin:-7px 0 3px 60px;'> 오후 "+ hours + ":" + minutes + "</div>";
									} else {
										msgDate += "<div class='mt-10' style='margin:-7px 0 3px 60px;'> 오후 "+ (hours*1-12) + ":" + minutes + "</div>";
									}								
								}
								if(msgList[i].msgSendId == prevId && hoursMinutes == prevTime){

									$('#divChatData div:last').remove(); //이전 시간 div 삭제
									$('#divChatData img').last().attr('src', '../resources/guploadFiles/cprofile3.png');
									if (minutes < 10) {
										minutes = "0"+minutes;
									}
									if(hours < 12) {
										msgDate += "<div class='mt-10' style='margin:-7px 0 3px 60px;'> 오전 "+ hours + ":" + minutes + "</div>";
									} else if (hours == 12){
										msgDate += "<div class='mt-10' style='margin:-7px 0 3px 60px;'> 오후 "+ hours + ":" + minutes + "</div>";
									} else {
										msgDate += "<div class='mt-10' style='margin:-7px 0 3px 60px;'> 오후 "+ (hours*1-12) + ":" + minutes + "</div>";
									}							}
								

								$divChatData.append(msgId);
								$divChatData.append(msgContents);
								$divChatData.append(msgDate);
		    				}
		    				
		    				
		    				
		    				prevId = msgList[i].msgSendId; //for문 끝나기 직전에 현재 아이디값을 prevId로 저장
		    				prevTime = hoursMinutes; //시간 부분 저장 (11:20 이런 식)
		    				
		    			
			    			prevDay = msgList[i].msgSendDate.substr(0, 10);
		    				
	    					
		    			
		    				}
		    			$("#divChatParent").scrollTop($("#divChatParent")[0].scrollHeight);
		    			
		    		},
		    		error: function(){
		    			var str = username + ":"+ username +"님이 입장하셨습니다.";
			            websocket.send(str);
		    		}
				});
			}
	        
	        function addMsg() {
	        	var msgContents = $("textarea[name='msg']").val();
	        	var chatUserId = $("input[name='userId']").val();
	        	$.ajax({
					url: "/chat/addMsg.ft",
					type: "POST",
					data : {
								"msgContents":msgContents,
								"chatUserId":chatUserId						
							},
					success: function(response) {
						
					
					},
					error: function() {
						alert("실패")
					}
				});
	        }
	        
	        function send(){
	
	            let msg = document.getElementById("msg");
	
	            websocket.send(username + ":" + msg.value);
	            msg.value = '';
	        }
	        
	        
	
	        //채팅창에서 나갔을 때
	        function onClose(evt) {
	            /* var str = username + ":"+ username +"님이 방을 나가셨습니다.";
	            websocket.send(str); */
	        }
	
	        //채팅창에 들어왔을 때
	        function onOpen(evt) {
	        	chatMsgList();
	            /* var str = username + ":"+ username +"님이 입장하셨습니다.";
	            websocket.send(str); */
	        }
			

        	var prevId = "";
    		var prevDay = "";
    		var prevMsgTime = "";
	        
	        function onMessage(msg) {
	    		var today = new Date();
	    		var year = today.getFullYear();
	    		var month = ('0' + (today.getMonth() + 1)).slice(-2);
	    		var day = ('0' + today.getDate()).slice(-2);
	    		var week = ['일', '월', '화', '수', '목', '금', '토'];
	    	    var dayOfWeek = week[new Date(today).getDay()]; //요일
	    		var dateString = year + '-' + month  + '-' + day;
	    		
	    		var hours = ('0' + today.getHours()).slice(-2); 
	    		var minutes = ('0' + today.getMinutes()).slice(-2);
	    		var seconds = ('0' + today.getSeconds()).slice(-2); 
	    		var timeString = "";
	    	
	    		if(hours < 12) {
	    			if(hours < 10) {
	    				hours = hours.slice(-1);
	    				console.log(hours);
	    			}
	    			timeString += "오전 "+ hours + ":" + minutes;
	    		} else if (hours == 12){
	    			timeString += "오후 "+ hours + ":" + minutes;
	    		} else {
    				timeString += "오후 "+ (hours-12) + ":" + minutes;
// 	    			if((hours-12) < 10) {
// 	    			}
// 	    			else {
// 		    			timeString += "오후 "+ (hours-12) + ":" + minutes;
// 	    			}
	    		}
	            var data = msg.data;
	            var sessionId = null;
	            //데이터를 보낸 사람
	            var message = null;
	            var arr = data.split(":");
	
	            
	
	            var cur_session = username;
	
	            //현재 세션에 로그인 한 사람
	            sessionId = arr[0];
	            message = arr[1];
				
	           
	            
				
	            if(prevDay != dateString){ //이전 메세지에서 prevDay에 오늘 날짜 저장한 값이랑 오늘 날짜랑 다르면 div를 한번 출력해준다.
					$('#divChatData').append('<div class="t-c" style="text-align:center; margin:0 auto; margin-bottom:30px;">' 
												+ '<div class="shadow mt-10 mb-10" style="display:inline-block; border-radius: 20px; background-color:#ffffff; opacity:0.8; padding: 10px 30px 10px;">'
													+ year + "년 " + month + "월 " + day + "일 " + dayOfWeek + "요일"
												+ '</div>'
											+'</div>');
				} 
	            if(cur_session == sessionId){ //내가 보낸 메세지
					$('#divChatData').append('<div class="" style="text-align: right;">' 
												+ '<div class="padding-10 mt-10 bor-round shadow" style="text-align:left; max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#ACE0F8; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;">' + message + '</div>'
											+ '</div>');
					if(sessionId != prevId || timeString != prevMsgTime) {
						//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
						//채팅 시간 추가
						$('#divChatData').append('<div class="mt-10" style="text-align:right; margin:-7px 0 3px;">' + timeString + '</div>');
					}
					if(sessionId == prevId && timeString == prevMsgTime){
						//아이디와 시간이 모두 같을 때
						//채팅 시간 위치 갱신 (원래 위에 있는 div를 지우고 아래 추가)
						console.log($('#divChatData div:nth-last-child(2)')); //뒤에서 두번째 요소 선택 = 이전 채팅 시간 div
						$('#divChatData div:nth-last-child(2)').remove(); //삭제하고
						$('#divChatData').append('<div class="mt-10" style="text-align:right; margin:-7px 0 3px;">' + timeString + '</div>'); //다시 출력
					}
				} 
	            
	            
	            else { //다른 사람이 보낸 메세지
					if(sessionId != prevId ){ //이전에 보낸 사람이랑 아이디 다를 때만 보낸 사람 정보 출력
						if (sessionId == "admin") {
							$('#divChatData').append('<div class="mt-10" style="margin-left:80px; color: gray; font-size: smaller;">' + "페어리타운" + '</div>');
						} else {
							$('#divChatData').append('<div class="mt-10" style="margin-left:80px; color: gray; font-size: smaller;">' + sessionId + '</div>');
						}
					}
					$('#divChatData').append('<div class="">' 
							+ '<img width="60" height="50" src="../resources/guploadFiles/cprofile.png" alt=""><div class="padding-10 mt-10 bor-round shadow" style="max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#f7f5f5; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;">' + message + '</div>'
						+ '</div>');
					
					if(sessionId != prevId || timeString != prevMsgTime) {
						//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
						//채팅 시간 추가
						$('#divChatData').append('<div class="mt-10" style="margin:-7px 0 3px 60px;">' + timeString + '</div>');
					}
					if(sessionId == prevId && timeString == prevMsgTime){
						//아이디와 시간이 모두 같을 때
						//채팅 시간 위치 갱신 (원래 위에 있는 div를 지우고 아래 추가)
						console.log($('#divChatData div:nth-last-child(2)')); //뒤에서 두번째 요소 선택 = 이전 채팅 시간 div
						$('#divChatData div:nth-last-child(2)').remove(); //삭제하고
						$('#divChatData').append('<div class="mt-10" style="margin:-7px 0 3px 60px;">' + timeString + '</div>'); //다시 출력
					}
				}
	            
	            prevId = sessionId;
				prevDay = dateString; //출력 후에 오늘 날짜로 prevDay 갱신
				prevMsgTime = timeString; //prevMsgTime을 현재 시간으로 갱신
	            
	            
				$("#divChatParent").scrollTop($("#divChatParent")[0].scrollHeight);
	        }
	    })
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	</body>
</html>