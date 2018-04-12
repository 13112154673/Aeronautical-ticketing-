<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>

<title>航空票务管理系统后台</title>
</head>
<body>
	<div class="jumbotron">
  		<div class="container" align="center">
      	<h2 class="text-info" style="font-family:宋体;font-weight:bold;font-size:49px">航空票务系统</h2>
      	<br>
      	<div class="text-muted">后台管理</div>
      	<br>
      	<br>
      	<div>
      		<form action="Backstage/loginstaff" method="post">
				<fieldset >
					<legend class="text-center">员工登陆</legend>
						员工号：<br>
						<input type="text" name="sId" value="">${error}
						<br>
						密码：<br>
						<input type="password" name="password" value="">
						<br><br>
						<input type="submit" value="登陆">
				</fieldset>
			</form>	
		</div>
  	</div>
</div>
</body>
</html>