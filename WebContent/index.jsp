<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>

<title>航空票务管理系统</title>
</head>
<!-- 贴在顶部(不会消失） -->
<style>
body {
	padding-top: 70px;
}

.align-center {
	position: absolute;
	top: 50%;
	height: 240px;
	margin-top: -120px; /* negative half of the height */
	background-color: #EFEFEF
}
</style>
<body>
	<!-- 贴在顶部(不会消失） -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="text-right">
		<button class="btn btn-info"
			onclick="javascrtpt:window.location.href='index.jsp'">首页</button>
		<c:choose>
			<c:when test="${onlinePassenger==null}">
				<button class="btn btn-success"
					onclick="javascrtpt:window.location.href='Passenger/jumpLogin'">登陆</button>
				<button class="btn btn-default"
					onclick="javascrtpt:window.location.href='Passenger/jumpRegister'">注册</button>
			</c:when>
			<c:otherwise>
				<button class="btn btn-success"
					onclick="javascrtpt:window.location.href='Passenger/jumpInformation'">个人</button>
				<button class="btn btn-default"
					onclick="javascrtpt:window.location.href='Passenger/logout'">注销</button>
			</c:otherwise>
		</c:choose>
	</div>
	</nav>
	<div>
		名字：${onlinePassenger.pName}
		<button class="btn btn-default"
			onclick="javascrtpt:window.location.href='CreatTicket/detailedSearch'">注销</button>
		<br />
		<div class="align-center">
			<div class="container">
				<div class="row clearfix">
					<div class="col-md-4 column">
						<ul id="myTab" class="nav nav-tabs">
							<li class="active"><a href="#findflight" data-toggle="tab">
									预定航班 </a></li>
							<li><a href="#findticket" data-toggle="tab">查询机票</a></li>
						</ul>


						<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade in active" id="findflight">

								<table class="table table-hover" id="table1" >
									<tbody>
										<form action="CreatTicket/detailedSearch" method="post">
											<tr>
												<td>出发地点:<input type="text" class="form-control" name="departurePlace"></td>
												<td>到达地点:<input type="text" class="form-control" name="arrivalPlace"></td>
											</tr>
											<tr>
												<td>出发时间:<input type="text" class="form-control" name="departureTime"></td>
												<td><input type="submit" class="btn btn-default" value="确认" /></td>
											</tr>

										</form>
									</tbody>
								</table>
							</div>
							<div class="tab-pane fade" id="findticket">
								请输入机票编号：<br> <input type="text" class="form-control" id="findTicketByTId"
									name="findTicketByTId">
								<button class="btn btn-primary " data-toggle="modal"
									data-target="#myModal" onclick="findDate(this)">查找</button>
							</div>


							<div style="height: 200px"></div>
						</div>
					</div>
					<div class="col-md-4 column">
						<div class="panel-group" id="panel-543132">
							<div class="panel panel-default">
								<div class="panel-heading">
									<a class="panel-title collapsed" href="#panel-element-653283"
										data-toggle="collapse" data-parent="#panel-543132">购票须知</a>
								</div>
								<div class="panel-collapse collapse" id="panel-element-653283">
									<div class="panel-body">待编辑</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading">
									<a class="panel-title" href="#panel-element-58817"
										data-toggle="collapse" data-parent="#panel-543132">出行注意</a>
								</div>
								<div class="panel-collapse in" id="panel-element-58817">
									<div class="panel-body">待编辑</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 模态框，弹出根据机票编号查找到的机票页面 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">查询机票</h4>
					</div>
					<div class="modal-body">
						机票编号：<input type="text" class="form-control" id="tId">
						机票信息：
						<table id="tickettable">
							<tbody>
								<tr>
									<td>出发地点:<input type="text" class="form-control" id="finddeparturePlace" disabled="true"></td>
									<td>到达地点:<input type="text" class="form-control" id="findarrivalPlace" disabled="true"></td>
								</tr>
								<tr>
									<td>出发时间:<input type="text" class="form-control" id="finddepartureTime" disabled="true"></td>
									<td>到达时间:<input type="text" class="form-control" id="findarrivalTime" disabled="true"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
</body>
<script>
function findDate(obj){
	var tId=document.getElementById("findTicketByTId").value;
	$('#tId').val(tId);
	
	$.ajax({
		type : "post",
		dataType : "json",
		url : "CreatTicket/findTicketByTId",
		data : {
			tId : tId
		},
		success : function(data) {
			$('#finddeparturePlace').val(data["departurePlace"]);
			$('#findarrivalPlace').val(data["arrivalPlace"]);
			$('#finddepartureTime').val(data["departureTime"]);
			$('#findarrivalTime').val(data["arrivalTime"]);
		},
		error : function() {
			alert("查询失败");
		}
	});
};
</script>
</html>



