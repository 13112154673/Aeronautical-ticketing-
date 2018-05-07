<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap需要JQuery才能正常工作，所以需要导入jquery.min.js
	接着是 Bootstrap的css，里面定义了各种样式
	最后是 Bootstrap的js，用于产生交互效果，比如关闭警告框 -->
<link href="../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="../js/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/bootstrap/3.3.6/bootstrap.min.js"></script>

<title>乘客登陆页面</title>
</head>
<!-- 贴在顶部(不会消失） -->
<style>
  body{
    padding-top:70px;
  }
</style>
<body>
	<!-- 贴在顶部(不会消失） -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="text-right">
 	 		<button class="btn btn-info" onclick="javascrtpt:window.location.href='../index.jsp'">首页</button>
 	 		<button class="btn btn-default" onclick="javascrtpt:window.location.href='jumpRegister'">注册</button>
 	 	</div>
	</nav>
	
	<div class="panel panel-default">
		<div class="text-center">
			<form action="login" method="post">
				<fieldset >
					<legend class="text-center">用户登录</legend>
						手机号：<br>
						<input type="text" name="phone" id="phone" value="">
						<br>
						密码：<br>
						<input type="password" name="password" id="password" value="">
						<br>${error}<br>
						<input type="submit" onclick="return notempty()" value="登录">
				</fieldset>
			</form>	
		</div>
	</div>
</body>
<script>
function notempty() {
		var phone=document.getElementById("phone").value;
		var	password=document.getElementById("password").value;
		
		if ("" == phone || "" == password) {
			alert("信息未填完整");
			return false;
		}
	}
</script>
</html>

