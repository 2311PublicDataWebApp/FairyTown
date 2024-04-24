<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>채팅창</title>
		
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
				<div id="divChatParent" style="background-color:#ffffff; overflow:scroll; height: 440px; padding:10px; padding-left: 20px; border: solid 1px #e1e3e9;">
					<div id="divChatData" style=""></div>
					<div class="">
						<img width="60" height="50" src="../resources/guploadFiles/profile.png" alt="">
						<div class="padding-10 mt-10 bor-round shadow" style="max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#f7f5f5; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;">
						안녕하세요,<br>
						모험과 신비의 마을 페어리타운입니다<br>
						궁금하신 내용이 있으시면 채팅 상담을 받아보세요!
						</div>
					</div>
				</div>
				<div class="t-c" style="width: 100%; height: 10%; padding: 10px;">
					<input type="hidden" name="userId" value="<%= userId %>">
		            <input type="hidden" name="myId" value="${user.userId}">
					<textarea id="msg" name="msg" style="border:none; resize: none; width:80%; height:75px; white-space: pre-wrap;"></textarea>
					<button class="btn btn-outline-secondary" type="button" id="button-send" style="background-color: #FFF612; border: 1px solid #ccc; border-radius:5px; padding: 5px 10px; margin-left:10px; position:relative; bottom:50px">전송</button>
				</div>
			</article>
		</div>
		
		
		
		
		
		
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		
	    $(document).ready(function(){
	        const username = $("input[name='myId']").val();
	
	        $("#disconn").on("click", (e) => {
	            disconnect();
	        })
	
	        $("#button-send").on("click", (e) => {
	        	addMsg();
	            send();
	        });
	
	        const websocket = new WebSocket("ws://localhost:8899/ws/chat");
	
	        websocket.onmessage = onMessage;
	        websocket.onopen = onOpen;
	        websocket.onclose = onClose;
			
	        
	        
	        function chatMsgList(){
	        	var chatUserId = $("input[name='userId']").val();
				$.ajax({
					url:"/chat/msgList.ft",
					type:"post",
					data:{"chatUserId" : chatUserId},
					success: function(msgList){
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
		    				console.log(typeof msgList[i].msgSendId); // msgSendId의 타입 확인
			    			console.log(typeof myId);
		    				
			    			var msgSendDate = new Date(msgList[i].msgSendDate); //가져온 데이터 날짜
	    					var msgDayOfWeek = week[new Date(msgSendDate).getDay()]; //가져온 데이터 요일
		    				
	    					
	    					
	    					if(i == 0) {
			    				var date = "<div class='t-c' style='text-align:center; margin:0 auto;'>"
			    								+ "<div class='shadow mt-10 mb-10' style='display:inline-block; border-radius: 20px; background-color:#ffffff; opacity:0.8; padding: 10px 30px 10px;'>"
			    									+ msgList[i].msgSendDate.substr(0, 4) +  "년 " + msgList[i].msgSendDate.substr(5, 2) + "월 " + msgList[i].msgSendDate.substr(8, 2) + "일 "
			    									+ msgDayOfWeek + "요일"
			    								+ "</div>"
			    							+"</div>";
			    				$divChatData.append(date);
		    				} 
	    					if(i > 0 && msgList[i].msgSendDate.substr(0, 10) != msgList[i-1].msgSendDate.substr(0, 10)){
			    				var date = "<div class='t-c' style='text-align:center; margin:0 auto;'>"
												+ "<div class='shadow mt-10 mb-10' style='display:inline-block; border-radius: 20px; background-color:#ffffff; opacity:0.8; padding: 10px 30px 10px;'>"
													+ msgList[i].msgSendDate.substr(0, 4) +  "년 " + msgList[i].msgSendDate.substr(5, 2) + "월 " + msgList[i].msgSendDate.substr(8, 2) + "일 "
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
								if(msgList[i].msgSendId != prevId || msgList[i].msgSendDate.substring(11, 16) != prevTime){
									//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
									//채팅 시간 추가
									if(msgList[i].msgSendDate.substring(11, 13) < 12) {
										msgDate += "<div class='mt-10' style='text-align:right;'> 오전 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else if (msgList[i].msgSendDate.substring(11, 13) == 12){
										msgDate += "<div class='mt-10' style='text-align:right;'> 오후 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else {
										msgDate += "<div class='mt-10' style='text-align:right;'> 오후 "+ (msgList[i].msgSendDate.substring(11, 13)*1-12) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									}
									
								}
								if(msgList[i].msgSendId == prevId && msgList[i].msgSendDate.substring(11, 16) == prevTime){
//	 								console.log("div 삭제");
//	 								console.log($('#divChatData div:last')); //위에 웹소켓 거랑 무슨 차인진 모르겠는데 이렇게 찾아야 나옴...
									$('#divChatData div:last').remove(); //이전 시간 div 삭제
									if(msgList[i].msgSendDate.substring(11, 13) < 12) {
										msgDate += "<div class='mt-10' style='text-align:right;'> 오전 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else if (msgList[i].msgSendDate.substring(11, 13) == 12){
										msgDate += "<div class='mt-10' style='text-align:right;'> 오후 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else {
										msgDate += "<div class='mt-10' style='text-align:right;'> 오후 "+ (msgList[i].msgSendDate.substring(11, 13)*1-12) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									}
								}
//	 							$divChatData.append(msgId);
								$divChatData.append(msgContents);
								$divChatData.append(msgDate);
		    				}
		    				else { //받은 메세지
		    					//메모!!****중요!!
		    					//|| msgList[i].msgSendDate.substring(11, 16) != prevTime
		    					//만약에 시간이 달라질 때마다 상대방 이름을 띄우게 하고 싶으면 위 코드를 아래 if문에 추가하면 됨.
		    					//근데 지금 시간이 메세지 아래 나와서 보기 싫으니까 .. 일단은 이대로 두겠음.
		    					if(prevId != msgList[i].msgSendId ){ //저장한 아이디값과 (이전 메세지 아이디값) 현재 아이디값이 다르면 출력
				    				msgId = "<div class='mt-10' style='margin-left:80px;'>"+ msgList[i].msgSendId +"</div>";
		    					}
		    					msgContents += "<div>"
						    					+ "<img width='60' height='50' src='../resources/guploadFiles/profile.png' alt=''><div class='padding-10 mt-10 bor-round shadow' style='max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#f7f5f5; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;'>" 
						    						+ msgList[i].msgContents 
						    					+ "</div>"
											+ "</div>";
											
			    				if(msgList[i].msgSendId != prevId || msgList[i].msgSendDate.substring(11, 16) != prevTime){
									//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
									//채팅 시간 추가
			    					if(msgList[i].msgSendDate.substring(11, 13) < 12) {
										msgDate += "<div class='mt-10'> 오전 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else if (msgList[i].msgSendDate.substring(11, 13) == 12){
										msgDate += "<div class='mt-10'> 오후 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else {
										msgDate += "<div class='mt-10'> 오후 "+ (msgList[i].msgSendDate.substring(11, 13)*1-12) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									}								
								}
								if(msgList[i].msgSendId == prevId && msgList[i].msgSendDate.substring(11, 16) == prevTime){
//	 								console.log("div 삭제");
//	 								console.log($('#divChatData div:last')); //위에 웹소켓 거랑 무슨 차인진 모르겠는데 이렇게 찾아야 나옴...
									$('#divChatData div:last').remove(); //이전 시간 div 삭제
									if(msgList[i].msgSendDate.substring(11, 13) < 12) {
										msgDate += "<div class='mt-10'> 오전 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else if (msgList[i].msgSendDate.substring(11, 13) == 12){
										msgDate += "<div class='mt-10'> 오후 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									} else {
										msgDate += "<div class='mt-10'> 오후 "+ (msgList[i].msgSendDate.substring(11, 13)*1-12) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
									}							}
								
//	 							if(msgList[i].msgSendDate.substring(11, 13) < 12) {
//	 								msgDate += "<div class='mt-10'> 오전 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
//	 							} else if (msgList[i].msgSendDate.substring(11, 13) == 12){
//	 								msgDate += "<div class='mt-10'> 오후 "+ msgList[i].msgSendDate.substring(11, 13) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
//	 							} else {
//	 								msgDate += "<div class='mt-10'> 오후 "+ (msgList[i].msgSendDate.substring(11, 13)*1-12) + ":" + msgList[i].msgSendDate.substring(14, 16) + "</div>";
//	 							}
								$divChatData.append(msgId);
								$divChatData.append(msgContents);
								$divChatData.append(msgDate);
		    				}
		    				
		    				
		    				
		    				prevId = msgList[i].msgSendId; //for문 끝나기 직전에 현재 아이디값을 prevId로 저장
		    				prevTime = msgList[i].msgSendDate.substring(11, 16); //시간 부분 저장 (11:20 이런 식)
		    				
		    				//페이지 변수에다가 날짜값 넘겨줌
		    				//for문이 반복되는 동안 계속해서 넘겨주고, 
		    				//페이지 맨 위에 정의한 prevDay가 마지막 for문에서 담긴 값으로 적용되도록
		    				//이렇게 안해주니까 select랑 데이터 넣는 거랑 따로라서 채팅 연결되면 
		    				//prevDay = "" 라서 날짜가 무조건 나옴..
			    			prevDay = msgList[i].msgSendDate.substr(0, 10);
		    				
	    					
		    				/* if(msgList[i].msgSendId == myId){ //내가 보낸 메세지
		    					 	str = "<div class='col-6' style='text-align:right;'>";
		    		                str += "<div class='col-3'></div><div class='alert alert-secondary'>";
		    		                str += "<b>" + msgList[i].msgSendId + " : " + msgList[i].msgContents + "</b>";
		    		                str += "</div></div>";
		    		                
								$divChatData.append(str);
		    				} else {
			    					str = "<div class='col-6'>";
			    	                str += "<div class='alert alert-warning'>";
			    	                str += "<b>" + msgList[i].msgSendId + " : " + msgList[i].msgContents + "</b>";
			    	                str += "</div><div class='col-3'></div></div>";
			    	                $divChatData.append(str);
		    					} */
		    				}
		    			$("#divChatParent").scrollTop($("#divChatParent")[0].scrollHeight);
		    			
		    		},
		    		error: function(){
		    			var $divChatData = $("#divChatData");
		    			var divDate = '<div class="t-c" style="text-align:center; margin:0 auto;">' 
										+ '<div class="shadow mt-10 mb-10" style="display:inline-block; border-radius: 20px; background-color:#ffffff; opacity:0.8; padding: 10px 30px 10px;">'
												+ year + "년 " + month + "월 " + day + "일 " + dayOfWeek + "요일"
											+ '</div>'
										+'</div>';
		    			$divChatData.append(divDate);
		    			prevDay = dateString;
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
	
	            console.log(username + ":" + msg.value);
	            websocket.send(username + ":" + msg.value);
	            msg.value = '';
	        }
	        
	        
	
	        //채팅창에서 나갔을 때
	        function onClose(evt) {
	            var str = username + ":"+ username +"님이 방을 나가셨습니다.";
	            websocket.send(str);
	        }
	
	        //채팅창에 들어왔을 때
	        function onOpen(evt) {
	        	chatMsgList();
	            var str = username + ":"+ username +"님이 입장하셨습니다.";
	            websocket.send(str);
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
	    			timeString += "오전 "+ hours + ":" + minutes;
	    		} else if (hours == 12){
	    			timeString += "오후 "+ hours + ":" + minutes;
	    		} else {
	    			timeString += "오후 "+ (hours*1-12) + ":" + minutes;
	    		}
	            var data = msg.data;
	            var sessionId = null;
	            //데이터를 보낸 사람
	            var message = null;
	            var arr = data.split(":");
	
	            for(var i=0; i<arr.length; i++){
	                console.log('arr[' + i + ']: ' + arr[i]);
	            }
	
	            var cur_session = username;
	
	            //현재 세션에 로그인 한 사람
	            sessionId = arr[0];
	            message = arr[1];
				
	           
	            
	            console.log("sessionID : " + sessionId);
	            console.log("cur_session : " + cur_session);
	            console.log("prevId : " + prevId);
	            console.log("dateString : " + dateString);
	            console.log("prevDay : " + prevDay);
	            console.log("timeString : " + timeString);
	            console.log("prevMsgTime : " + prevMsgTime);
				
	            if(prevDay != dateString){ //이전 메세지에서 prevDay에 오늘 날짜 저장한 값이랑 오늘 날짜랑 다르면 div를 한번 출력해준다.
					$('#divChatData').append('<div class="t-c" style="text-align:center; margin:0 auto;">' 
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
						$('#divChatData').append('<div class="mt-10" style="text-align:right;">' + timeString + '</div>');
					}
					if(sessionId == prevId && timeString == prevMsgTime){
						//아이디와 시간이 모두 같을 때
						//채팅 시간 위치 갱신 (원래 위에 있는 div를 지우고 아래 추가)
						console.log($('#divChatData div:nth-last-child(2)')); //뒤에서 두번째 요소 선택 = 이전 채팅 시간 div
						$('#divChatData div:nth-last-child(2)').remove(); //삭제하고
						$('#divChatData').append('<div class="mt-10" style="text-align:right;">' + timeString + '</div>'); //다시 출력
					}
				} 
	            
	            
	            else { //다른 사람이 보낸 메세지
					if(sessionId != prevId ){ //이전에 보낸 사람이랑 아이디 다를 때만 보낸 사람 정보 출력
						$('#divChatData').append('<div class="mt-10" style="margin-left:80px;">' + sessionId + '</div>');
					}
					$('#divChatData').append('<div class="">' 
							+ '<img width="60" height="50" src="../resources/guploadFiles/profile.png" alt=""><div class="padding-10 mt-10 bor-round shadow" style="max-width: 50%; word-wrap: break-word; word-break: break-word; display:inline-block; background-color:#f7f5f5; border-radius: 10px; padding: 10px 20px; margin-bottom:10px;">' + message + '</div>'
						+ '</div>');
					
					if(sessionId != prevId || timeString != prevMsgTime) {
						//이전 채팅의 아이디와 이 채팅의 아이디가 다르거나, 이전 시간과 현재 시간이 같지 않을 때 시간 추가
						//채팅 시간 추가
						$('#divChatData').append('<div class="mt-10">' + timeString + '</div>');
					}
					if(sessionId == prevId && timeString == prevMsgTime){
						//아이디와 시간이 모두 같을 때
						//채팅 시간 위치 갱신 (원래 위에 있는 div를 지우고 아래 추가)
						console.log($('#divChatData div:nth-last-child(2)')); //뒤에서 두번째 요소 선택 = 이전 채팅 시간 div
						$('#divChatData div:nth-last-child(2)').remove(); //삭제하고
						$('#divChatData').append('<div class="mt-10">' + timeString + '</div>'); //다시 출력
					}
				}
	            
	            prevId = sessionId;
				prevDay = dateString; //출력 후에 오늘 날짜로 prevDay 갱신
				prevMsgTime = timeString; //prevMsgTime을 현재 시간으로 갱신
	            
	            
				$("#divChatParent").scrollTop($("#divChatParent")[0].scrollHeight);
	        }
	    })
	</script>
	</body>
</html>