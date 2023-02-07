<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.web.roomType.model.*"%>
<%@ page import="com.web.roomType.model.entities.*"%>
<%@ page import="com.web.roomType.model.service.*"%>
<%@ page import="com.web.roomType.model.dao.*"%>
<%@ page import="com.web.roomType.model.dao.impl.*"%>


<%
RoomType roomType = (RoomType) request.getAttribute("roomType");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IPET 寵物</title>
<!-- TODO: 目前先使用 完整css，後續再換成 min.css-->
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/backstage/plugins/fontawesome-free/css/all.css">
<!-- IonIcons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/backstage/css/adminlte.css">


<style type="text/css">
table, th, td {
	border: 1px solid white;
	border-collapse: collapse;
	text-align: center;
}

input#addNew {
	background-color: lightgray;
	border: none;
	border-radius: 5px;
	margin-bottom: 20px;
}

input#addNew:hover, #search:hover {
	cursor: pointer;
}
</style>



</head>
<!--
`body` tag options:

  Apply one or more of the following classes  to the body tag
  to get the desired effect

  * sidebar-collapse
  * sidebar-mini
-->
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!--  Navbar -->
		<%@ include file="/templates/backstage/common/navbar.jsp"%>
		<!-- /.navbar -->

		<!-- 左邊選單區 Main Sidebar Container -->
		<%@ include file="/templates/backstage/common/sidebar.jsp"%>
		<!-- /.aside -->

		<!-- 中間頁面 Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<c:if test="${not empty errorMsgs}">
						<font style="color: red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message.value}</li>
							</c:forEach>
						</ul>
					</c:if>
					<form
						action="${pageContext.request.contextPath}/ipet-back/roomType/updateRoomType"
						method="post" enctype="multipart/form-data">
						<table id="roomTypedata">
							<tr>
								<td>房型編號:</td>
								<td>${roomTypeVO.roomTypeId}</td>
							</tr>
							<tr>
								<td>房間數量:</td>
								<td><input type="TEXT" name="roomAmount" size="45"
									value="${roomTypeVO.roomAmount}" /></td>
							</tr>
							<tr>
								<td>房間名稱:</td>
								<td><input type="TEXT" name="roomTypeName" size="45"
									value="${roomTypeVO.roomTypeName}" /></td>
							</tr>
							<tr>
								<td>寵物體型:</td>
								<td><select name="dogSize">
										<option value="小型犬"
											${roomType.getDogSize() == "小型犬" ?'selected':''}>小型犬</option>
										<option value="中型犬"
											${room.getDogSize() == "中型犬" ?'selected':''}>中型犬</option>
										<option value="大型犬"
											${room.getDogSize() == "大型犬" ?'selected':''}>中型犬</option>
								</select></td>
							</tr>
							<tr>
								<td>房型內容:</td>
								<td><textarea name="roomTypeContent" cols="43">${roomTypeVO.roomTypeContent}</textarea></td>
							</tr>
							<tr>
								<td>寵物圖片</td>
								<td><div class="input-group mb-3">
										<input type="file" class="form-control" id="inputGroupFile02"
											name="roomTypePhoto"> <label class="input-group-text"
											for="inputGroupFile02">Upload</label>
									</div></td>
							</tr>
							<tr>
								<td>房型價格:</td>
								<td><input type="TEXT" name="roomTypePrice" size="45"
									value="${roomTypeVO.roomTypePrice}" /></td>
							</tr>
							<tr>
								<td>上下架狀態:</td>
								<td><select name="roomTypeStatus">
										<option value="0"
											${room.getRoomTypeStatus() == 0 ?'selected':''}>上架</option>
										<option value="1"
											${room.getRoomTypeStatus() == 1 ?'selected':''}>下架</option>
								</select></td>
							</tr>
							<tr>
								<td><input type="hidden" name="action" value="update">
									<input type="hidden" name="roomTypeId"
									value="${roomTypeVO.roomTypeId}"></td>
								<td><input type="submit" value="送出修改"></td>
							</tr>
						</table>
					</form>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->

			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->


		<!-- Main Footer -->
		<%@ include file="/templates/backstage/common/footer.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED SCRIPTS -->

	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script
		src="${pageContext.request.contextPath}/static/backstage/js/adminlte.js"></script>
	<script>
		$("p:contains(房型管理)").closest("li").addClass("menu-open");
		$("p:contains(房型列表)").closest("a").addClass("active");
	</script>
</body>
</html>
