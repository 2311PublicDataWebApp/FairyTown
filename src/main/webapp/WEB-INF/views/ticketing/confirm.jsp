<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- import.payment.js -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    var IMP = window.IMP;
    IMP.init('imp11650867');

    function requestPay() {
        IMP.request_pay(
            {
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: "57008833-33004",
                name: "${ticketOne.ticketName }",
                amount: ${tingOne.purchasePrice},
                buyer_email: "Iamport@chai.finance",
                buyer_name: "포트원 기술지원팀",
                buyer_tel: "010-1234-5678",
                buyer_addr: "서울특별시 강남구 삼성동",
                buyer_postcode: "123-456",
            },
            function (rsp) {
                if (rsp.success) {
                  // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                  // jQuery로 HTTP 요청
                  jQuery.ajax({
                    url: "/ticketing/paymentRegist.ft", // db처리 성공로직
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    data: {
                      imp_uid: rsp.imp_uid,            // 결제 고유번호
                      merchant_uid: rsp.merchant_uid   // 주문번호
                    }
                  }).done(function (data) {
                    // 고객사 서버 결제 API 성공시 로직
                  })
                } else {
                  alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
              });

    }
</script>
<meta charset="UTF-8">
	<title>티켓결제-확인</title>
</head>
<body>
	<form action="/ticketing/confirm.ft" method="post">
		<div>
			<label for="ticketName">티켓이름 : </label>
			${ticketOne.ticketName }
		</div>
		<div>
			<label for="ticketName">상품 설명 : </label>
			${ticketOne.ticketDetail }
		</div>
		<input type="date" id="reservationDate" name="reservationDate" value="${tingOne.reservationDate}" readonly><br>
		성인 : ${tingOne.adult }<br>
		청소년 : ${tingOne.teenager }<br>
		어린이 : ${tingOne.child }<br>
		총 인원수 : ${tingOne.adult + tingOne.teenager + tingOne.child }<br>

		결제 예정 금액 : ${tingOne.purchasePrice}<br><br>
		
		<!-- 결제하기 버튼 생성 -->
		안내 / 주의사항<br>
		취소 / 환불<br>
		상품 세부 사항<br>
	</form>
		<button onclick="requestPay()">결제하기</button><br>

</body>
</html>