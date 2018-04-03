<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- Bootstrap需要JQuery才能正常工作，所以需要导入jquery.min.js
	接着是 Bootstrap的css，里面定义了各种样式
	最后是 Bootstrap的js，用于产生交互效果，比如关闭警告框 -->
<link href="../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="../js/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 日期插件 -->
<script src="../layDate-v5.0.9/laydate/laydate.js"></script>

<title>个人信息</title>
</head>
<!-- 贴在顶部(不会消失） -->
<style>
body {
	padding-top: 70px;
}

div.container div.row div {
	margin: 5px 0px;
}

div.container div.row div {
	background-color: lightgray;
	border: 1px solid gray;
	text-align: center;
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
	<div class="container">
		<div class="row">
			<div class="col-xs-12 ">
				<table class="table table-hover" id="table1">
					<tbody>
						<form action="findFlight" method="post">
							<tr>
								<td>出发地点:<input type="text" name="departurePlace"></td>
								<td>到达地点:<input type="text" name="arrivalPlace"></td>

								<td>出发时间:<input type="text" name="departureTime"
									id="departureTime"></td>
								<td><input type="submit" value="重新搜索" /></td>
							</tr>
						</form>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-xs-6 ">6格</div>
			<div class="col-xs-2 ">头等舱</div>
			<div class="col-xs-2 ">经济舱</div>
			<div class="col-xs-2 ">剩余座位</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-xs-6 ">6格</div>
			<div class="col-xs-2 ">头等舱</div>
			<div class="col-xs-2 ">经济舱</div>
			<div class="col-xs-2 ">剩余座位</div>
		</div>
	</div>
</body>
</html>