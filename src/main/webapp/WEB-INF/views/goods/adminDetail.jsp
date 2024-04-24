<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 상세 정보</title>

	<!-- DataTables -->
	<link rel="stylesheet" href="../resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
</head>
<body>
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
	<!-- Content Header -->
	<div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>굿즈 상세 정보</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">DataTables</li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
			<div class="card-body">
				<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showModifyPage();">수정</button>
				<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="deleteGoods();">삭제</button>
				<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showGoodsList();">목록</button>
                <table id="example2" class="table table-bordered table-hover" style="margin-top:10px;">
                  <tbody>
	                  <tbody>
							<tr>
								<td width="170px">상품코드</td>
								<td><p class="goodsCode">${goods.goodsCode }</p></td>
							</tr>
							<tr>
								<td>상품명</td>
								<td>${goods.goodsName }</td>
							</tr>
							<tr>
								<td>가격</td>
<%-- 								<td>${goods.goodsPrice }원</td> --%>
								<td>₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></td>
							</tr>
							
							<tr>
								<td>첨부파일</td>
								<td><img src='../resources/guploadFiles/${goods.goodsFileRename }' width="100px" height="70px"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td>${goods.goodsContent }</td>
							</tr>
						</tbody>
				 </tbody>
                </table>
              </div>
			</div>	
		</div>
	</div>
</div>
</section>
</div>
<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
<!-- DataTables  & Plugins -->
<script src="../resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../resources/plugins/jszip/jszip.min.js"></script>
<script src="../resources/plugins/pdfmake/pdfmake.min.js"></script>
<script src="../resources/plugins/pdfmake/vfs_fonts.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

<script type="text/javascript">
	function showModifyPage() {
		var goodsCode = "${goods.goodsCode }";
		location.href = "/admin/goodsModify.ft?goodsCode=" + goodsCode;
	}
	
	function deleteGoods() {
		if (confirm("삭제하시겠습니까?")) {
			var goodsCode = "${goods.goodsCode }";
			location.href = "/admin/goodsDelete.ft?goodsCode=" + goodsCode;
		}
	}
	
	function showGoodsList() {
		location.href = "/admin/goodsList.ft";
	}
</script>
</body>
</html>