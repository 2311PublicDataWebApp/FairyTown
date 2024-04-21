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
		<jsp:include page="../inc/header.jsp"></jsp:include>
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
		<div>
	        <div class="container">
	            <div class="col-6">
	                <label><b>채팅방</b></label>
	            </div>
	            <div>
		            <div id="divChatParent">
						<div id="divChatData"></div>
					</div>
	                <div id="msgArea" class="col"></div>
	                <div class="col-6">
	                    <div class="input-group mb-3">
	                        <input type="text" id="msg" name="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
	                        <input type="hidden" name="userId" value="<%= userId %>">
	                        <input type="hidden" name="myId" value="${userId}">
	               
	                        <div class="input-group-append">
	                            <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
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
		    			
		    			debugger;
		    			var str;
		    			var myId = $("input[name='myId']").val();
		    			for(var i=0; i<count; i++){
		    				console.log(typeof msgList[i].msgSendId); // msgSendId의 타입 확인
			    			console.log(typeof myId);
		    				
		    				if(msgList[i].msgSendId == myId){ //내가 보낸 메세지
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
		    					}
		    				}
		    			
		    		},
		    		error: function(){
		    			
		    		}
				});
			}
	        
	        
	        
	        
	        function addMsg() {
	        	var msgContents = $("input[name='msg']").val();
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
	            var str = username + ": 님이 방을 나가셨습니다.";
	            websocket.send(str);
	        }
	
	        //채팅창에 들어왔을 때
	        function onOpen(evt) {
	        	chatMsgList();
	            var str = username + ": 님이 입장하셨습니다.";
	            websocket.send(str);
	        }
	
	        function onMessage(msg) {
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
	            console.log("cur_session : " + cur_session);
	            sessionId = arr[0];
	            message = arr[1];
	
	            console.log("sessionID : " + sessionId);
	            console.log("cur_session : " + cur_session);
	
	            //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	            if(sessionId == cur_session){
	                var str = "<div class='col-6' style='text-align:right;'>";
	                str += "<div class='col-3'></div><div class='alert alert-secondary'>";
	                str += "<b>" + sessionId + " : " + message + "</b>";
	                str += "</div></div>";
	                $("#msgArea").append(str);
	            }
	            else{
	                var str = "<div class='col-6'>";
	                str += "<div class='alert alert-warning'>";
	                str += "<b>" + sessionId + " : " + message + "</b>";
	                str += "</div><div class='col-3'></div></div>";
	                $("#msgArea").append(str);
	            }
	        }
	    })
	</script>
	</body>
</html>