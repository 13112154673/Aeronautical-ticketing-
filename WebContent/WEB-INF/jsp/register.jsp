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

<title>乘客注册页面</title>


</head>
<!-- 贴在顶部(不会消失） -->
<style>
body {
	padding-top: 70px;
}
</style>
<body>
	<!-- 贴在顶部(不会消失） -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="text-right">
		<button class="btn btn-info"
			onclick="javascrtpt:window.location.href='../index.jsp'">首页</button>
		<button class="btn btn-success"
			onclick="javascrtpt:window.location.href='jumpLogin'">登陆</button>
	</div>
	</nav>

	<div class="panel panel-default">
		<form action="register" method="post">
			<div class="text-center">
				<fieldset>
					<legend class="text-center">用户注册</legend>
					<legend class="text-center">基本信息</legend>
					<font color="red">*</font> 姓名<br /> <input type="text"
						name="pName" id="pName" value=""><br /> <font color="red">*</font>
					性别<br /> 男<input type="radio" checked="checked" name="sex"
						value="男"> 女<input type="radio" name="sex" value="女">
					<br /> 居住城市<br /> <input type="text" name="city" value="">
					<br /> <font color="red">*</font>生日<br /> <input type="text"
						name="brithday" id="brithday" value=""> <br />

					<legend class="text-center">安全信息</legend>
					<font color="red">*</font> 身份证<br /> <input type="text" name="pId"
						id="pId" value=""> <br /> <font color="red">*</font> 密码<br />
					<input type="password" name="password" id="password" value=""><br />
					<font color="red">*</font> 确认密码<br /> <input type="password"
						name="rpassword" id="rpassword" value=""><br />

					<legend class="text-center">联系方式</legend>
					<font color="red">*</font> 手机号码（该项将作为您的登陆账号）<br /> <input
						name="phone" id="phone" type="text" value="">
					<div id="checkResult"></div>
					<br /> 电子邮箱<br /> <input type="text" name="email" value="">
					<br /> <input type="submit" onclick="return notempty()" value="提交">
					<input type="reset" value="重置">
				</fieldset>
			</div>
		</form>
	</div>
</body>

<script src="../layDate-v5.0.9/laydate/laydate.js"></script>
<!-- 改成你的路径 -->
<script>
	//执行一个laydate实例
	laydate.render({
		elem : '#brithday' //指定元素
	});
</script>
<script>
	//验证所需输入不为空和两次密码是否一致
	function notempty() {
		var phone = $("#phone").val();
		var pName = $("#pName").val();
		var sex = $("input[name='sex']:checked").val();
		var pId = $("#pId").val();
		var password = $("#password").val();
		var rpassword = $("#rpassword").val();
		var brithday = $("#brithday").val();
		if ("" == phone || "" == pName || "" == sex || "" == pId
				|| "" == password || "" == rpassword || "" == brithday) {
			alert("信息未填完整");
			return false;
		}
		if (rpassword!=password) {
			alert("两次输入密码不一致");
			$("#password").val("");
			$("#rpassword").val("");
			return false;
		}
	}
	

	/* 不刷新验证手机号码是否重复 */
	$(function() {
		$("#phone").keyup(
				function() {
					var phone = $(this).val();
					$.ajax({
						type : "post",
						url : "cheackPhone",
						data : {
							phone : phone
						},
						success : function(data) {
							if ("true" == data) {
								$("#checkResult").html("");
								$("#checkResult").append(
										"<font color='greet'>该手机号可使用</font>");
							} else if ("false" == data) {
								$("#checkResult").html("");
								$("#checkResult").append(
										"<font color='red'>该手机号已被注册</font>");
							}
						}
					});
				});
	});
</script>

</html>
