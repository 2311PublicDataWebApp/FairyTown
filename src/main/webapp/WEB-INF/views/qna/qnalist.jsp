<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>1 대 1 문의</title>
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<style>
			html,body {
				font-family: 'SUITE', sans-serif;
				  margin: 0;
				}
				.panel-faq-container {
				  margin-bottom: -16px;
				}
				.panel-faq-title {
				  color: #00eaea;
				  cursor: pointer;
				}
				.panel-faq-answer {
				  height: 0;
				  overflow: hidden;
				  /* 변화가 시작되는 쪽에다가 transition 적용해준다 0 -> 300px 
				  왜? 닫기 버튼을 누를 때 변화가 티남 */
				  transition: all 1s;
				}
				#btn-all-close {
				  margin-bottom: 10px;
				  background-color: #F2ADC9;
				  border: none;
				  color: #fff;
				  cursor: pointer;
				  padding: 10px 25px;
				  float: right;
				  border-radius: 10px;
				}
				#btn-all-close:hover {
				  background-color: #ACE0F8;
				  color: white;
				  transition: all 0.35s;
				}
				.active {
				  display: block;
				  /* 높이를 정해줘야지만 transition이 적용됨 */
				  height: 200px;
				}
		</style>
	</head>
	<body>
			<jsp:include page="../inc/header.jsp"></jsp:include>
			
			<div class="container" >
	    <h3 style="text-align: center; padding-top: -40px; margin-left: 100px;">
	      1대1문의
	     <p class="line" 
			   style="border: 0.5px solid ;
					  width: 500px;
					  color: #DEDEDE;
					  margin-left: 350px;
					  margin-top: 20px;"
			   />
	     	</div>
<!-- 	      <small class="text-muted">with faded secondary text</small> -->
	    </h3>
		<button type="button"  onclick="showInsertForm();" style="margin-left: 1420px; height: 43px; width:100px; border-radius: 10px; background-color: #ACE0F8; border: none;
				  color: #fff; margin-top: 1px;  ">문의하기</button>
	    <button id="btn-all-close" style="margin-right: 250px;">모두 닫기</button>
	    <br>
	    <table class="table table-bordered table-striped table-Light table-hover" style="width:70%; margin-left: 320px; margin-top: 20px;">
	      <thead class="thead-light text-center">
	        <tr>
	          <th>번호</th>
	          <th>제목</th>
	          <th>작성자</th>
	          <th>날짜</th>
	          <th>상태</th>
	        </tr>
	      </thead>
	      <tbody class="text-center">
	      <c:forEach items="${qList}" var="qna" varStatus="i">
	        <tr>
	          <td>${qna.qnaNo }</td>
	          <td class="text-left" width="50%">
	            <div class="panel-faq-container">
	              <p class="panel-faq-title" style="color: black;">${qna.qnaName }</p>
	              <div class="panel-faq-answer">
	                <p style="color: #4372FE; font-weight: bold;">문의내용</p>
	                <p>
	                	${qna.qnaContent }
	                </p>
	                <p style="color: #4372FE; font-weight: bold;">답변</p>
	                <c:forEach items="${rList}" var="reply" varStatus="j">
	                <p>
	                	<table width="550" border="1" id="qnaReplyTable">
						<tbody>
							
						</tbody>
					</table>
	                </p>
	                </c:forEach>
	              </div>
	            </div>
	          </td>
	          <td>${qna.qnaWriter }</td>
	          <td style="color: #868e96;">${qna.qnaDate }</td>
	          <td style="color: #4372FE; font-weight: bold;">${qna.qnaStatus }</td>
	        </tr>
	      </c:forEach>
	      </tbody>
	    </table>
	    <!--페이지네이션 위치 -->
				<div style="margin-left: 940px; margin-top: 30px; ">
				<tr align="center">
					<td colspan="5">
						<c:if test="${pInfo.startNavi ne '1' }">
							<a href="/qna/list.ft?page=${pInfo.startNavi - 1 }">[이전]</a>
						</c:if>
						<c:forEach begin="${pInfo.startNavi }" end="${pInfo.endNavi }" var="p">
							<a href="/qna/list.ft?page=${p }">${p }</a>
						</c:forEach>
						<c:if test="${pInfo.endNavi ne pInfo.naviTotalCount }">
							<a href="/qna/list.ft?page=${pInfo.endNavi + 1 }">[다음]</a>
						</c:if>
						<script>
						function showInsertForm() {
							// 공지사항 글쓰기 페이지 이동
							location.href="/qna/insert.ft";
						}
						</script>
					</td>
				</tr>

				</div>
	  </div>
	  <br><br><br><br><br><br>
	  	<script>
			  	window.onload = () => {
			  	  // panel-faq-container
			  	  const panelFaqContainer = document.querySelectorAll(".panel-faq-container"); // NodeList 객체
			  	  
			  	  // panel-faq-answer
			  	  let panelFaqAnswer = document.querySelectorAll(".panel-faq-answer");
			
			  	  // btn-all-close
			  	  const btnAllClose = document.querySelector("#btn-all-close");
			  	  
			  	  // 반복문 순회하면서 해당 FAQ제목 클릭시 콜백 처리
			  	  for( let i=0; i < panelFaqContainer.length; i++ ) {
			  	    panelFaqContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
			  	      // FAQ 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
			  	      panelFaqAnswer[i].classList.toggle('active');
			  	    });
			  	  };
			  	  
			  	  btnAllClose.addEventListener('click', function() {
			  	    // 버튼 클릭시 처리할 일  
			  	    for(let i=0; i < panelFaqAnswer.length; i++) {
			  	        panelFaqAnswer[i].classList.remove('active');
			  	    };
			  	  });
			  	}
			  	
			  	
	  	</script>
	</body>
</html>